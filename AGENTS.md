# Maintenance and Agent Guide

This is a personal development knowledge base, organized by platform and tool. [REQS.md](REQS.md) defines user requirements; [README.md](README.md) describes current coverage and navigation. This guide describes how to edit and verify the repository.

## Editing rules

- Follow REQS.md when adding or revising guides. Update requirements when user needs or target platforms change; keep repository conventions here and record actual coverage and verification in the relevant guides.
- Keep changes small. Prefer an existing topic over a new folder or duplicate note. A long topic may have separate task pages; keep them together and linked.
- Keep reusable configurations in `config/` and link to them instead of copying them into notes. Do not change their behavior during a documentation-only reorganization.
- Add new notes to the README [topic index](README.md#topics).
- Prefer official references for new technical claims.
- Use Vim by default in file-editing examples. State that Vim must be installed and available on PATH.
- For manual edits, separate “Run in terminal,” “Add to the file,” and “Verify in a new terminal.” Name the destination and insertion point, show exact file contents in their own block, and explain saving and duplicate handling. Check installer-created entries before adding them. Keep upgrade and uninstall separate from quick-start blocks.
- Include platform sections only when useful; do not add commands or duplicate descriptions merely to cover all three project platforms. Review existing coverage for usefulness before adding or removing sections.
- Keep platform assumptions explicit. Preserve prerequisites, backups, verification, rollback guidance, and warnings about elevation, destructive actions, trust changes, and machine-wide effects beside the relevant commands.
- Never commit secrets, credentials, private machine identifiers, or exported certificate material.
- Preserve imported attribution and pinned source links. Record the source commit, path mapping, and license near imported notes. Historical records stay in Git history and are not current guidance.

## Content organization

Use `docs/windows/`, `docs/linux/`, and `docs/macos/` for platform-specific behavior, `docs/tools/` for shared tool knowledge, and `docs/networking/` for network topics.

Maintain one record per tool in [docs/tools/tools.json](docs/tools/tools.json), the sole tool summary. Edit JSON directly; no Markdown table is generated. Keep the existing fields: `name`, repository-relative `guide`, `recommended_when`, platform commands in `install`, and `official` label/URL. Store commands as literal single-line text using JSON escaping only; `null` means the guide does not cover that platform, not that the tool is unsupported. Keep names unique and commands aligned with the individual guides, which remain the source for detailed procedures, prerequisites, and warnings.

## Task records

Use the installed `task-writer` skill to create and maintain repository work records. If it is unavailable, report the missing skill rather than inventing a local substitute.

- Save records in `tasks/NNN-short-description.md`, using the next unused number and a lowercase, hyphen-separated description. Never renumber records or reuse numbers; keep the date inside the file.
- Include the required repository verification results and inspect task links separately, since the documentation checker excludes task contents.
- Honor requests to show a draft before saving. Task records do not need README entries.

## Checks

Run these checks from the repository root with Python 3.10+, then inspect the diff:

```bash
python3 -m unittest discover -s tests -p 'test_*.py' -v
python3 tests/check_docs.py
git diff --check
```

These checks validate documentation and test the documentation checker; they do not execute tool installation or shell configuration, or verify real Windows, WSL, or macOS setup. External URLs are not checked.

Report meaningful behavior changes, actual check results, and skips in the pull request or handoff. Record the platform, versions, date, and results for manual verification; never invent test results or compatibility claims.

## Engineering Principles

1. **Three strikes, then reassess.** After three repetitions or failed attempts, reconsider the approach; refactor when justified.
2. **First principles, core verification.** Identify the root cause, solve the underlying problem, and test essential behavior.
3. **Design first, keep it modular.** Favor high cohesion, low coupling, clear boundaries, and simple designs.
