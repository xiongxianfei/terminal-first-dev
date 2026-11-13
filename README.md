# Terminal-First Development Notes

A personal knowledge base for terminal-first development: setup, configuration, daily use, and troubleshooting. Target platforms, in priority order, are Ubuntu 26.04, Windows 11, and macOS. Individual tool guides cover relevant platforms only; coverage of all three is optional. See [REQS.md](REQS.md) for the project requirements.

## Topics

| Area | Notes |
| --- | --- |
| Linux | [Ubuntu baseline](docs/linux/ubuntu-setup.md) — currently written for Ubuntu in WSL2 |
| Windows | [Host and PowerShell setup](docs/windows/setup.md), [WSL2 Ubuntu](docs/windows/wsl.md), [WSL troubleshooting](docs/windows/wsl-troubleshooting.md), [verification](docs/windows/verification.md) |
| macOS | [MacBook terminal baseline](docs/macos/setup.md), [verification record](docs/macos/verification.md) — manual verification is not complete |
| Tools | [Tool recommendations, installation commands, and official resources](docs/tools/README.md) — Neovim, tmux, uv, zoxide, and fzf |
| Networking | [WSL proxy setup and troubleshooting](docs/networking/proxy.md) |
| Configuration | [Neovim](config/nvim/init.lua), [tmux](config/tmux/tmux.conf), [shell configuration](docs/tools/fzf.md) — check each guide’s platform scope and verification status |
| Tasks | [001: tmux and uv terminal-block guides](tasks/001-tmux-uv-terminal-block-guides.md), [002: official links and tool recommendations](tasks/002-official-links-and-tool-recommendations.md) — completed work and verification results |

[zoxide](docs/tools/zoxide.md) and [fzf](docs/tools/fzf.md) provide optional shell navigation; see their guides for setup.

## Windows/WSL setup path

For a fresh workstation: [Windows host](docs/windows/setup.md) → [WSL install or migration](docs/windows/wsl.md) → [Ubuntu baseline](docs/linux/ubuntu-setup.md) → [Neovim](docs/tools/neovim.md) / [tmux](docs/tools/tmux.md) → [verification](docs/windows/verification.md). [uv](docs/tools/uv.md) is optional.

## macOS setup path

Follow the [MacBook baseline](docs/macos/setup.md): ownership and backup → hardware → Apple developer tooling → Homebrew → shell, Git, SSH, and minimal editor readiness. Record results in the [macOS verification record](docs/macos/verification.md).

## Scope and verification

The existing notes cover Windows 11, Ubuntu in WSL2, and a personal MacBook baseline targeting Apple silicon. Ubuntu 26.04 is the primary target; the existing Ubuntu 24.04 references and WSL-specific baseline still need review before claiming Ubuntu 26.04 support. A native Ubuntu setup path is not yet documented. macOS manual verification is incomplete; Intel and managed-Mac setups remain unverified. Check each guide's platform assumptions and verification status before using its commands or shared configurations.

Read the prerequisites, backups, and safety warnings beside each procedure, especially for administrator access, destructive operations, certificate trust, and machine-wide changes. These are manual setup guides. Repository checks do not establish that setup works on a particular machine.

## Maintenance and origins

See [AGENTS.md](AGENTS.md) for editing guidance and validation commands.

The macOS notes were imported from `terminal-first-macos-dev`; the [import record](docs/macos/setup.md#traceability) preserves the source commit, path mapping, and attribution. Earlier project records remain available [in Git history](https://github.com/xiongxianfei/terminal-first-dev/blob/f13eb81fe167bd7902d1b707ea1370011e977ff4/archive/README.md).
