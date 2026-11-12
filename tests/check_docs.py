#!/usr/bin/env python3
"""Check maintained Markdown without network access or third-party packages."""
from __future__ import annotations

import html
from pathlib import Path
import re
import sys
import unicodedata
from urllib.parse import unquote, urlsplit


def mask_code(text: str, inline: bool = True) -> str:
    """Mask code, preserving offsets so link destinations can also be rewritten."""
    out = []
    fence = None
    for line in text.splitlines(keepends=True):
        match = re.match(r"^[ \t]*(`{3,}|~{3,})", line)
        if fence is not None:
            out.append(re.sub(r"[^\n]", " ", line))
            if match and match[1][0] == fence[0] and len(match[1]) >= len(fence) and not line[match.end():].strip():
                fence = None
        elif match:
            fence = match[1]
            out.append(re.sub(r"[^\n]", " ", line))
        else:
            out.append(line)
    result = "".join(out)
    if inline:
        result = re.sub(r"(`+)(.*?)\1", lambda m: re.sub(r"[^\n]", " ", m[0]), result, flags=re.S)
    return result


def destination_end(text: str, start: int) -> tuple[int, int]:
    if start >= len(text):
        return start, start
    if text[start] == "<":
        end = text.find(">", start + 1)
        return (start + 1, end) if end >= 0 else (start, start)
    depth = 0
    i = start
    while i < len(text):
        char = text[i]
        if char == "\\" and i + 1 < len(text):
            i += 2
            continue
        if char.isspace() or (char == ")" and depth == 0):
            break
        if char == "(":
            depth += 1
        elif char == ")":
            depth -= 1
        i += 1
    return start, i


def link_spans(text: str) -> list[tuple[int, int]]:
    """Destinations of inline/image/reference links and HTML href/src attributes."""
    view = mask_code(text)
    spans = set()
    patterns = (r"\]\([ \t]*", r"(?m)^[ \t]{0,3}\[[^\]\n]+\]:[ \t]*")
    for pattern in patterns:
        for match in re.finditer(pattern, view):
            start, end = destination_end(view, match.end())
            if end > start:
                spans.add((start, end))
    for match in re.finditer(r"(?:href|src)\s*=\s*([\"'])(.*?)\1", view, re.I):
        spans.add(match.span(2))
    return sorted(spans)


def slug(text: str) -> str:
    text = re.sub(r"!?(\[([^\]]+)\])\([^)]*\)", r"\2", text)
    text = html.unescape(re.sub(r"<[^>]*>", "", text))
    text = re.sub(r"(?<!\w)(\*{1,3}|_{1,3})(.+?)\1(?!\w)", r"\2", text)
    text = text.replace("`", "").replace("\\", "").lower()
    text = "".join(c for c in text if c in "_-" or unicodedata.category(c)[0] not in "PS")
    return re.sub(r"\s", "-", text.strip())


def anchors(text: str) -> set[str]:
    view = mask_code(text, inline=False)
    result = set(re.findall(r"(?:id|name)\s*=\s*[\"']([^\"']+)[\"']", view, re.I))
    used = set()
    lines = view.splitlines()
    for number, line in enumerate(lines):
        match = re.match(r"^ {0,3}#{1,6}[ \t]+(.*?)[ \t]*#*[ \t]*$", line)
        heading = match[1] if match else None
        if heading is None and number + 1 < len(lines) and line.strip() and re.match(r"^ {0,3}(?:=+|-+)[ \t]*$", lines[number + 1]):
            heading = line.strip()
        if heading is not None:
            base = slug(heading)
            candidate = base
            suffix = 0
            while candidate in used:
                suffix += 1
                candidate = f"{base}-{suffix}"
            used.add(candidate)
            result.add(candidate)
    return result


def documents(root: Path) -> list[Path]:
    paths = list(root.glob("*.md")) + list((root / "docs").rglob("*.md"))
    for extra in (root / "archive/README.md", root / "tests/README.md"):
        if extra.is_file():
            paths.append(extra)
    return sorted(set(paths))


def check_repo(root: Path) -> tuple[list[str], int, int]:
    root = root.resolve()
    errors = []
    checked = 0
    files = documents(root)
    if not (root / "README.md").is_file() or not (root / "docs").is_dir():
        errors.append("README.md and docs/ are required; run against a repository checkout")
    cache = {}
    for path in files:
        text = path.read_text(encoding="utf-8")
        visible = mask_code(text, inline=False)
        title_count = len(re.findall(r"(?m)^#\s+", visible))
        if title_count != 1:
            errors.append(f"{path.relative_to(root)}: expected one top-level title, found {title_count}")
        # Repository commands must follow moved files too, even inside code fences.
        for match in re.finditer(r"\b(?:test[ \t]+-f|bash|python3)[ \t]+((?:docs|tests|config)/[A-Za-z0-9_./-]+)", text):
            target = root / match[1]
            if not target.is_file():
                line = text[:match.start()].count("\n") + 1
                errors.append(f"{path.relative_to(root)}:{line}: missing repository command target: {match[1]}")
        for start, end in link_spans(text):
            value = html.unescape(text[start:end])
            value = re.sub(r"\\([() ])", r"\1", value)
            parsed = urlsplit(value)
            if parsed.scheme or parsed.netloc:
                continue
            checked += 1
            source = path.relative_to(root)
            line = text[:start].count("\n") + 1
            local = unquote(parsed.path)
            target = (root / local.lstrip("/") if local.startswith("/") else path.parent / local).resolve() if local else path
            try:
                target.relative_to(root)
            except ValueError:
                errors.append(f"{source}:{line}: link escapes repository: {value}")
                continue
            if not target.exists():
                errors.append(f"{source}:{line}: missing target: {value}")
                continue
            if parsed.fragment:
                if target.is_dir():
                    target = target / "README.md"
                if target.suffix.lower() == ".md" and target.is_file():
                    if target not in cache:
                        cache[target] = anchors(target.read_text(encoding="utf-8"))
                    fragment = unquote(parsed.fragment)
                    if fragment not in cache[target] and fragment.removeprefix("user-content-") not in cache[target]:
                        errors.append(f"{source}:{line}: missing anchor: {value}")
    return errors, len(files), checked


def main() -> int:
    root = Path(__file__).resolve().parents[1]
    errors, count, links = check_repo(root)
    if errors:
        print("\n".join(errors), file=sys.stderr)
        return 1
    print(f"PASS: {count} maintained Markdown files; {links} local links and anchors")
    print("External URLs and archived historical records are not revalidated.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
