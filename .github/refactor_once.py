#!/usr/bin/env python3
"""One-time, branch-scoped documentation migration; removed before PR delivery."""
from collections import Counter
from pathlib import Path
import posixpath
import re
import subprocess
import sys
from urllib.parse import quote, unquote, urlsplit

ROOT = Path(__file__).resolve().parents[1]
BASE = '8f22389e563a6b1376a36eef74b26e36bd6a3659'
REPOSITORY = 'xiongxianfei/terminal-first-windows-dev'
BRANCH = 'refactor/personal-knowledge-base-20261112'
sys.path.insert(0, str(ROOT / 'tests'))
from check_docs import link_spans, mask_code, slug

ROUTES = {
    'docs/guides/01-windows-host.md': 'docs/windows/setup.md',
    'docs/guides/02-wsl2-ubuntu.md': 'docs/windows/wsl.md',
    'docs/guides/03-ubuntu-baseline.md': 'docs/linux/ubuntu-setup.md',
    'docs/guides/04-neovim.md': 'docs/tools/neovim.md',
    'docs/guides/05-tmux.md': 'docs/tools/tmux.md',
    'docs/guides/06-uv.md': 'docs/tools/uv.md',
    'docs/guides/99-verification.md': 'docs/windows/verification.md',
    'docs/guides/proxy-setup.md': 'docs/networking/proxy.md',
    'docs/guides/wsl-ubuntu-install.md': 'docs/windows/wsl-ubuntu-install.md',
    'docs/guides/wsl-ubuntu-migration.md': 'docs/windows/wsl-ubuntu-migration.md',
    'docs/troubleshooting/enterprise-policy.md': 'docs/windows/setup.md',
    'docs/troubleshooting/ubuntu-baseline.md': 'docs/linux/ubuntu-setup.md',
    'docs/troubleshooting/proxy.md': 'docs/networking/proxy.md',
    'docs/troubleshooting/wsl.md': 'docs/windows/wsl-troubleshooting.md',
}
MERGES = {
    'docs/guides/01-windows-host.md': ['docs/troubleshooting/enterprise-policy.md'],
    'docs/guides/03-ubuntu-baseline.md': ['docs/troubleshooting/ubuntu-baseline.md'],
    'docs/guides/proxy-setup.md': ['docs/troubleshooting/proxy.md'],
}
RETAINED_TESTS = {
    'tests/markdown/m2-windows-wsl-storage.test.sh': 'tests/markdown/windows-wsl.test.sh',
    'tests/markdown/m3-ubuntu-baseline.test.sh': 'tests/markdown/ubuntu-baseline.test.sh',
    'tests/markdown/m4-neovim-tmux.test.sh': 'tests/markdown/neovim-tmux.test.sh',
}

README = '''# Terminal-First Development Notes

A personal knowledge base for terminal-first development: setup, configuration, daily use, and troubleshooting. Organize notes by **platform or tool**, not by project phase.

## Topics

| Area | Notes |
| --- | --- |
| Windows | [Host and PowerShell setup](docs/windows/setup.md), [WSL2 Ubuntu](docs/windows/wsl.md), [WSL troubleshooting](docs/windows/wsl-troubleshooting.md), [verification](docs/windows/verification.md) |
| Linux | [Ubuntu baseline](docs/linux/ubuntu-setup.md) — currently written for Ubuntu in WSL2 |
| Tools | [Neovim](docs/tools/neovim.md), [tmux](docs/tools/tmux.md), [uv](docs/tools/uv.md) |
| Networking | [WSL proxy setup and troubleshooting](docs/networking/proxy.md) |
| Configuration | [Neovim](config/nvim/init.lua), [tmux](config/tmux/tmux.conf) — canonical reusable files |

## Windows/WSL setup path

For a fresh workstation: [Windows host](docs/windows/setup.md) → [WSL install or migration](docs/windows/wsl.md) → [Ubuntu baseline](docs/linux/ubuntu-setup.md) → [Neovim](docs/tools/neovim.md) / [tmux](docs/tools/tmux.md) → [verification](docs/windows/verification.md). [uv](docs/tools/uv.md) is optional.

## Scope and verification

The knowledge base can grow across Windows, Linux, and macOS. Current executable guidance is primarily Windows 11 and WSL2 Ubuntu; a planned platform is not a tested platform. Add a macOS folder only when there are actual notes to maintain.

Read each note's prerequisites and safety warnings. Administrator privileges, destructive operations, certificate trust, package sources, mounts, and sudoers changes require particular care. This is not an unattended installer.

The repository reorganization preserves existing commands and configurations; it does not certify their current versions or prove that setup succeeds on your machine. Use the verification steps and record the platform, versions, date, and results when you test a procedure.

## Maintenance

Keep one home per topic and troubleshooting next to the relevant instructions. Link to `config/` rather than copying entire configurations into notes. See [CONTRIBUTING.md](CONTRIBUTING.md) for the small note format and checks, and [AGENTS.md](AGENTS.md) for editing rules.

[Historical records and old-to-new paths](archive/README.md) are preserved separately; they no longer define the active workflow.
'''

AGENTS = '''# Agent Guide

This is a personal development knowledge base, organized by platform and tool. The [README](README.md) is the current scope and navigation; [CONTRIBUTING](CONTRIBUTING.md) describes editing and checks.

- Keep changes small. Prefer an existing topic over a new folder or duplicate note.
- Keep reusable configurations in `config/`; do not change their behavior during a documentation-only reorganization.
- Keep platform assumptions explicit. WSL-specific settings are not generic Linux defaults; planned macOS support is not tested guidance.
- Keep elevation, destructive actions, trust changes, and machine-wide effects visible beside the relevant commands. Preserve prerequisites, backups, verification, and rollback guidance.
- Never commit secrets, credentials, private machine identifiers, or exported certificate material.
- Record meaningful behavior changes and validation in the pull request. Notes do not require separate proposals, specifications, architecture documents, or review logs.
- Run the documented checks and inspect the diff. Distinguish static documentation checks from actual Windows/WSL execution; never invent test results.
- `archive/legacy/` contains historical evidence, not active instructions or governing rules. Do not rewrite its historical claims to look current.
'''

CONTRIBUTING = '''# Maintaining the Notes

## Where content belongs

Use `docs/windows/` and `docs/linux/` for platform-specific behavior, `docs/tools/` for shared tool knowledge, and `docs/networking/` for network topics. Create `docs/macos/` only with real content. Put reusable files in `config/` and link to them.

Prefer one note per topic. A long topic may have separate task pages, such as WSL installation and migration; keep them together and linked. Add new notes to the root [topic index](README.md#topics).

## Small note format

Use the sections the topic actually needs:

```markdown
# Topic

Purpose and applicable platform/version.

## Steps
Commands, prerequisites, and nearby safety/backup notes.

## Verification
Expected results; tested platform/version/date, or explicitly not tested.

## Troubleshooting
Symptoms, checks, fixes, and rollback where relevant.
```

Existing longer guides may retain their fast path and walkthrough. Do not duplicate entire configuration files or invent test dates. Prefer official references for new technical claims.

## Checks

From the repository root, using Python 3.10+ and Bash (for example, in WSL):

```bash
python3 -m unittest discover -s tests -p 'test_*.py' -v
python3 tests/check_docs.py
for test in tests/markdown/*.test.sh; do
  bash "$test" || exit 1
done
```

The Python checker validates maintained Markdown titles, local file links, and heading anchors, including the archive index. It skips fenced and inline code examples. The retained shell checks cover Windows/WSL, Ubuntu safety guidance, and Neovim/tmux configurations; they do not execute setup commands.

External URLs and frozen records under `archive/legacy/` are not revalidated. These checks do not prove that Windows, WSL, package installation, networking, or editor startup works. Report any manual checks separately.

## Changes

Use a focused pull request with the reason, changed topics, and actual check results. No separate specification or review-log hierarchy is required for ordinary notes. Keep historical records in [the archive](archive/README.md), not in the active navigation.
'''

WSL = '''# WSL2 Ubuntu

Choose the task that matches the machine. This page is an index, not a second copy of setup commands.

- **Fresh installation:** [Install WSL2 Ubuntu](wsl-ubuntu-install.md).
- **Existing distro to move:** [Migrate WSL2 Ubuntu](wsl-ubuntu-migration.md). Read its backup and data-loss warnings before proceeding.
- **Failures or unsupported options:** [WSL troubleshooting](wsl-troubleshooting.md).

After installation or migration, continue with the [Ubuntu baseline](../linux/ubuntu-setup.md) and the [Windows/WSL verification checklist](verification.md).

The existing procedures assume Windows 11, WSL2 Ubuntu, and the documented D-drive layout. Review those assumptions before applying them to another machine. Return to the [topic index](../../README.md#topics) for other tools.
'''


def git(*args: str) -> bytes:
    return subprocess.check_output(['git', *args], cwd=ROOT)


def code_blocks(text: str) -> Counter:
    blocks = []
    current = []
    fence = None
    for line in text.splitlines(keepends=True):
        match = re.match(r'^[ \t]*(`{3,}|~{3,})', line)
        if fence is None and match:
            fence = match[1]
            current = [line]
        elif fence is not None:
            current.append(line)
            if match and match[1][0] == fence[0] and len(match[1]) >= len(fence) and not line[match.end():].strip():
                blocks.append(''.join(current))
                fence = None
    if fence is not None:
        raise ValueError('Unclosed fenced code block in source document')
    return Counter(blocks)


def demote(text: str) -> str:
    view = mask_code(text, inline=False)
    changes = [(m.start(), m.start(), '#') for m in re.finditer(r'(?m)^#{1,5}(?=\s)', view)]
    for start, end, value in reversed(changes):
        text = text[:start] + value + text[end:]
    return text


def main() -> None:
    branch = git('branch', '--show-current').decode().strip()
    if branch != BRANCH:
        raise SystemExit(f'Refusing migration on unexpected branch: {branch}')
    names = git('ls-tree', '-r', '--name-only', BASE).decode().splitlines()
    originals = {name: git('show', f'{BASE}:{name}') for name in names}
    for name, data in originals.items():
        path = ROOT / name
        if not path.is_file() or path.read_bytes() != data:
            raise SystemExit(f'Unrelated changes detected; refusing to overwrite {name}')
    if not set(ROUTES).issubset(originals):
        raise SystemExit('The baseline does not contain every expected source note')

    destinations = {}
    for name in names:
        if name in ROUTES:
            destinations[name] = ROUTES[name]
        elif name.startswith(('docs/', 'specs/', 'tests/')) or name in {'README.md', 'AGENTS.md', 'CONTRIBUTING.md', 'CONSTITUTION.md', 'VISION.md'}:
            destinations[name] = 'archive/legacy/' + name
        else:
            destinations[name] = name
    extras = {name for group in MERGES.values() for name in group}
    default_fragments = {name: slug(originals[name].decode().splitlines()[0].lstrip('# ').strip()) for name in extras}
    old_dirs = {posixpath.dirname(name) for name in names}
    for directory in list(old_dirs):
        while '/' in directory:
            directory = posixpath.dirname(directory)
            old_dirs.add(directory)

    def rewrite(source: str, destination: str, text: str) -> str:
        replacements = []
        archived = destination.startswith('archive/legacy/')
        for start, end in link_spans(text):
            value = text[start:end]
            parsed = urlsplit(value)
            if parsed.scheme or parsed.netloc:
                continue
            raw = unquote(parsed.path)
            old = posixpath.normpath(raw.lstrip('/') if raw.startswith('/') else posixpath.join(posixpath.dirname(source), raw)) if raw else source
            suffix = ('?' + parsed.query if parsed.query else '')
            fragment = parsed.fragment
            if archived:
                kind = 'tree' if old in old_dirs else 'blob'
                updated = f'https://github.com/{REPOSITORY}/{kind}/{BASE}/' + quote(old, safe='/') + suffix
            else:
                if old in {'README.md', 'AGENTS.md', 'CONTRIBUTING.md'}:
                    target = old
                elif old in {'docs/guides', 'docs/guides/README.md', 'docs', '.'}:
                    target = 'README.md'
                elif old in destinations:
                    target = destinations[old]
                elif old in old_dirs:
                    target = 'archive/legacy/' + old if old.startswith(('specs', 'docs/', 'tests')) else old
                else:
                    raise ValueError(f'Unresolved local reference in {source}: {value}')
                if not fragment:
                    fragment = default_fragments.get(old, '')
                if old == 'docs/guides/02-wsl2-ubuntu.md' and fragment == 'wsl-ubuntu-setup-compatibility-path':
                    fragment = 'wsl2-ubuntu'
                if old == 'README.md':
                    fragment = {'setup-path': 'windowswsl-setup-path', 'scope': 'scope-and-verification', 'warning-labels': 'scope-and-verification', 'project-workflow': 'maintenance'}.get(fragment, fragment)
                relative = posixpath.relpath(target, posixpath.dirname(destination) or '.')
                updated = ('' if target == destination and fragment else quote(relative, safe='/')) + suffix
            if fragment:
                updated += '#' + fragment
            replacements.append((start, end, updated))
        for start, end, value in reversed(replacements):
            text = text[:start] + value + text[end:]
        if not archived:
            # Update inline repository-path references, but never executable fenced blocks.
            visible = mask_code(text, inline=False)
            changes = []
            for match in re.finditer(r'`([^`\n]+)`', visible):
                old = match[1]
                if old in destinations:
                    target = old if old in {'README.md', 'AGENTS.md', 'CONTRIBUTING.md'} else destinations[old]
                    changes.append((match.start(1), match.end(1), target))
            for start, end, value in reversed(changes):
                text = text[:start] + value + text[end:]
        return text

    output = {}
    for name, data in originals.items():
        if name in extras:
            continue
        destination = destinations[name]
        if name.endswith('.md'):
            text = rewrite(name, destination, data.decode('utf-8'))
            for extra in MERGES.get(name, []):
                text = text.rstrip() + '\n\n' + demote(rewrite(extra, destination, originals[extra].decode('utf-8'))).rstrip() + '\n'
            if name == 'docs/guides/02-wsl2-ubuntu.md':
                preserved = 'archive/legacy/' + name
                output[preserved] = rewrite(name, preserved, data.decode('utf-8')).encode()
                text = WSL
            if name == 'docs/guides/03-ubuntu-baseline.md':
                title, rest = text.split('\n', 1)
                text = title + '\n\n> Applies to Ubuntu in WSL2. Windows drives, `.wslconfig`, and `/etc/wsl.conf` are not general native-Linux defaults.\n' + rest
            if name == 'docs/guides/01-windows-host.md':
                text = text.replace(' This guide remains one host guide during body conformance.', '')
            if name == 'docs/guides/proxy-setup.md':
                text = text.replace('M3 documents WSL automatic proxy mirroring', 'This note documents WSL automatic proxy mirroring')
            data = text.encode('utf-8')
        if destination in output:
            raise ValueError(f'Destination collision: {destination}')
        output[destination] = data

    output.update({'README.md': README.encode(), 'AGENTS.md': AGENTS.encode(), 'CONTRIBUTING.md': CONTRIBUTING.encode()})
    for old, new in RETAINED_TESTS.items():
        text = originals[old].decode()
        for source in sorted(destinations, key=len, reverse=True):
            target = source if source in {'README.md', 'AGENTS.md', 'CONTRIBUTING.md'} else destinations[source]
            text = text.replace(source, target)
        # A check should be runnable from any working directory.
        text = text.replace('set -euo pipefail\n', 'set -euo pipefail\n\ncd "$(dirname "${BASH_SOURCE[0]}")/../.."\n', 1)
        if old.endswith('m2-windows-wsl-storage.test.sh'):
            text = text.replace("grep -q 'compatibility path'", "grep -q '^# WSL2 Ubuntu'")
            text = text.replace('WSL compatibility stub', 'WSL topic index')
        if old.endswith('m4-neovim-tmux.test.sh'):
            text = text.replace('README.md docs/guides docs/troubleshooting', 'README.md docs')
            # The old test's double backslash did not express a grep alternation.
            text = text.replace("grep -Rqi 'supports native Windows tmux\\\\|tmux works natively on Windows'", "grep -REqi 'supports native Windows tmux|tmux works natively on Windows'")
        output[new] = text.encode()

    rows = '\n'.join(f'| `{old}` | [{new}](../{new}{"#" + default_fragments[old] if old in default_fragments else ""}) |' for old, new in ROUTES.items())
    archive = f'''# Historical Records

These records describe the former Windows-only, specification-first project. They are preserved for context, not as active governance or current setup advice. Use the [current topic index](../README.md) and [editing guide](../CONTRIBUTING.md).

Baseline: [{BASE[:12]}](https://github.com/{REPOSITORY}/tree/{BASE}). The repository name and configuration behavior are unchanged.

## Preserved material

| Material | Location |
| --- | --- |
| Former scope and rules | [README](legacy/README.md), [vision](legacy/VISION.md), [constitution](legacy/CONSTITUTION.md), [agent guide](legacy/AGENTS.md), [contributing guide](legacy/CONTRIBUTING.md) |
| Decisions and architecture | [ADRs](legacy/docs/adr), [architecture](legacy/docs/architecture) |
| Proposals and specifications | [Proposals](legacy/docs/proposals), [specifications](legacy/specs) |
| Plans and review evidence | [Plans](legacy/docs/plans), [changes and reviews](legacy/docs/changes), [release notes](legacy/docs/release-notes) |
| Research and process notes | [Research](legacy/docs/research), [learning sessions](legacy/docs/learn), [templates](legacy/docs/templates), [workflows](legacy/docs/workflows.md) |
| Former navigation and tests | [Guide router](legacy/docs/guides/README.md), [WSL compatibility page](legacy/docs/guides/02-wsl2-ubuntu.md), [original test suite](legacy/tests/markdown) |

Historical Markdown links are pinned to the baseline commit so their meaning does not change when maintained notes move. Command examples, code blocks, old filenames in logs, and review claims remain historical evidence. The archived test suite is not the current validation entry point.

## Old-to-new paths

{rows and '| Former path | Maintained destination |'}
| --- | --- |
{rows}

Troubleshooting for the Windows host, Ubuntu baseline, and proxy is consolidated into the corresponding maintained note. WSL installation, migration, and troubleshooting remain separate tasks in one platform folder. macOS planning records stay archived until actual notes exist.

## Preservation and validation

All {len(originals)} baseline tracked files are accounted for by a maintained destination or historical record. Existing configuration files and executable command blocks are preserved by the migration checks. Useful Windows/WSL, Ubuntu, and Neovim/tmux checks remain under `tests/markdown/`; checks tied to the retired project workflow are archived.

See [CONTRIBUTING.md](../CONTRIBUTING.md#checks) for current checks and their limits. Static checks do not prove Windows/WSL setup success, and no new manual test dates are claimed.
'''
    output['archive/README.md'] = archive.encode()

    # Prove preservation before replacing any baseline path.
    preserved_blocks = 0
    for old, data in originals.items():
        destination = destinations[old]
        if old == 'docs/guides/02-wsl2-ubuntu.md':
            destination = 'archive/legacy/' + old
        if destination not in output:
            raise ValueError(f'Unaccounted source: {old}')
        if old.endswith('.md'):
            blocks = code_blocks(data.decode())
            if blocks - code_blocks(output[destination].decode()):
                raise ValueError(f'Executable/code example changed: {old}')
            preserved_blocks += sum(blocks.values())
        elif destination == old and output[destination] != data:
            raise ValueError(f'Unrelated file changed: {old}')
    for old in names:
        if old not in output:
            (ROOT / old).unlink()
    for name, data in output.items():
        path = ROOT / name
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_bytes(data)
    for old in names:
        if old.startswith('config/') and (ROOT / old).read_bytes() != originals[old]:
            raise ValueError(f'Configuration changed: {old}')
    for directory in sorted({p for name in names for p in (ROOT / name).parents if p != ROOT and ROOT in p.parents}, key=lambda p: len(p.parts), reverse=True):
        if directory.is_dir() and not any(directory.iterdir()):
            directory.rmdir()
    print(f'PRESERVED: {len(originals)} original files; {preserved_blocks} fenced code blocks; all config bytes unchanged')
    print(f'MIGRATED: {len(ROUTES)} source notes; {len(RETAINED_TESTS)} retained safety checks')


if __name__ == '__main__':
    main()
