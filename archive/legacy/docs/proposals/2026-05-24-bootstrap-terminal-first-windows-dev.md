---
id: 2026-05-24-bootstrap-terminal-first-windows-dev
title: Bootstrap Terminal-First Windows Dev Workstation
status: accepted
created: 2026-05-24
repo: xiongxianfei/terminal-first-windows-dev
proposal_path: docs/proposals/2026-05-24-bootstrap-terminal-first-windows-dev.md
---

# Bootstrap Terminal-First Windows Dev Workstation

## Status

accepted

## Problem

The repository exists, but it still needs a project-specific direction for an open-source, terminal-first Windows development workstation guide. Without a proposal, the first implementation could become an unstructured checklist that mixes Windows host setup, WSL/Ubuntu configuration, editor configuration, tmux configuration, security-sensitive settings, and environment-specific proxy behavior without a clear scope or verification model.

The project should help developers set up a practical Windows 11 workstation centered on PowerShell, WSL2 Ubuntu, Neovim, and tmux while keeping the guide safe, reproducible, reversible, and understandable for contributors.

## Goals

- Establish the first product direction for `terminal-first-windows-dev`.
- Define a documentation-first setup approach for a terminal-first Windows 11 development workstation.
- Cover installation and baseline configuration for latest stable PowerShell on Windows, WSL2 with Ubuntu, Ubuntu environment settings, Neovim on Windows PowerShell and Ubuntu, and tmux on Ubuntu.
- Keep WSL2 distro data under `D:\Software\WSL\Ubuntu` for the first setup slice, while exposing `D:\Data` inside Ubuntu as a predictable shared data location.
- Include Ubuntu checks and configuration for passwordless sudo, proxy handling, `D:\Data` access, and locale readiness.
- Provide a minimal Neovim setup focused on editing, navigation, syntax support, LSP diagnostics, formatting, and linting.
- Provide a minimal tmux setup for daily terminal development in Ubuntu.
- Include validation guidance so users can confirm each layer is working.
- Preserve a path for future automation without making a large unattended installer the first user-facing contract.

## Non-goals

- Supporting Windows versions older than Windows 11 in the first slice.
- Supporting arbitrary WSL distro relocation paths beyond the documented `D:\Software\WSL\Ubuntu` target.
- Building a full dotfiles framework before the guide is useful.
- Providing full programming-language runtime setup for Node.js, Python, Go, Rust, Java, databases, Docker, Kubernetes, or AI tooling.
- Replacing GUI IDEs or covering VS Code, JetBrains IDEs, Visual Studio, or remote development workflows in detail.
- Supporting tmux on native Windows.
- Making passwordless sudo a silent default without explicit warning and validation guidance.
- Solving all corporate proxy, PAC, custom certificate, or VPN cases in the first slice.
- Publishing a one-command unattended installer before the setup model is reviewed.

## Vision fit

fits the current vision

This proposal fits the current `VISION.md` because it keeps the project focused on a concise, auditable terminal-first Windows 11 development environment. It narrows the unresolved baseline question by choosing PowerShell plus WSL2 Ubuntu as the first workstation path, while preserving the vision's refusal to become an opaque one-command bootstrapper.

The proposal has a scope-pressure risk: Neovim, tmux, proxy handling, sudo behavior, locale checks, and data-mount behavior can grow into a large dotfiles or workstation automation project. The downstream spec should keep the first slice short and make optional or security-sensitive behavior explicit.

## Context

`terminal-first-windows-dev` is intended to be an open-source GitHub repository for a terminal-first development environment on Windows 11. The project should read as a public guide, not a private machine setup note. That means the first version should optimize for clarity, safety notes, testability, and maintainability.

The current repository already has `VISION.md`, `CONSTITUTION.md`, `AGENTS.md`, `docs/project-map.md`, `docs/workflows.md`, an exploration artifact, and research on Windows terminal-first tooling. Research supports Windows Terminal, PowerShell 7, `winget`, and Git for Windows as a Windows-native baseline, while treating WSL setup as more invasive because it requires administrator PowerShell, feature enablement, distro installation, and restart.

The requested baseline covers three environment layers:

1. Windows host layer: PowerShell, WSL2, Windows Terminal assumptions, and Windows-side package management.
2. Ubuntu-on-WSL layer: Linux packages, sudo policy, proxy policy, mounted data path, locale checks, and shell environment.
3. Terminal tooling layer: Neovim available in Windows PowerShell and Ubuntu, plus tmux in Ubuntu.

The requested WSL storage policy is intentionally split: keep the Ubuntu distro's VHDX under `D:\Software\WSL\Ubuntu`, while exposing `D:\Data` inside Ubuntu for shared data. This keeps distro storage and shared data distinct, avoids filling the system drive with WSL data, and still supports a predictable cross-OS data location.

## Options Considered

### Option A: Manual guide only

Create a README-driven guide with commands and explanations, but no reusable scripts or validation helpers.

Pros: easiest to review, lowest risk of destructive automation, and good for early learning.

Cons: users can skip steps accidentally, repeated setup is slower, and consistency across machines is harder to verify.

### Option B: One-command installer first

Create a bootstrap script that installs and configures PowerShell, WSL2, Ubuntu, Neovim, tmux, proxy settings, mounts, and sudo behavior.

Pros: fastest happy-path setup and easy to demonstrate.

Cons: high risk for a new public repo. Admin permissions, WSL restarts, proxy behavior, and sudoers changes are machine-sensitive, and rollback becomes more important and more difficult.

### Option C: Dotfiles-first project

Focus on Neovim and tmux configuration as reusable dotfiles, with Windows and WSL setup described lightly.

Pros: useful to users who already have WSL and tooling installed, and faster to iterate on editor and tmux configuration.

Cons: leaves PowerShell, WSL2, Ubuntu, proxy, mount, and locale setup under-specified, and risks becoming a private dotfiles repo instead of a public setup playbook.

### Option D: Documentation-first guide with small helpers and doctor checks

Create clear setup documentation first, then add small scripts for safe, repeatable tasks and validation checks. Scripts should be inspectable, scoped, and reversible where practical.

Pros: balances public readability with repeatability, keeps security-sensitive settings explicit, gives contributors smaller units to review, and supports future automation without locking into a large installer too early.

Cons: slower than a one-command installer, requires more documentation discipline, and leaves some steps interactive until the project chooses a stronger automation policy.

## Recommended Direction

Choose Option D: documentation-first guide with small helpers and doctor checks.

The project should start as a public playbook with a clear README, structured setup guide, minimal configuration files, and validation helpers. The first implementation should avoid a large unattended installer. Instead, it should split the setup into understandable layers:

- Windows host setup
- WSL2 and Ubuntu setup
- Ubuntu environment hardening and convenience configuration
- Neovim setup for Windows and Ubuntu
- tmux setup for Ubuntu
- verification and rollback notes

This gives the repository a durable open-source foundation while keeping future automation possible.

## Expected Behavior Changes

After this proposal is adopted and implemented through downstream specs and plans, the repository should change from a generic starter template into a project-specific guide that helps users:

- install or update to the latest stable PowerShell using a supported Windows package path;
- install WSL2 and Ubuntu using supported Microsoft tooling;
- confirm WSL2 is active and the selected explicit Ubuntu LTS distro is installed;
- place WSL distro data under `D:\Software\WSL\Ubuntu` for both migrated and future installs;
- configure Ubuntu with a documented passwordless-sudo option;
- configure proxy behavior using WSL automatic proxy mirroring when supported and a documented manual environment-variable fallback;
- expose `D:\Data` inside Ubuntu through `/home/<user>/data`;
- check and repair locale issues;
- install Neovim on Windows and Ubuntu;
- use one single-file shared Neovim configuration with a concise plugin baseline for editing, navigation, diagnostics, Git indicators, statusline, and LSP wiring;
- install and configure tmux in Ubuntu;
- run verification checks for each major layer.

## Architecture Impact

The proposal affects repository structure, documentation boundaries, shell scripts, configuration files, and validation scripts.

Recommended repository shape:

```text
terminal-first-windows-dev/
├── README.md
├── VISION.md
├── docs/
│   ├── guides/
│   │   ├── 01-windows-host.md
│   │   ├── 02-wsl2-ubuntu.md
│   │   ├── 03-ubuntu-baseline.md
│   │   ├── 04-neovim.md
│   │   ├── 05-tmux.md
│   │   └── 99-verification.md
│   ├── proposals/
│   ├── architecture/
│   ├── adr/
│   └── troubleshooting/
├── specs/
├── scripts/
│   ├── windows/
│   └── ubuntu/
├── config/
│   ├── nvim/
│   └── tmux/
└── tests/
    ├── markdown/
    ├── powershell/
    └── shell/
```

Expected boundaries:

- Windows scripts handle host-side PowerShell and WSL checks.
- Ubuntu scripts handle Linux-side package checks, sudoers snippets, proxy environment, mount or link setup, locale checks, Neovim dependency checks, and tmux checks.
- Config files are examples that users can copy, install, or adapt.
- Doctor scripts validate state without making broad changes.
- Docs explain decisions, tradeoffs, rollback, and known limitations.

Because this proposal includes scripts and machine-changing configuration, downstream architecture work is triggered before implementation.

Recommended WSL storage posture:

```powershell
wsl --shutdown
wsl --export Ubuntu D:\Software\WSL\Ubuntu\ext4.vhdx --vhd
wsl --unregister Ubuntu
wsl --import-in-place Ubuntu D:\Software\WSL\Ubuntu\ext4.vhdx
wsl --set-default Ubuntu
wsl -d Ubuntu
```

For future installs, use the WSL install location option:

```powershell
wsl --install Ubuntu --location D:\Software\WSL\Ubuntu
```

The spec should validate the exact syntax supported by the target WSL version. Current Microsoft WSL docs describe VHD export with `--vhd`, import in place with `wsl --import-in-place <Distribution Name> <FileName>`, and install location with `--location`.

Recommended WSL configuration posture:

```ini
# %UserProfile%\.wslconfig
[wsl2]
autoProxy=true
```

```ini
# /etc/wsl.conf
[automount]
enabled=false
mountFsTab=true

[interop]
enabled=true
appendWindowsPath=false
```

```fstab
# /etc/fstab
# Preferred target: expose D:\Data at /home/<user>/data through DrvFs.
# Validate the final syntax with: sudo mount -a
D:/Data /home/<user>/data drvfs metadata,uid=1000,gid=1000,umask=022,fmask=011,case=off 0 0
```

If direct subdirectory mounting is unreliable on a user's WSL version, the spec should define a fallback that mounts `D:` through fstab and creates a documented symlink from `/home/<user>/data` to the `Data` directory.

## Testing and Verification Strategy

The project should use layered verification rather than relying only on installation success.

Static checks:

- Markdown linting for docs.
- Shell script linting for Ubuntu scripts.
- PowerShell script analysis for Windows scripts.
- Basic formatting checks for configuration files.

Host verification:

- PowerShell can be launched as `pwsh`.
- WSL is installed and reports usable status.
- Ubuntu is installed and running under WSL2.
- The selected explicit Ubuntu LTS distro is installed and is the default distro when the user chooses that path.
- The Ubuntu distro's registered VHDX path resolves under `D:\Software\WSL\Ubuntu`.
- A migrated distro can launch after `wsl --import-in-place`, and a new install can use `wsl --install Ubuntu --location D:\Software\WSL\Ubuntu` when the target WSL version supports it.

Ubuntu verification:

- User identity and default shell are correct.
- Passwordless sudo behavior passes a non-interactive check when the user enabled it.
- Proxy variables or WSL proxy mirroring are active when configured.
- `D:\Data` is reachable from Ubuntu through `/home/<user>/data`.
- Locale output is UTF-8 and warning-free, with `C.UTF-8` as the baseline healthy locale.
- Required baseline packages are installed.

Neovim verification:

- `nvim --version` works in Windows PowerShell and Ubuntu.
- Shared or mirrored Neovim config loads without startup errors.
- Plugin manager bootstrap works.
- LSP diagnostics, linting, formatting, syntax highlighting, and file navigation plugins are installed or clearly reported as missing.
- `:checkhealth` output is documented for troubleshooting.

tmux verification:

- `tmux -V` works in Ubuntu.
- The tmux configuration can be loaded in a clean session.
- Prefix, pane, window, mouse, status, and copy-mode settings behave as documented.

## Rollout and Rollback

Rollout:

- Start with docs and proposal structure before automation-heavy scripts.
- Replace the template README with a project-specific README that explains audience, scope, and warning labels.
- Add setup guides in numbered order so users can follow the path incrementally.
- Add small scripts only after the corresponding guide explains the changes.
- Add doctor checks early so users can verify each layer before continuing.
- Publish configuration files as examples before making them auto-installing defaults.

Rollback:

- Repository changes can be reverted by PR or commit revert.
- User-local configuration changes should be backed up before scripts overwrite files.
- WSL distro relocation should require a pre-migration export or file backup, enough free disk space on `D:`, and an explicit warning that `wsl --unregister Ubuntu` removes the registered distro.
- Failed WSL relocation can be rolled back by re-importing a verified backup VHDX or tar export and resetting the default distro.
- Passwordless sudo can be rolled back by removing the project-owned sudoers drop-in and validating sudoers syntax.
- Proxy settings can be rolled back by removing project-owned shell profile snippets or WSL configuration entries.
- `D:\Data` mount or link setup can be rolled back by removing project-owned fstab, mount, bind, or symlink configuration.
- Neovim and tmux configurations can be rolled back by restoring backed-up config directories.
- WSL global configuration changes can be rolled back by removing project-owned entries and restarting WSL.

## Risks and Mitigations

| Risk | Impact | Mitigation |
| --- | --- | --- |
| "Newest" tooling changes behavior over time | Guide breaks or becomes hard to reproduce | Define a latest-stable policy and record tested versions in release notes |
| WSL distro relocation can destroy data if done carelessly | Users may lose the Ubuntu distro when unregistering or importing incorrectly | Require backup/export guidance, preflight path checks, launch verification, and rollback instructions before relocation steps |
| `D:\Software\WSL\Ubuntu` may not exist or may lack space | WSL install, export, or import can fail | Check and create the directory, verify free disk space, and document how to choose a different path in a later proposal |
| Editing projects on mounted Windows drives can be slower for Linux tools | Users may place code in `D:\Data` and see poor performance | Explain that the WSL filesystem is preferred for Linux-heavy code, while `D:\Data` is for shared data unless the user accepts tradeoffs |
| Passwordless sudo weakens local security | Commands can escalate without password prompts | Make it explicit, opt-in, owner-scoped, and easy to revert |
| Proxy behavior differs by Windows version, VPN, PAC, and corporate certificates | Network setup may fail | Provide automatic and manual proxy paths, plus clear troubleshooting |
| `D:\Data` may not exist | Setup fails on machines without that path | Check for the path before configuring it and document how to create or skip it |
| Locale changes can affect scripts and tools | Unexpected language or encoding behavior | Prefer checking and documenting locale before changing it |
| Neovim plugins drift or break | Editor setup becomes unstable | Keep the plugin set small, use a lockfile when possible, and document update policy |
| Same Neovim config may not behave identically on Windows and Ubuntu | Users see inconsistent paths or tools | Keep the single-file config portable and document environment-specific verification |
| tmux requires terminal feature compatibility | Copy mode, colors, and keybindings may vary | Keep the first tmux config conservative and include terminal notes |
| Automation may modify sensitive files | User trust and system stability risk | Use dry-run or doctor-first behavior where possible and backup before write operations |

## Open Questions

- None blocking spec authoring.
- PAC files and corporate CA certificates remain deferred from the first implementation slice. The spec should include troubleshooting notes and known limitations only.

## Decision Log

| Date | Decision | Reason | Alternatives rejected |
| --- | --- | --- | --- |
| 2026-05-24 | Use `terminal-first-windows-dev` as the project identity | The repo name clearly signals a terminal-centered Windows development workflow | Generic Windows dev setup naming |
| 2026-05-24 | Start documentation-first with small helper scripts and doctor checks | Public users need clarity, reversibility, and reviewable changes before automation | One-command installer first; manual guide only; dotfiles-first |
| 2026-05-24 | Store the Ubuntu WSL distro under `D:\Software\WSL\Ubuntu` in the first setup path | Matches the updated owner direction and prevents WSL distro data from filling the system drive | Keeping the distro VHDX on the default C-drive location |
| 2026-05-24 | Treat `D:\Data` as shared data, not necessarily the preferred Linux project-code location | Preserves cross-OS data access while avoiding WSL filesystem performance surprises | Putting all development projects under `/mnt/d/Data` by default |
| 2026-05-24 | Keep passwordless sudo explicit and reversible | It is useful for development convenience but has local security tradeoffs | Silent default passwordless sudo |
| 2026-05-24 | Use a minimal Neovim plugin profile | The editor should be useful without becoming a full distribution | Large opinionated Neovim distribution in the first slice |
| 2026-05-24 | Scope tmux to Ubuntu only | The current request targets tmux for Ubuntu, and tmux fits the WSL workflow naturally | Native Windows tmux support in the first slice |
| 2026-05-24 | Use explicit current Ubuntu LTS distro naming | Avoids mutable `Ubuntu` behavior and keeps the guide reproducible; current target is the latest Ubuntu LTS listed by `wsl --list --online`, with Ubuntu 24.04 LTS as compatibility fallback | Unversioned `Ubuntu` package as the only path |
| 2026-05-24 | Define newest as latest stable, not preview or nightly | Balances currency and stability for a public setup guide; record tested versions in release notes and pin only where reproducibility matters | Nightly or pre-release tooling; fully pinned system versions |
| 2026-05-24 | Use `C.UTF-8` as the baseline locale | Provides deterministic UTF-8 behavior without forcing a regional locale | Forcing `en_US.UTF-8`; inheriting Windows locale blindly |
| 2026-05-24 | Disable automatic Windows drive mounts and mount only the documented data path | Keeps C drive hidden from WSL by default while preserving shared data access | Default `/mnt/c` and `/mnt/d` automounts |
| 2026-05-24 | Use `/home/<user>/data` for the documented `D:\Data` path in Ubuntu | Keeps the path lowercase, home-relative, and predictable | `/data`; `~/Data`; only `/mnt/d/Data` |
| 2026-05-24 | Store Linux-heavy project code in the WSL filesystem by default | Avoids performance and tool-behavior issues on Windows-mounted drives | Putting all projects under the shared data mount |
| 2026-05-24 | Use WSL automatic proxy mirroring as primary | Matches modern WSL behavior and reduces duplicated proxy setup | Manual environment variables as the only path |
| 2026-05-24 | Defer PAC files and corporate CA certificates from the first slice | These cases are organization-specific and can expand troubleshooting scope quickly | Full corporate proxy and certificate support in the first implementation slice |
| 2026-05-24 | Make passwordless sudo an explicit personal-workstation convenience profile | Preserves public safety expectations while supporting the requested workflow | Silent passwordless sudo; no passwordless sudo path |
| 2026-05-24 | Keep the Neovim profile concise and make extra language tooling optional | Preserves a simple first editor setup without pulling broad language runtimes into scope | Making Lua, Markdown, Shell, PowerShell, JavaScript/TypeScript, or Python tooling mandatory |
| 2026-05-24 | Use one single-file shared Neovim config | Preserves one editor experience while keeping the config easy to inspect and copy | Fully separate Windows and WSL configs; multi-module config with OS adapters; sharing runtime state through DrvFs |
| 2026-05-24 | Assume Windows Terminal as the terminal host | It supports PowerShell and WSL profiles and fits the project identity | Covering multiple terminal emulators in the first slice |
| 2026-05-24 | Support both migration and future-install WSL storage paths | Existing users need a relocation path, while fresh installs can use WSL's install-location option | Only documenting one path; requiring users to reinstall Ubuntu manually |

## Initial Intent Preservation

| Initial user goal | Proposal treatment | Where recorded |
| --- | --- | --- |
| Build a simple and concise project for terminal-first Windows 11 development | in scope | Problem, Goals, Vision fit |
| Generate a proposal to start the project | in scope | Status, Recommended Direction, Next Artifacts |
| Follow best practices | in scope | Testing and Verification Strategy, Risks and Mitigations, Rollout and Rollback |
| Install newest PowerShell | in scope | Goals, Expected Behavior Changes, Scope Budget |
| Install newest WSL2 and Ubuntu | in scope | Goals, Expected Behavior Changes, Scope Budget |
| Move WSL2 Ubuntu data storage to `D:\Software\WSL\Ubuntu` | in scope | Goals, Context, Decision Log, Scope Budget |
| Configure Ubuntu passwordless sudo | in scope | Goals, Risks and Mitigations, Decision Log |
| Configure Ubuntu auto proxy | in scope | Goals, Risks and Mitigations, Decision Log |
| Expose `D:\Data` in Ubuntu | in scope | Goals, Expected Behavior Changes, Rollout and Rollback |
| Check Ubuntu locale | in scope | Goals, Testing and Verification Strategy, Decision Log |
| Install Neovim for PowerShell and Ubuntu | in scope | Goals, Expected Behavior Changes, Testing and Verification Strategy |
| Configure Neovim with useful plugins such as code linting | in scope | Goals, Recommended Direction, Testing and Verification Strategy |
| Install tmux for Ubuntu | in scope | Goals, Expected Behavior Changes |
| Configure tmux | in scope | Goals, Expected Behavior Changes, Testing and Verification Strategy |

## Scope Budget

| Work item | Treatment | Reason |
| --- | --- | --- |
| Project identity and README replacement | first-slice candidate | The repo still needs a project-specific public entry point |
| PowerShell installation guide | core to this proposal | It is the Windows host shell baseline |
| WSL2 and Ubuntu installation guide | core to this proposal | It is the main Linux development substrate |
| WSL storage policy under `D:\Software\WSL\Ubuntu` | core to this proposal | It is explicitly requested and affects migration safety, install commands, and rollback guidance |
| Ubuntu passwordless sudo | core to this proposal | It is explicitly requested, but security-sensitive |
| Ubuntu proxy setup | core to this proposal | It is explicitly requested and often blocks package installation |
| `D:\Data` Ubuntu exposure | core to this proposal | It is explicitly requested as part of WSL/Ubuntu setup |
| Locale check and repair guidance | core to this proposal | It is explicitly requested and affects terminal tooling |
| Neovim installation on Windows and Ubuntu | core to this proposal | It is the core editor workflow |
| Neovim plugin baseline for linting and diagnostics | core to this proposal | It makes the editor useful without turning it into a full distribution |
| tmux installation and configuration on Ubuntu | core to this proposal | It is the terminal workspace baseline |
| Doctor scripts | same-slice dependency | Validation is needed to make the guide reliable |
| CI for docs and script syntax | first-slice candidate | It helps contributors maintain quality, but machine-level install tests can come later |
| Language runtimes and version managers | deferable follow-up | Useful but outside the first workstation foundation |
| Docker, databases, AI coding tools, and cloud CLIs | deferable follow-up | Valuable future modules, but not necessary for the first setup path |
| Native Windows tmux support | out of scope | The current request scopes tmux to Ubuntu |

## Next Artifacts

- `specs/terminal-first-workstation-setup.md` for detailed requirements.
- `docs/architecture/2026-05-24-workstation-setup-boundaries.md` for docs, scripts, config, validation, rollback, and machine-changing boundaries.
- `docs/adr/2026-05-24-version-and-package-policy.md` for latest-stable versus pinned-version policy.
- `docs/adr/2026-05-24-wsl-storage-and-data-mount-policy.md` for `D:\Software\WSL\Ubuntu` WSL storage and `D:\Data` exposure.
- `docs/adr/2026-05-24-proxy-strategy.md` for automatic and manual proxy approaches.
- `docs/adr/2026-05-24-neovim-plugin-baseline.md` for plugin selection and lockfile policy.
- `specs/terminal-first-workstation-setup.test.md` for host, Ubuntu, Neovim, and tmux validation.
- A future implementation plan under `docs/plans/<change-id>.md` after proposal review, spec authoring, architecture, and test-spec work.

## Follow-on Artifacts

None yet

## Readiness

Ready for spec after proposal decisions are recorded.

Not ready for implementation planning until the spec records requirements, validation checks, rollback requirements, and safety gates for WSL distro relocation, sudoers, WSL configuration, proxy behavior, and data mounting.
