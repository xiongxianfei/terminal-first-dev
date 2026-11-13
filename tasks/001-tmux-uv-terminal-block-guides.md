# 001: Convert tmux and uv to terminal-block guides

**Date:** 2026-11-13
**Status:** Completed

## Objective

Match the concise terminal-block style of the zoxide and fzf guides, removing duplicated “Fast path” and “Walkthrough” instructions while preserving prerequisites, safety guidance, recovery steps, and existing platform coverage.

## Agreed plan

- Keep tmux scoped to Ubuntu on WSL. Sequence installation, configuration backup/copy, isolated verification, and first use; retain the keybinding table and preserve the reusable configuration's behavior.
- Put Ubuntu before Windows in uv, with separate installation blocks, explicit verification in a new terminal, and a minimal first-use example.
- Move optional package-index configuration out of installation. Show destinations, insertion points, Vim commands, exact TOML, backups, duplicate handling, saving, verification, and rollback.
- Separate upgrades and uninstall instructions, retain troubleshooting links, and place warnings beside the relevant commands.
- Consult official documentation, align tool-index installation commands, repair affected links, run repository checks, and inspect the diff.

Documentation only: no tool installations, configuration execution, new macOS coverage, helper scripts, or public API changes.

## Implemented changes

- [tmux guide](../docs/tools/tmux.md): consolidated setup blocks, added a unique disposable server for configuration verification, corrected pane-movement keys to match the configuration, and retained first use and the keybinding table.
- [uv guide](../docs/tools/uv.md): reordered platforms, added first use and explicit manual configuration steps, and made index verification read the saved settings using a disposable virtual environment and a package-resolution dry run.
- [Workstation verification](../docs/windows/verification.md#tmux-on-ubuntu): replaced duplicate tmux commands with a link to the isolated check.
- Confirmed the [tool index](../docs/tools/README.md) already matches the retained installation commands. No changes to reusable files in `config/`.

## Verification

Guide conversion checks completed on 2026-11-13:

| Check | Result |
| --- | --- |
| `python3 -m unittest discover -s tests -p 'test_*.py' -v` | Passed: 7 tests. |
| `python3 tests/check_docs.py` | Passed: 19 maintained Markdown files and 126 local links/anchors, before this task record was added. |
| Bash syntax checks with `bash -n` | Passed: 5 tmux blocks and 7 uv blocks; commands were parsed, not executed. |
| Installation-command comparison | tmux and both uv installer commands matched the tool index. |
| `git diff --check` and diff review | Passed; no reusable configuration changes. |

Platform installation, shell configuration, tmux runtime checks, uv package resolution, and PowerShell execution were skipped. The guides explicitly remain unverified on their target platforms. Official references were consulted for revised commands; the documentation checker does not validate external URLs.

The repository checker currently scans root and guide Markdown, not the contents of `tasks/`. This record's local links require separate inspection.
