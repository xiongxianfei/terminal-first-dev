# 002: Add official links and tool recommendations

**Date:** 2026-11-13
**Status:** Completed

## Objective

Make official resources easy to find in the five existing tool guides and use the [tool index](../docs/tools/README.md) to help readers choose tools for their workflow, while preserving useful local setup and recovery guidance.

## Agreed plan

- Add a prominent official-resource link after each guide's introduction, retaining detailed references beside procedures.
- Replace the index's “Purpose” column with “Recommended when” and add “Official resources”; retain one row per tool and installation commands in platform columns.
- Recommend Neovim for terminal editing, tmux for persistent sessions and panes, uv for Python work, zoxide for frequently visited directories, and fzf for interactive selection. Explain pairing zoxide and fzf for `zi`.
- Replace Neovim's repeated fast-path steps with links to detailed installation, configuration, and verification sections; preserve heading anchors, prerequisites, commands, backups, recovery, and warnings.
- Update requirements and README navigation, check official URLs and task-record links separately, run repository checks, and inspect command alignment and the diff.

Scope: documentation for the existing five tools only. Preserve installation methods, platform coverage, reusable configurations, and verification caveats. No installations, new tool research, or public API changes.

## Implemented changes

- Added official links near the top of the [Neovim](../docs/tools/neovim.md), [tmux](../docs/tools/tmux.md), [uv](../docs/tools/uv.md), [zoxide](../docs/tools/zoxide.md), and [fzf](../docs/tools/fzf.md) guides.
- Expanded the [tool index](../docs/tools/README.md) with workflow recommendations and official resources, and clarified the zoxide/fzf pairing for `zi`.
- Shortened Neovim's [fast path](../docs/tools/neovim.md#fast-path) to section links, keeping its detailed walkthrough and recovery guidance intact.
- Added selection-summary and prominent-link requirements to [REQS.md](../REQS.md), and updated the root [topic index](../README.md#topics) with the revised tool-index description and this task record.
- Preserved existing uncommitted work, including task 001. No changes to reusable files in `config/`.

## Verification

Validation environment on 2026-11-13: Ubuntu 24.04.4 LTS on WSL2, Python 3.12.3. This identifies the documentation-check environment, not verified tool compatibility.

| Check | Result |
| --- | --- |
| `python3 -m unittest discover -s tests -p 'test_*.py' -v` | Passed: 7 tests. |
| `python3 tests/check_docs.py` | Passed: 19 maintained Markdown files and 133 local links/anchors. |
| Separate task-record link inspection | Passed: 14 local links/anchors across tasks 001 and 002. |
| Installation-command comparison | All index installation cells are unchanged and match the guides; Neovim's split APT lines and fzf's quoted `$HOME` paths are equivalent to the index forms. |
| Preservation and diff review | Neovim's detailed walkthrough, recovery sections, headings, and unique commands are preserved. The other four guides differ from their pre-task contents only by the added official link. No reusable configuration changes. |
| `git diff --check` | Passed. |

The five prominent official URLs were opened and their project content inspected on 2026-11-13: [Neovim](https://neovim.io/), [tmux](https://github.com/tmux/tmux/wiki), [uv](https://docs.astral.sh/uv/), [zoxide](https://github.com/ajeetdsouza/zoxide), and [fzf](https://github.com/junegunn/fzf). All loaded successfully. Existing detailed external references were retained, not exhaustively rechecked; the repository checker does not validate external URLs.

Tool installation, shell configuration, runtime verification, and Windows/macOS setup were skipped because this change only revises documentation links and selection guidance. Existing platform-verification caveats remain in place. The repository checker excludes task-record contents, so their local links require a separate check.
