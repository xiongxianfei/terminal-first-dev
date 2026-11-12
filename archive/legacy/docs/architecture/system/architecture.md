---
title: Terminal-First Windows Dev Workstation Architecture
status: approved
created: 2026-05-24
spec: ../../../specs/terminal-first-workstation-setup.md
proposal: ../../proposals/2026-05-24-bootstrap-terminal-first-windows-dev.md
---

# Terminal-First Windows Dev Workstation Architecture

## 1. Introduction and Goals

This architecture describes how the repository is shaped to satisfy `specs/terminal-first-workstation-setup.md`. The product is a documentation-first Windows 11 workstation setup guide with small inspectable helpers and doctor checks.

Primary goals:

- Keep the first user-facing contract auditable and not a one-command unattended installer.
- Separate Windows host setup, WSL2 Ubuntu setup, Ubuntu baseline configuration, Neovim configuration, tmux configuration, and verification.
- Make every machine-changing boundary visible before implementation.
- Preserve rollback paths for WSL relocation, WSL configuration, fstab, sudoers, proxy configuration, and editor/terminal configuration.

## 2. Architecture Constraints

- Windows 11 is the first-slice platform target.
- WSL2 is required for Ubuntu distro storage behavior.
- Ubuntu WSL storage target is `D:\Software\WSL\Ubuntu`.
- Shared Windows/Linux data target is `D:\Data`, exposed inside Ubuntu at `/home/<user>/data`.
- Linux-heavy project code is expected to live inside the WSL filesystem, such as `~/src`.
- The first slice does not support arbitrary WSL storage roots, full corporate PAC/custom CA implementation, native Windows tmux, or one-command unattended install.
- Helper scripts may exist, but broad mutation belongs behind explicit guide steps, backups, and doctor verification.

## 3. Context and Scope

The system is this repository and the setup surface it publishes. It interacts with a user's Windows 11 workstation, Microsoft WSL, Ubuntu on WSL, Windows package tooling, shell/profile files, Neovim, and tmux.

C4 system context: [diagrams/context.mmd](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/architecture/system/diagrams/context.mmd)

Out of scope:

- Enterprise device management.
- Full runtime/language ecosystem setup.
- Cloud, database, Docker, Kubernetes, or AI tooling setup.

## 4. Solution Strategy

The architecture uses a layered guide plus validation model:

1. README orients the user and links to numbered guides.
2. Numbered guides explain each environment layer and the commands users may run.
3. Optional helpers perform small scoped changes only after the guide explains the target and rollback.
4. Doctor checks observe state and report pass, fail, skipped, or needs manual action.
5. Config examples for Neovim and tmux are deployable or adaptable, not hidden runtime state.

Durable decisions are recorded in ADRs:

- [ADR: Version and Package Policy](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/adr/2026-05-24-version-and-package-policy.md)
- [ADR: WSL Storage and Data Mount Policy](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/adr/2026-05-24-wsl-storage-and-data-mount-policy.md)
- [ADR: Proxy Strategy](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/adr/2026-05-24-proxy-strategy.md)
- [ADR: WSL Certificate Trust Policy](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/adr/2026-05-25-wsl-certificate-trust-policy.md)
- [ADR: Neovim Plugin Baseline](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/adr/2026-05-24-neovim-plugin-baseline.md)

## 5. Building Block View

C4 container view: [diagrams/container.mmd](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/architecture/system/diagrams/container.mmd)

Repository containers:

- `README.md`: first-reader entry point, scope, warnings, and guide index.
- `docs/guides/`: numbered setup guides for Windows host, WSL2 Ubuntu, Ubuntu baseline, Neovim, tmux, and verification.
- `scripts/windows/`: optional Windows-side helpers and doctor checks.
- `scripts/ubuntu/`: optional Ubuntu-side helpers and doctor checks.
- `config/nvim/`: single-file shared Neovim config.
- `config/tmux/`: Ubuntu tmux configuration.
- `specs/`: behavioral contracts and test specs.
- `docs/architecture/` and `docs/adr/`: design and durable decisions.

## 6. Runtime View

Primary setup flow:

1. User reads README and selects the first-slice path.
2. Windows host guide verifies Windows Terminal, PowerShell, WSL, and package tooling.
3. WSL guide selects an explicit Ubuntu LTS distro from `wsl --list --online`.
4. Fresh install path validates `wsl --help` support for `--install`, `--distribution`, and `--location`, then installs with:

   ```powershell
   wsl --install --distribution <UbuntuLtsDistroName> --location "D:\Software\WSL\Ubuntu"
   ```

5. Migration path shuts down WSL, exports or backs up the distro, warns before unregister, imports in place, resets default distro, and verifies launch.
6. Ubuntu baseline config applies WSL proxy, wsl.conf, data mount, locale, and optional sudo profile.
7. Neovim and tmux guides install/configure tooling.
8. Doctor checks report state for each layer.

Failure paths stop before destructive steps when prerequisites fail. In particular, failed export stops unregister; missing `--location` after update/shutdown routes to migration/import guidance; failed `visudo` or `sudo mount -a` prevents treating changes as applied.

## 7. Deployment View

The repository does not deploy a service. It publishes documentation, optional helper scripts, and config examples.

Execution environments:

- Windows PowerShell: WSL install/migration, Windows package checks, PowerShell/Windows Terminal checks, Windows Neovim checks.
- Ubuntu shell under WSL2: baseline packages, locale, fstab, sudoers, proxy fallback, Ubuntu Neovim checks, tmux checks.
- Neovim runtime: Windows and Ubuntu config paths receive deployed or synced config from one shared `init.lua`.

Generated or modified user-machine state:

- WSL distro VHDX under `D:\Software\WSL\Ubuntu`.
- `%UserProfile%\.wslconfig`.
- Ubuntu `/etc/wsl.conf`.
- Ubuntu `/etc/fstab`.
- Project-owned sudoers drop-in.
- User shell profile snippets for manual proxy fallback if needed.
- Neovim and tmux user config directories.

## 8. Crosscutting Concepts

Validation:

- Every major layer has doctor checks.
- Doctor results use pass, fail, skipped, or needs manual action.
- Publication gates include official documentation evidence and local or release-captured command help where required by the spec.

Safety:

- Destructive commands are preceded by warnings and backup requirements.
- Helpers that write files disclose target path, backup behavior, rollback behavior, and scope.
- Passwordless sudo is opt-in and marked as a local security tradeoff.

Portability:

- Explicit Ubuntu LTS distro names come from `wsl --list --online`.
- Exact distro labels in docs are examples, not hard-coded authority.
- Unsupported WSL command options stop the fresh custom-location path.

Observability:

- Verification docs show the command used to observe each claim.
- Version records include PowerShell, WSL, Ubuntu distro, Neovim, tmux, and core lint/format tools when installed.

## 9. Architecture Decisions

ADRs:

- [ADR: Version and Package Policy](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/adr/2026-05-24-version-and-package-policy.md)
- [ADR: WSL Storage and Data Mount Policy](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/adr/2026-05-24-wsl-storage-and-data-mount-policy.md)
- [ADR: Proxy Strategy](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/adr/2026-05-24-proxy-strategy.md)
- [ADR: WSL Certificate Trust Policy](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/adr/2026-05-25-wsl-certificate-trust-policy.md)
- [ADR: Neovim Plugin Baseline](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/adr/2026-05-24-neovim-plugin-baseline.md)

## 10. Quality Requirements

- Auditability: users can inspect every state-changing command before running it.
- Reversibility: every state-changing setup area has rollback guidance.
- Safety: migration, sudoers, fstab, proxy, and config writes have explicit gates.
- Testability: requirements map to static checks, doctor checks, and manual verification.
- Concision: first-slice guide avoids language runtimes and broad enterprise environment support.

## 11. Risks and Technical Debt

- WSL command availability varies by installed WSL version.
- Distro labels can change in `wsl --list --online`.
- WSL relocation can cause data loss when users skip backup or verification.
- Direct DrvFs subdirectory mounts may be unreliable for some WSL versions.
- Proxy behavior differs across VPN, PAC, and corporate CA environments.
- Neovim plugin and tool versions can drift.

Mitigation is handled through ADRs, command publication gates, doctor checks, and deferred troubleshooting scope.

## 12. Glossary

- Doctor check: a validation command or helper that reports current setup state.
- Fresh install path: installing Ubuntu directly into `D:\Software\WSL\Ubuntu`.
- Migration path: moving an existing Ubuntu WSL2 distro to `D:\Software\WSL\Ubuntu` using backup/export and import-in-place behavior.
- Shared data path: Windows `D:\Data` exposed as Ubuntu `/home/<user>/data`.
- Convenience profile: optional behavior that changes ergonomics and risk, such as passwordless sudo.
