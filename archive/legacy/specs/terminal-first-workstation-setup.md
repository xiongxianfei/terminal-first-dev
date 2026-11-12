# Terminal-First Workstation Setup Spec

## Status

approved

## Related proposal

- Proposal: `docs/proposals/2026-05-24-bootstrap-terminal-first-windows-dev.md`
- Proposal review: `docs/changes/2026-05-24-terminal-first-workstation-setup/reviews/proposal-review.md`
- Research: `docs/research/2026-05-24-windows-terminal-first-tooling.md`

## Goal and context

This spec defines the observable behavior for the first terminal-first Windows 11 workstation setup guide. The guide covers a Windows host layer, WSL2 Ubuntu layer, Ubuntu baseline configuration, Neovim on Windows and Ubuntu, tmux on Ubuntu, and doctor-style verification.

The first slice is documentation-first with small inspectable helpers and doctor checks. It must not become a one-command unattended installer. Any helper that changes user or machine state must be explained by the guide, scoped to a specific layer, and paired with verification and rollback guidance.

## Glossary

- Windows host: the Windows 11 environment running Windows Terminal, PowerShell, WSL, and Windows package tools.
- WSL: Windows Subsystem for Linux.
- Ubuntu distro: the selected explicit Ubuntu LTS distribution installed under WSL2.
- WSL storage root: `D:\Software\WSL\Ubuntu`, the target location for the Ubuntu distro VHDX.
- Shared data path: `D:\Data` on Windows, exposed inside Ubuntu at `/home/<user>/data`.
- Linux project path: a path in the WSL filesystem, such as `~/src`, preferred for Linux-heavy project code.
- Doctor check: a read-only or narrowly scoped validation command that reports current state without making broad changes.
- Convenience profile: optional setup behavior that improves personal workstation ergonomics but changes security or system behavior.

## Examples first

Example E1: fresh WSL install to D drive
Given a Windows 11 machine with WSL available and `D:\Software\WSL\Ubuntu` creatable
When the user follows the fresh-install WSL path
Then Ubuntu is installed under `D:\Software\WSL\Ubuntu`, the distro can launch, and the guide shows a command to verify the registered distro and storage path.

Example E2: migrate existing Ubuntu to D drive
Given an existing Ubuntu WSL2 distro and enough free space on `D:`
When the user follows the migration path
Then the guide requires shutdown, export or backup, unregister warning, import-in-place, default distro reset, launch verification, and rollback guidance before the migration is considered complete.

Example E3: configure shared data without making it the project-code default
Given `D:\Data` exists
When the Ubuntu data-mount path is configured
Then `/home/<user>/data` reaches `D:\Data`, `sudo mount -a` succeeds or reports actionable failure, and the guide still recommends `~/src` for Linux-heavy project code.

Example E4: opt into passwordless sudo
Given the user chooses the passwordless sudo convenience profile
When the guide applies the sudoers change
Then the change is project-owned, validated with `visudo`, verified with a non-interactive sudo check, and documented with rollback steps.

Example E5: verify terminal tooling
Given the setup guide has been followed
When the user runs doctor checks
Then PowerShell, WSL/Ubuntu, proxy state, shared data, locale, Neovim on both environments, and tmux on Ubuntu are reported as pass, fail, skipped, or needs manual action.

## Requirements

R1. The guide MUST state that Windows 11 is the first-slice platform target.

R2. The guide MUST assume Windows Terminal as the primary terminal emulator and document PowerShell and Ubuntu profiles.

R3. The guide MUST use latest stable tooling at setup time, not preview or nightly versions, unless a section explicitly labels an optional preview path.

R4. The guide MUST record tested versions for core tools in a release note or equivalent version record when the first setup guide is published.

R5. The Windows host setup MUST document installation or update of PowerShell 7 through a supported Windows package path.

R6. The Windows host setup MUST document how to verify `pwsh`, `winget`, `wt`, and WSL availability.

R7. The Windows host setup MUST identify commands that may require administrator elevation, prompt for elevation, or depend on enterprise policy.

R8. The WSL setup MUST use an explicit Ubuntu LTS distro name selected from `wsl --list --online`; it MUST NOT rely only on the mutable `Ubuntu` name when the exact LTS package is available.

R9. The guide MUST define the supported fresh-install custom-location path for Ubuntu as a version-gated WSL command contract.

For the fresh-install path, the guide MUST:

1. Run `wsl --version` and record the WSL version in the verification output.
2. Run `wsl --help` and verify that the current WSL command supports `--install`, `--distribution`, and `--location`.
3. Run `wsl --list --online` and require the user to choose an explicit Ubuntu LTS distro name from that output.
4. Create or verify the parent install directory `D:\Software\WSL`.
5. Require the target install directory `D:\Software\WSL\Ubuntu` to be absent or intentionally empty before installation.
6. Install Ubuntu with this primary command form:

   ```powershell
   wsl --install --distribution <UbuntuLtsDistroName> --location "D:\Software\WSL\Ubuntu"
   ```

7. Reject the fresh custom-location path if `wsl --help` does not list `--location` after `wsl --update` and `wsl --shutdown` have been run.
8. Direct unsupported systems to the documented migration/import path instead of silently installing to the default location.

The guide MUST NOT treat the ambiguous positional form below as the primary public command:

```powershell
wsl --install Ubuntu --location "D:\Software\WSL\Ubuntu"
```

R10. The WSL setup MUST support migration of an existing WSL2 Ubuntu distro to `D:\Software\WSL\Ubuntu` using a VHDX export/import-in-place path.

R11. The migration path MUST require `wsl --shutdown` before export and MUST require a successful backup or export before `wsl --unregister Ubuntu` is shown as an action.

R12. The migration path MUST warn that `wsl --unregister Ubuntu` removes the registered distro and can cause data loss if backup or import verification fails.

R13. The migration path MUST show verification after import-in-place, including distro launch and default distro reset.

R14. Before publication, the implementation and test spec MUST validate the exact WSL install-location command contract used in R9.

Validation MUST include:

1. Official Microsoft WSL documentation evidence for `wsl --install`, `--distribution`, `--location`, `wsl --list --online`, and `wsl --help`.
2. A local or release-captured `wsl --help` excerpt showing the required options.
3. A negative check that the guide does not leave the fresh-install command form unresolved.
4. A negative check that the guide does not present `wsl --install Ubuntu --location ...` as the primary command.
5. A positive check that the guide presents the primary command as:

   ```powershell
   wsl --install --distribution <UbuntuLtsDistroName> --location "D:\Software\WSL\Ubuntu"
   ```

6. A verification step after installation:

   ```powershell
   wsl --list --verbose
   ```

7. A verification step that the distro is installed under the expected custom location, using the best available non-destructive check for the current WSL version.

R15. The guide MUST keep WSL distro storage under `D:\Software\WSL\Ubuntu` distinct from shared user data under `D:\Data`.

R16. The Ubuntu baseline MUST configure or document `C.UTF-8` as the healthy default locale and MUST accept user-selected UTF-8 locales when they are warning-free.

R17. Locale verification MUST report whether locale output is UTF-8 and warning-free.

R18. The WSL configuration MUST use WSL automatic proxy mirroring as the primary proxy path by documenting `%UserProfile%\.wslconfig` with `[wsl2] autoProxy=true`.

R19. The guide MUST provide manual proxy environment-variable fallback guidance.

R20. The first slice MUST defer PAC files and corporate CA certificates to troubleshooting notes and known limitations.

R21. The Ubuntu baseline MUST document `/etc/wsl.conf` with automatic Windows drive mounts disabled and fstab mounting enabled.

R22. The Ubuntu baseline MUST expose `D:\Data` at `/home/<user>/data` through a documented fstab or fallback symlink path.

R23. The data path setup MUST validate the mount with `sudo mount -a` or an equivalent doctor check.

R24. The guide MUST recommend Linux-heavy project code live in the WSL filesystem, for example `~/src`, and MUST describe `/home/<user>/data` as shared Windows/Linux data.

R25. Passwordless sudo MUST be optional and labeled as a personal-workstation convenience profile.

R26. Passwordless sudo setup MUST use a project-owned sudoers drop-in, validate syntax with `visudo`, verify non-interactive behavior, and document rollback.

R27. The guide MUST install or document Neovim for both Windows PowerShell and Ubuntu.

R28. The Neovim setup MUST use one single-file shared config at `config/nvim/init.lua` and MUST NOT rely on plugin or runtime state shared through a Windows-mounted path.

R29. The concise Neovim profile MUST include editing, navigation, diagnostics, Git indicators, and LSP wiring without requiring a full language-runtime setup.

R30. Additional language support, including JavaScript/TypeScript and Python, MUST remain optional and user-installed.

R31. Neovim verification MUST include `nvim --version`, startup without config errors, plugin manager status, and documented `:checkhealth` troubleshooting.

R32. The tmux setup MUST be scoped to Ubuntu and MUST NOT claim native Windows tmux support.

R33. The tmux setup MUST provide a minimal daily-development configuration covering prefix, panes, windows, mouse behavior, status, and copy-mode behavior.

R34. tmux verification MUST include `tmux -V` and loading the configuration in a clean session.

R35. Doctor checks MUST report pass, fail, skipped, or needs manual action for each checked layer.

R36. Doctor checks SHOULD avoid making broad changes because doctor behavior is primarily verification.

R37. Any helper that writes files MUST explain the target path, backup behavior, rollback behavior, and whether the write affects user-local or machine-wide state.

R38. The guide MUST provide rollback guidance for WSL relocation, WSL configuration, fstab/data mount setup, sudoers changes, proxy configuration, Neovim config, and tmux config.

R39. The guide MUST keep one-command unattended installation out of the first user-facing contract.

R40. The README replacement MUST orient first-time readers to audience, scope, warning labels, setup layers, and the verification-first posture.

R41. The guide MAY document `uv` as an optional developer tool for Windows PowerShell and Ubuntu, but MUST NOT make Python runtime setup mandatory for the first workstation slice.

R42. The `uv` guide MUST document install, update, verification, rollback, and package-index configuration without committing private indexes, credentials, tokens, or internal hostnames.

R43. The `uv` package-index guidance MUST prefer project-level configuration when an index is part of the project contract and user-level configuration only for workstation defaults.

## Inputs and outputs

Inputs:

- User-selected Ubuntu LTS distro name from `wsl --list --online`.
- Windows paths `D:\Software\WSL\Ubuntu` and `D:\Data`.
- Existing or fresh Ubuntu WSL2 distro state.
- Optional proxy values for manual fallback.
- User decision for passwordless sudo convenience profile.
- User decision for optional Neovim JavaScript/TypeScript and Python profiles.

Outputs:

- Public README and numbered setup guides.
- Documented Windows PowerShell commands.
- Documented Ubuntu shell commands.
- Optional helper scripts and doctor checks.
- Example Neovim and tmux configuration files.
- Verification output with pass, fail, skipped, or needs manual action statuses.
- Rollback instructions for every state-changing area.

## State and invariants

- The project remains documentation-first.
- WSL distro storage and shared data are separate concepts.
- `D:\Software\WSL\Ubuntu` is the first-slice WSL storage target.
- `D:\Data` maps to `/home/<user>/data` and is not the default location for Linux-heavy project code.
- Linux-heavy project code defaults to the WSL filesystem, such as `~/src`.
- Passwordless sudo is opt-in.
- PAC files and corporate CA certificate handling are not first-slice setup behavior.
- tmux behavior is Ubuntu-only.
- Helper scripts, if present, are small, inspectable, and paired with doctor checks.

## Error and boundary behavior

- If `winget` is unavailable, blocked, or missing sources, the guide MUST provide a manual or policy-aware fallback note instead of treating setup as silently failed.
- If WSL is unavailable or too old for `--location`, `--vhd`, or `--import-in-place`, the guide MUST stop that path and report the required WSL update or fallback.
- If `D:\Software\WSL\Ubuntu` is missing, the guide MUST create it or instruct the user to create it before install, export, or import.
- If `D:` lacks enough space, the WSL storage path MUST stop before export/import or install.
- If export fails, the guide MUST NOT proceed to unregister.
- If import-in-place fails, rollback instructions MUST preserve the backup or export as the recovery source.
- If `D:\Data` does not exist, the data-mount section MUST offer create, skip, or manual path-selection guidance.
- If `sudo mount -a` fails, the guide MUST show how to inspect and roll back the fstab change.
- If `visudo` validation fails, the sudoers change MUST NOT be considered applied.
- If proxy auto-mirroring does not work, manual fallback MUST be available.
- If Neovim or tmux plugin/config checks fail, doctor output MUST identify the failing layer without claiming the whole workstation setup failed.

## Compatibility and migration

- Windows 11 is the supported platform for the first slice.
- WSL2 is required for the Ubuntu distro storage behavior.
- The guide MUST support both fresh install and migration of an existing Ubuntu WSL2 distro.
- Migration guidance MUST preserve a recovery path before unregistering the existing distro.
- The guide MUST explain that existing WSL distros not named `Ubuntu` require distro-name adaptation or are outside the exact first-slice path.
- The guide MUST state that arbitrary alternate WSL storage roots are outside the first slice.
- The guide MUST state that corporate PAC and custom CA support is limited to troubleshooting notes.

## Observability

- Doctor checks MUST expose layer names in output: Windows host, WSL storage, WSL config, Ubuntu baseline, proxy, data mount, locale, sudo, Neovim Windows, Neovim Ubuntu, and tmux Ubuntu.
- Each doctor result MUST include a status and a short remediation hint when failing.
- Verification docs MUST show the command used to observe each claim.
- Version recording MUST include PowerShell, WSL, Ubuntu distro, Neovim, tmux, and core lint/format tools when installed.

## Security and privacy

- The guide MUST NOT collect, log, or publish secrets, proxy credentials, tokens, private hostnames, private paths beyond documented examples, or credential-manager contents.
- Proxy guidance MUST warn users not to paste credentials into shell history when secure alternatives exist.
- Passwordless sudo MUST be explicitly marked as a local security tradeoff.
- WSL relocation guidance MUST warn about data loss before unregistering a distro.
- Commands that affect execution policy, administrator settings, WSL global config, sudoers, fstab, package sources, or proxy behavior MUST be labeled near the command.
- Helper scripts MUST NOT silently edit sudoers, fstab, WSL config, or profile files without showing the target and backup behavior.

## Accessibility and UX

- The guide MUST be readable as plain Markdown.
- Commands MUST be grouped by environment: Windows PowerShell, Ubuntu shell, Neovim command, or tmux command.
- Safety warnings MUST appear before destructive or security-sensitive commands, not only after them.
- Validation steps MUST appear at the end of each major layer and in a consolidated verification guide.
- The README MUST give first-time readers a clear path through the numbered guides.

## Performance expectations

- The guide MUST warn that Linux-heavy project work is generally expected to perform better in the WSL filesystem than through Windows-mounted paths.
- The guide MUST describe `D:\Data` as shared data storage unless the user accepts mounted-drive performance tradeoffs.
- Doctor checks SHOULD complete quickly enough for repeated use; any slow or interactive check must be labeled before it runs.

## Edge cases

EC1. Existing Ubuntu distro uses a different name than `Ubuntu`.

EC2. `wsl --install --location` is unavailable on the user's WSL version.

EC3. `wsl --export ... --vhd` fails because the distro is running or disk space is insufficient.

EC4. User runs `wsl --unregister Ubuntu` before verifying a backup.

EC5. `D:\Software\WSL\Ubuntu` exists but contains a conflicting VHDX.

EC6. `D:\Data` does not exist.

EC7. Direct subdirectory DrvFs mount for `D:\Data` is unreliable and needs the documented fallback.

EC8. Enterprise policy blocks WinGet, Store/App Installer, WSL, proxy mirroring, or package sources.

EC9. Proxy requires PAC or corporate CA handling.

EC10. Locale is UTF-8 but not `C.UTF-8`.

EC11. Passwordless sudo is rejected by the user.

EC12. Neovim config works in Ubuntu but not Windows, or the reverse.

EC13. tmux config fails because terminal features or keybindings differ.

## Non-goals

- Windows versions older than Windows 11.
- Arbitrary WSL storage roots beyond `D:\Software\WSL\Ubuntu`.
- Full dotfiles framework behavior.
- Language runtime setup for Node.js, Python, Go, Rust, Java, databases, Docker, Kubernetes, cloud CLIs, or AI tooling.
- Detailed GUI IDE workflows.
- Native Windows tmux support.
- Silent passwordless sudo.
- Full corporate proxy, PAC, or custom CA implementation.
- One-command unattended installation.

## Acceptance criteria

AC1. A reviewer can trace each proposal goal to at least one requirement in this spec.

AC2. A reviewer can identify which commands are destructive, security-sensitive, administrator-sensitive, or policy-sensitive before a user runs them.

AC3. Given a Windows 11 machine with current WSL installed, when the user follows the fresh Ubuntu install-location guide, then the guide verifies `wsl --help` support for `--distribution` and `--location`, lists valid distro names with `wsl --list --online`, installs the selected explicit Ubuntu LTS distro with `wsl --install --distribution <UbuntuLtsDistroName> --location "D:\Software\WSL\Ubuntu"`, and verifies the installed distro with `wsl --list --verbose`. If `--location` is unavailable after WSL update and shutdown, the fresh custom-location path MUST stop with a clear remediation message rather than installing to a different location.

AC4. The spec prevents the migration path from unregistering Ubuntu before a backup/export requirement is satisfied.

AC5. The spec defines observable verification for Windows host, WSL storage, Ubuntu baseline, proxy, data mount, locale, sudo, Neovim, and tmux.

AC6. The spec keeps `D:\Data` as shared data and keeps Linux-heavy code under the WSL filesystem by default.

AC7. The spec keeps passwordless sudo opt-in and reversible.

AC8. The spec defers PAC/corporate CA support without hiding the limitation.

AC9. The spec is ready for architecture review because it identifies the state-changing boundaries requiring design: WSL relocation, WSL config, fstab, sudoers, proxy, helper scripts, and config deployment.

## Open questions

- None blocking spec review.
- Resolved: the primary fresh-install custom-location command uses the explicit long-option form: `wsl --install --distribution <UbuntuLtsDistroName> --location "D:\Software\WSL\Ubuntu"`.
- Deferred: exact distro label examples are documentation examples only. The guide must derive the installable Ubuntu LTS name from `wsl --list --online` on the user's machine.

## Next artifacts

- `docs/changes/2026-05-24-terminal-first-workstation-setup/reviews/spec-review.md` for spec review.
- `docs/architecture/2026-05-24-workstation-setup-boundaries.md` for docs, scripts, config, validation, rollback, and machine-changing boundaries.
- `docs/adr/2026-05-24-version-and-package-policy.md`.
- `docs/adr/2026-05-24-wsl-storage-and-data-mount-policy.md`.
- `docs/adr/2026-05-24-proxy-strategy.md`.
- `docs/adr/2026-05-24-neovim-plugin-baseline.md`.
- `specs/terminal-first-workstation-setup.test.md`.

## Follow-on artifacts

None yet

## Readiness

Ready for spec-review.
