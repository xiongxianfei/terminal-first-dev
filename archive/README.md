# Historical Records

These records describe the former Windows-only, specification-first project. They are preserved for context, not as active governance or current setup advice. Use the [current topic index](../README.md) and [editing guide](../CONTRIBUTING.md).

Baseline: [8f22389e563a](https://github.com/xiongxianfei/terminal-first-windows-dev/tree/8f22389e563a6b1376a36eef74b26e36bd6a3659). The repository name and configuration behavior are unchanged.

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

| Former path | Maintained destination |
| --- | --- |
| `docs/guides/01-windows-host.md` | [docs/windows/setup.md](../docs/windows/setup.md) |
| `docs/guides/02-wsl2-ubuntu.md` | [docs/windows/wsl.md](../docs/windows/wsl.md) |
| `docs/guides/03-ubuntu-baseline.md` | [docs/linux/ubuntu-setup.md](../docs/linux/ubuntu-setup.md) |
| `docs/guides/04-neovim.md` | [docs/tools/neovim.md](../docs/tools/neovim.md) |
| `docs/guides/05-tmux.md` | [docs/tools/tmux.md](../docs/tools/tmux.md) |
| `docs/guides/06-uv.md` | [docs/tools/uv.md](../docs/tools/uv.md) |
| `docs/guides/99-verification.md` | [docs/windows/verification.md](../docs/windows/verification.md) |
| `docs/guides/proxy-setup.md` | [docs/networking/proxy.md](../docs/networking/proxy.md) |
| `docs/guides/wsl-ubuntu-install.md` | [docs/windows/wsl-ubuntu-install.md](../docs/windows/wsl-ubuntu-install.md) |
| `docs/guides/wsl-ubuntu-migration.md` | [docs/windows/wsl-ubuntu-migration.md](../docs/windows/wsl-ubuntu-migration.md) |
| `docs/troubleshooting/enterprise-policy.md` | [docs/windows/setup.md](../docs/windows/setup.md#enterprise-policy-troubleshooting) |
| `docs/troubleshooting/ubuntu-baseline.md` | [docs/linux/ubuntu-setup.md](../docs/linux/ubuntu-setup.md#ubuntu-baseline-troubleshooting) |
| `docs/troubleshooting/proxy.md` | [docs/networking/proxy.md](../docs/networking/proxy.md#proxy-troubleshooting) |
| `docs/troubleshooting/wsl.md` | [docs/windows/wsl-troubleshooting.md](../docs/windows/wsl-troubleshooting.md) |

Troubleshooting for the Windows host, Ubuntu baseline, and proxy is consolidated into the corresponding maintained note. WSL installation, migration, and troubleshooting remain separate tasks in one platform folder. macOS planning records stay archived until actual notes exist.

## Preservation and validation

All 152 baseline tracked files are accounted for by a maintained destination or historical record. Configuration files are unchanged, and workstation setup commands keep their previous behavior. Repository-check commands use the current paths; their previous forms remain available in the baseline Git history. Useful Windows/WSL, Ubuntu, and Neovim/tmux checks remain under `tests/markdown/`; checks tied to the retired project workflow are archived.

See [CONTRIBUTING.md](../CONTRIBUTING.md#checks) for current checks and their limits. Static checks do not prove Windows/WSL setup success, and no new manual test dates are claimed.
