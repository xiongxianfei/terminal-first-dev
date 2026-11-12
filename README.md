# Terminal-First Development Notes

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

The repository reorganization preserves workstation setup commands and configurations; it does not certify their current versions or prove that setup succeeds on your machine. Repository validation commands are updated to the new paths. Use the verification steps and record the platform, versions, date, and results when you test a procedure.

## Maintenance

Keep one home per topic and troubleshooting next to the relevant instructions. Link to `config/` rather than copying entire configurations into notes. See [CONTRIBUTING.md](CONTRIBUTING.md) for the small note format and checks, and [AGENTS.md](AGENTS.md) for editing rules.

[Historical records and old-to-new paths](archive/README.md) are preserved separately; they no longer define the active workflow.
