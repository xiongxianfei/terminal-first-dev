# Terminal-First Development Notes

A personal knowledge base for terminal-first development across Windows, Linux, and macOS: setup, configuration, daily use, and troubleshooting. Organize notes by **platform or tool**, not by project phase.

## Topics

| Area | Notes |
| --- | --- |
| Windows | [Host and PowerShell setup](docs/windows/setup.md), [WSL2 Ubuntu](docs/windows/wsl.md), [WSL troubleshooting](docs/windows/wsl-troubleshooting.md), [verification](docs/windows/verification.md) |
| Linux | [Ubuntu baseline](docs/linux/ubuntu-setup.md) — currently written for Ubuntu in WSL2 |
| macOS | [MacBook terminal baseline](docs/macos/setup.md), [verification record](docs/macos/verification.md) — manual verification is not complete |
| Tools | [Neovim](docs/tools/neovim.md), [tmux](docs/tools/tmux.md), [uv](docs/tools/uv.md), [zoxide](docs/tools/zoxide.md), [fzf](docs/tools/fzf.md) |
| Networking | [WSL proxy setup and troubleshooting](docs/networking/proxy.md) |
| Configuration | [Neovim](config/nvim/init.lua), [tmux](config/tmux/tmux.conf), [shell navigation snippets](docs/tools/fzf.md#enable-the-shared-shell-snippet) — canonical reusable files; check each platform's verification boundary |

Optional navigation: install [zoxide](docs/tools/zoxide.md) and [fzf](docs/tools/fzf.md), then enable one shell-specific snippet. These tools are not required by either setup path. PowerShell fzf keybindings require an additional explicit PSFzf opt-in; `zi` does not require that module.

## Windows/WSL setup path

For a fresh workstation: [Windows host](docs/windows/setup.md) → [WSL install or migration](docs/windows/wsl.md) → [Ubuntu baseline](docs/linux/ubuntu-setup.md) → [Neovim](docs/tools/neovim.md) / [tmux](docs/tools/tmux.md) → [verification](docs/windows/verification.md). [uv](docs/tools/uv.md) is optional.

## macOS setup path

Follow the [MacBook baseline](docs/macos/setup.md): ownership and backup → hardware → Apple developer tooling → Homebrew → shell, Git, SSH, and minimal editor readiness. Record results in the [macOS verification record](docs/macos/verification.md).

Apple silicon is the intended primary target, not a verified compatibility claim. Intel and managed-Mac setup remain unverified. Do not apply Windows/WSL-specific instructions or assume shared configurations work on macOS without checking their scope.

## Scope and verification

Current notes cover Windows 11, Ubuntu in WSL2, and a personal MacBook baseline. Each note owns its platform assumptions and verification status; organizing notes together does not make every procedure cross-platform.

Read each note's prerequisites and safety warnings. Administrator privileges, destructive operations, certificate trust, package sources, mounts, and sudoers changes require particular care. This is not an unattended installer.

The repository reorganization and macOS import preserve workstation setup commands and configurations; they do not certify current versions or prove that setup succeeds on your machine. Repository validation commands use the maintained paths. Record the platform, versions, date, and results when you test a procedure.

## Maintenance and origins

Keep one home per topic and troubleshooting next to the relevant instructions. Link to `config/` rather than copying entire configurations into notes. See [CONTRIBUTING.md](CONTRIBUTING.md) for the small note format and checks, and [AGENTS.md](AGENTS.md) for editing rules.

The macOS notes were imported from `terminal-first-macos-dev`; the [import record](docs/macos/setup.md#traceability) preserves the source commit, path mapping, and attribution. Earlier project records remain available [in Git history](https://github.com/xiongxianfei/terminal-first-dev/blob/f13eb81fe167bd7902d1b707ea1370011e977ff4/archive/README.md), not as active governance or a restored archive directory.
