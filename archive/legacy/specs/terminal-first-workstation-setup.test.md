# Terminal-First Workstation Setup Test Spec

## Status

active

## Related spec and plan

- Spec: `specs/terminal-first-workstation-setup.md`
- Spec review: `docs/changes/2026-05-24-terminal-first-workstation-setup/reviews/spec-review.md`
- Plan: `docs/changes/2026-05-24-terminal-first-workstation-setup/plan.md`
- Plan review: `docs/changes/2026-05-24-terminal-first-workstation-setup/review-log.md`
- Architecture: `docs/architecture/system/architecture.md`
- Architecture review: `docs/changes/2026-05-24-terminal-first-workstation-setup/reviews/architecture-review.md`
- ADRs:
  - `docs/adr/2026-05-24-version-and-package-policy.md`
  - `docs/adr/2026-05-24-wsl-storage-and-data-mount-policy.md`
  - `docs/adr/2026-05-24-proxy-strategy.md`
  - `docs/adr/2026-05-25-wsl-certificate-trust-policy.md`
  - `docs/adr/2026-05-24-neovim-plugin-baseline.md`

## Testing strategy

This test spec favors static documentation tests, syntax checks, contract checks, and manual Windows 11 walkthroughs because the first slice is documentation-first and many behaviors affect a user's machine.

- Unit strategy: use small static checks for required and forbidden strings, guide links, status vocabulary, rollback sections, config snippets, and helper-script declarations.
- Integration strategy: validate that README, numbered guides, config examples, helper scripts, verification guide, and troubleshooting docs agree on paths, commands, environments, status values, and rollback surfaces.
- End-to-end strategy: use manual Windows 11 walkthroughs for host setup, WSL fresh install-location, migration/import-in-place, Ubuntu launch, Windows Neovim, and WSL/Ubuntu verification.
- Smoke strategy: run syntax or startup checks where available, including shell syntax, PowerShell parser or analyzer checks, `nvim --version`, `tmux -V`, and clean config-load checks when the relevant runtime is present.
- Manual strategy: record command output for Windows-only or machine-changing paths instead of pretending they can be safely automated from the Linux workspace.
- Contract strategy: preserve exact command contracts for WSL install-location, WSL migration safety, helper write disclosure, doctor status values, and staged whitespace validation.
- Migration strategy: verify that existing Ubuntu migration requires shutdown, export or backup success, unregister warning, import-in-place, default distro reset, launch verification, and rollback before it is considered complete.

## Requirement coverage map

| Requirement ID | Covered by | Level | Notes |
| --- | --- | --- | --- |
| R1 | T-M1-001, T-M2-001 | static, manual | Windows 11 target appears in README/guides and manual host checklist. |
| R2 | T-M1-001, T-M2-001 | static, manual | Windows Terminal and PowerShell/Ubuntu profiles are documented. |
| R3 | T-M1-003, T-M5-003 | static | Latest stable policy and no-preview default are documented. |
| R4 | T-M5-003 | static, manual | Tested-version record is required for publication. |
| R5 | T-M2-001 | static, manual | PowerShell 7 supported install/update path is documented. |
| R6 | T-M2-001 | static, manual | `pwsh`, `winget`, `wt`, and WSL verification commands are documented. |
| R7 | T-M1-002, T-M2-001 | static | Elevation, prompts, and enterprise-policy sensitivity are labeled. |
| R8 | T-SR001-001, T-SR001-007 | static, manual | Explicit Ubuntu LTS distro comes from `wsl --list --online`. |
| R9 | T-SR001-001, T-SR001-002, T-SR001-003, T-SR001-004, T-SR001-008 | static, manual | Fresh install-location command contract is version-gated. |
| R10 | T-M2-002 | static, migration | Existing WSL2 Ubuntu migration uses VHDX export/import-in-place. |
| R11 | T-M2-002 | static, migration | Shutdown and successful backup/export precede unregister. |
| R12 | T-M2-002 | static, migration | Unregister data-loss warning is required before action. |
| R13 | T-M2-002, T-SR001-006 | static, manual | Import-in-place verification, default reset, and launch are documented. |
| R14 | T-SR001-001, T-SR001-002, T-SR001-003, T-SR001-004, T-SR001-005, T-SR001-006, T-SR001-007, T-SR001-008 | static, manual, contract | Publication gate validates exact WSL command contract. |
| R15 | T-M2-003 | static | WSL storage and shared data are separate concepts. |
| R16 | T-M3-003 | static, manual | `C.UTF-8` and warning-free user UTF-8 locales are covered. |
| R17 | T-M3-003 | static, manual | Locale output must be UTF-8 and warning-free. |
| R18 | T-M3-001 | static, manual | `.wslconfig` auto-proxy primary path is documented. |
| R19 | T-M3-001 | static | Manual proxy fallback is documented. |
| R20 | T-M3-001 | static | PAC support is deferred and corporate CA support is manual troubleshooting-only. |
| R21 | T-M3-002 | static, manual | `/etc/wsl.conf` disables automount and enables fstab mounting. |
| R22 | T-M3-002 | static, manual | `D:\Data` maps to `/home/<user>/data` by fstab or fallback symlink. |
| R23 | T-M3-002 | static, manual | `sudo mount -a` or equivalent doctor validation is documented. |
| R24 | T-M2-003, T-M3-002 | static | `~/src` is preferred for Linux-heavy code; `/home/<user>/data` is shared data. |
| R25 | T-M3-004 | static | Passwordless sudo is optional and labeled as a convenience profile. |
| R26 | T-M3-004 | static, manual | Project-owned sudoers drop-in, `visudo`, non-interactive verification, and rollback are covered. |
| R27 | T-M4-001, T-M4-002 | static, smoke, manual | Neovim install/documentation exists for Windows and Ubuntu. |
| R28 | T-M4-001 | static, integration | Single-file shared config avoids shared runtime state through mounted paths. |
| R29 | T-M4-001 | static | Concise profile covers editing, navigation, diagnostics, Git indicators, and LSP wiring. |
| R30 | T-M4-001 | static | Additional language support such as JavaScript/TypeScript and Python is optional and user-installed. |
| R31 | T-M4-002 | smoke, manual | Neovim version, startup, plugin manager, and `:checkhealth` are verified. |
| R32 | T-M4-004 | static | tmux is Ubuntu-only and native Windows tmux is not claimed. |
| R33 | T-M4-003 | static, smoke | tmux config covers prefix, panes, windows, mouse, status, and copy mode. |
| R34 | T-M4-003 | smoke, manual | `tmux -V` and clean-session config load are verified. |
| R35 | T-M5-001 | contract, static | Doctor checks use pass, fail, skipped, and needs manual action. |
| R36 | T-M5-001 | contract, static | Doctor checks are primarily verification and avoid broad writes. |
| R37 | T-M5-006 | contract, static | Helpers that write files disclose targets, backups, rollback, and scope. |
| R38 | T-M5-002 | static | Rollback guidance exists for every state-changing area. |
| R39 | T-M1-003 | static | One-command unattended installation is excluded from first user-facing contract. |
| R40 | T-M1-001, T-M5-005 | static | README orients readers to audience, scope, warning labels, layers, and verification. |
| R41 | T-M1-004 | static | `uv` is optional and does not make Python runtime setup mandatory. |
| R42 | T-M1-004 | static | `uv` install, update, verification, rollback, and package-index guidance are documented without private secrets. |
| R43 | T-M1-004 | static | `uv` index guidance separates project-level and user-level configuration. |

## Example coverage map

| Example | Covered by | Notes |
| --- | --- | --- |
| E1 fresh WSL install to D drive | T-SR001-001, T-SR001-002, T-SR001-003, T-SR001-006, T-SR001-007, T-SR001-008 | Static command contract plus manual install verification. |
| E2 migrate existing Ubuntu to D drive | T-M2-002 | Migration safety and verification are checked as static docs plus manual migration walkthrough. |
| E3 configure shared data without making it the project-code default | T-M2-003, T-M3-002 | Storage/data separation, fstab or symlink fallback, and `~/src` guidance are checked. |
| E4 opt into passwordless sudo | T-M3-004 | Optional sudo profile, sudoers validation, non-interactive check, and rollback are checked. |
| E5 verify terminal tooling | T-M5-001, T-M4-002, T-M4-003 | Doctor status contract plus Neovim and tmux checks. |

## Edge case coverage

| Edge case | Covered by | Level | Notes |
| --- | --- | --- | --- |
| EC1 existing Ubuntu distro uses a different name | T-M2-002 | static | Guide must state adaptation or exact first-slice limitation. |
| EC2 `wsl --install --location` is unavailable | T-SR001-008 | static, manual | Unsupported fresh path stops and routes to migration/import docs. |
| EC3 `wsl --export --vhd` fails | T-M2-002 | static, migration | Failed export stops unregister. |
| EC4 user runs unregister too early | T-M2-002 | static, migration | Warning and backup/export gate must appear before unregister. |
| EC5 target WSL path contains conflicting VHDX | T-SR001-003, T-M2-002 | static | Fresh path requires absent or intentionally empty target. |
| EC6 `D:\Data` does not exist | T-M3-002 | static, manual | Guide offers create, skip, or manual path-selection guidance. |
| EC7 direct DrvFs subdirectory mount is unreliable | T-M3-002 | static, manual | Fallback mount and symlink path is documented. |
| EC8 enterprise policy blocks tooling | T-M2-001, T-M3-001 | static, manual | Policy-aware fallback notes are required. |
| EC9 proxy needs PAC or corporate CA | T-M3-001 | static | First slice defers PAC and keeps corporate CA handling as manual troubleshooting. |
| EC10 locale is UTF-8 but not `C.UTF-8` | T-M3-003 | static, manual | Warning-free user-selected UTF-8 locales are accepted. |
| EC11 user rejects passwordless sudo | T-M3-004 | static | Sudo profile is optional and skip path is documented. |
| EC12 Neovim config works on only one OS | T-M4-001, T-M4-002 | static, smoke, manual | Windows and Ubuntu config paths are checked separately. |
| EC13 tmux config terminal feature mismatch | T-M4-003 | static, manual | Terminal notes and clean-session load checks expose failures. |

## Test cases

### T-M1-001. README and guide index orient first-time readers

- Covers: R1, R2, R40
- Level: smoke
- Fixture/setup: README and numbered guide files exist in the working tree.
- Steps: Check that README states Windows 11 target, Windows Terminal primary terminal, PowerShell and Ubuntu profiles, guide order, setup layers, warning posture, and verification-first workflow.
- Expected result: README links to the numbered guides and clearly identifies audience, scope, setup layers, warnings, and verification.
- Failure proves: First readers cannot reliably discover the supported path or safety model.
- Automation location: `tests/markdown/README-orientation.test.*` or equivalent static check.

### T-M1-002. Commands are labeled by environment and safety sensitivity

- Covers: R7, R37, R40
- Level: static
- Fixture/setup: Numbered guide files exist.
- Steps: Scan guide command blocks for nearby environment labels such as Windows PowerShell, Ubuntu shell, Neovim command, or tmux command; scan destructive or sensitive command sections for warnings before commands.
- Expected result: Commands are grouped by environment, and administrator-sensitive, destructive, WSL global, sudoers, fstab, package-source, execution-policy, and proxy commands have nearby warnings.
- Failure proves: Users could run commands in the wrong environment or without seeing risk.
- Automation location: `tests/markdown/command-labels.test.*`

### T-M1-003. Scope guardrails exclude preview defaults and unattended installer behavior

- Covers: R3, R39
- Level: static
- Fixture/setup: README and guides exist.
- Steps: Check that the main path says latest stable rather than preview/nightly; check that one-command unattended installation is excluded or described as out of scope.
- Expected result: The first user-facing contract remains documentation-first and stable-channel by default.
- Failure proves: The implementation drifted toward unsupported automation or unstable tooling.
- Automation location: `tests/markdown/scope-guardrails.test.*`

### T-M1-004. Optional uv guide is scoped and source-safe

- Covers: R41, R42, R43
- Level: static
- Fixture/setup: `docs/guides/06-uv.md` exists.
- Steps: Check that Windows and Ubuntu install paths, `uv self update`, `uv --version`, rollback, `pyproject.toml`, user-level `uv.toml`, `UV_DEFAULT_INDEX`, and private-secret warnings are documented.
- Expected result: `uv` is available as an optional tool without turning Python runtime setup into a mandatory first-slice requirement.
- Failure proves: Optional tooling drifted into unscoped runtime setup or unsafe package-source guidance.
- Automation location: `tests/markdown/m1-project-entrypoint.test.sh`.

### T-M2-001. Windows host setup commands and policy caveats are documented

- Covers: R1, R2, R5, R6, R7, EC8
- Level: manual
- Fixture/setup: Windows 11 machine or documented manual transcript.
- Steps: Verify that the host guide documents PowerShell 7 install/update through a supported package path; verify `pwsh`, `winget`, `wt`, and WSL availability commands; confirm elevation and enterprise-policy caveats are present.
- Expected result: A reviewer can run or inspect host checks and see which commands may require elevation or policy fallback.
- Failure proves: Windows host setup is incomplete or unsafe for managed machines.
- Automation location: manual checklist in `docs/guides/99-verification.md`; optional `tests/powershell/host-docs.test.ps1`.

### T-SR001-001. Fresh WSL install section lists online distros

- Covers: R8, R9, R14, E1
- Level: static
- Fixture/setup: `docs/guides/02-wsl2-ubuntu.md` exists.
- Steps: Search the fresh-install section for `wsl --list --online`.
- Expected result: The guide requires selecting an explicit Ubuntu LTS distro from command output.
- Failure proves: The guide may rely on mutable `Ubuntu` naming.
- Automation location: `tests/markdown/wsl-install-contract.test.*`

### T-SR001-002. Fresh WSL install prechecks help output and `--location`

- Covers: R9, R14, E1, EC2
- Level: static
- Fixture/setup: `docs/guides/02-wsl2-ubuntu.md` exists.
- Steps: Search the fresh-install section for `wsl --help`, `--install`, `--distribution`, and `--location` precheck language.
- Expected result: The guide verifies current WSL command support before publishing or running the custom-location path.
- Failure proves: The guide could publish a command unsupported by the user's WSL version.
- Automation location: `tests/markdown/wsl-install-contract.test.*`

### T-SR001-003. Primary fresh install command is the explicit long-option form

- Covers: R9, R14, E1, EC5
- Level: contract
- Fixture/setup: `docs/guides/02-wsl2-ubuntu.md` exists.
- Steps: Check for exactly `wsl --install --distribution <UbuntuLtsDistroName> --location "D:\Software\WSL\Ubuntu"` as the primary command and for target directory absence or intentionally empty precondition.
- Expected result: The primary command and target directory gate match the spec.
- Failure proves: The public command contract drifted.
- Automation location: `tests/markdown/wsl-install-contract.test.*`

### T-SR001-004. Positional install-location command is not primary

- Covers: R9, R14
- Level: static
- Fixture/setup: `docs/guides/02-wsl2-ubuntu.md` exists.
- Steps: Check that `wsl --install Ubuntu --location` is absent as a primary fresh-install command.
- Expected result: The ambiguous positional form is absent or explicitly labeled non-primary/avoid.
- Failure proves: SR-001 regressed.
- Automation location: `tests/markdown/wsl-install-contract.test.*`

### T-SR001-005. Command syntax open question remains resolved

- Covers: R14
- Level: static
- Fixture/setup: Spec and guide docs exist.
- Steps: Scan the spec and guide for unresolved language asking whether to use the positional or long-option fresh-install command.
- Expected result: The question is absent or marked resolved with the long-option form.
- Failure proves: The implementation reintroduced a blocking command-contract ambiguity.
- Automation location: `tests/markdown/wsl-install-contract.test.*`

### T-SR001-006. Post-install WSL verification is documented

- Covers: R13, R14, E1
- Level: static
- Fixture/setup: `docs/guides/02-wsl2-ubuntu.md` and `docs/guides/99-verification.md` exist.
- Steps: Search for `wsl --list --verbose` and distro launch verification.
- Expected result: Post-install verification includes `wsl --list --verbose` and launch/default checks.
- Failure proves: Users cannot confirm the install before moving on.
- Automation location: `tests/markdown/wsl-verification.test.*`

### T-SR001-007. WSL version and selected distro are captured in verification output

- Covers: R8, R9, R14, E1
- Level: manual
- Fixture/setup: Windows 11 machine with current WSL.
- Steps: Follow the fresh-install verification section and record `wsl --version`, selected Ubuntu LTS distro name, and `wsl --list --online` evidence.
- Expected result: Verification output records WSL version and selected explicit Ubuntu distro.
- Failure proves: The setup is not reproducible or reviewable enough.
- Automation location: manual checklist in `docs/guides/99-verification.md`.

### T-SR001-008. Missing `--location` stops fresh custom-location path

- Covers: R9, R14, E1, EC2
- Level: manual
- Fixture/setup: Captured WSL help output without `--location`, or a documented simulated/manual negative-path review.
- Steps: Confirm the guide directs users to run `wsl --update` and `wsl --shutdown`, then stops the fresh path and routes to migration/import docs if `--location` remains unavailable.
- Expected result: The guide does not silently install to a different location.
- Failure proves: Unsupported systems could violate the D-drive storage contract.
- Automation location: manual negative-path checklist.

### T-M2-002. WSL migration/import-in-place path is guarded

- Covers: R10, R11, R12, R13, E2, EC1, EC3, EC4, EC5
- Level: migration
- Fixture/setup: `docs/guides/02-wsl2-ubuntu.md` exists; optional Windows 11 test machine with existing Ubuntu distro.
- Steps: Check that migration docs include `wsl --shutdown`, VHD export or backup, backup/export success gate before unregister, unregister data-loss warning, `wsl --import-in-place`, default reset, distro launch, and rollback. For manual walkthrough, execute only on disposable or backed-up distro.
- Expected result: Migration cannot be considered complete until import and launch verification pass.
- Failure proves: The migration path can lose data or leave the user without a working distro.
- Automation location: `tests/markdown/wsl-migration-safety.test.*` plus manual migration checklist.

### T-M2-003. WSL storage, shared data, and Linux project paths stay distinct

- Covers: R15, R24, E3
- Level: static
- Fixture/setup: WSL and Ubuntu baseline guides exist.
- Steps: Search for `D:\Software\WSL\Ubuntu`, `D:\Data`, `/home/<user>/data`, and `~/src`; verify the docs describe distro storage, shared data, and Linux-heavy project code as separate concepts.
- Expected result: Users are not directed to put all Linux-heavy project work under a Windows-mounted data path.
- Failure proves: The guide can create performance and ownership confusion.
- Automation location: `tests/markdown/storage-data-boundaries.test.*`

### T-M3-001. Proxy primary and fallback paths are documented

- Covers: R18, R19, R20, EC8, EC9
- Level: static
- Fixture/setup: Ubuntu baseline and proxy troubleshooting docs exist.
- Steps: Check for `%UserProfile%\.wslconfig`, `[wsl2]`, `autoProxy=true`, manual environment-variable fallback, PAC known-limitation wording, and manual Windows-to-WSL corporate CA troubleshooting commands using `%UserProfile%\all-certificates`, `/usr/local/share/ca-certificates/win11`, and `sudo update-ca-certificates`.
- Expected result: Automatic proxy mirroring is primary, manual fallback is available, first-slice proxy limits are explicit, and WSL SSL trust repair is documented without automatic certificate installation.
- Failure proves: Package installation may fail with no documented remediation.
- Automation location: `tests/markdown/proxy-policy.test.*`

### T-M3-002. Data mount and WSL config are reversible and verifiable

- Covers: R21, R22, R23, R24, E3, EC6, EC7
- Level: integration
- Fixture/setup: Ubuntu baseline and verification guides exist; optional WSL Ubuntu manual environment.
- Steps: Check for `/etc/wsl.conf` with automount disabled and fstab enabled, fstab mapping or fallback symlink for `/home/<user>/data`, `sudo mount -a`, create/skip/manual guidance when `D:\Data` is missing, and rollback instructions.
- Expected result: Shared data can be configured, validated, and rolled back without making it the Linux project-code default.
- Failure proves: The data mount path is not safe or verifiable.
- Automation location: `tests/markdown/data-mount-policy.test.*` plus manual WSL checklist.

### T-M3-003. Locale validation accepts healthy UTF-8 state

- Covers: R16, R17, EC10
- Level: manual
- Fixture/setup: Ubuntu baseline guide and optional WSL Ubuntu shell.
- Steps: Check that docs define `C.UTF-8` as healthy default, accept user-selected warning-free UTF-8 locales, require locale output to be UTF-8 and warning-free, and document a repair method using `sudo update-locale LANG=C.UTF-8 LC_ALL=` plus an optional `locale-gen` path for regional UTF-8 locales.
- Expected result: Locale guidance is deterministic without forcing regional locale changes.
- Failure proves: Locale failures or valid user locale choices are mishandled.
- Automation location: `tests/markdown/locale-policy.test.*` plus manual locale checklist.

### T-M3-004. Passwordless sudo is optional, validated, and reversible

- Covers: R25, R26, E4, EC11
- Level: manual
- Fixture/setup: Ubuntu baseline guide; optional disposable WSL Ubuntu user.
- Steps: Check that passwordless sudo is opt-in, labeled personal-workstation convenience, uses a project-owned sudoers drop-in, validates with `visudo`, verifies non-interactive behavior, supports skip path, and documents rollback.
- Expected result: Sudo convenience is explicit and reversible.
- Failure proves: The guide silently weakens local security or leaves sudoers unsafe.
- Automation location: `tests/markdown/sudo-policy.test.*` plus manual sudo checklist.

### T-M3-005. Ubuntu helper scripts are syntax-valid and disclose write scope

- Covers: R35, R36, R37
- Level: integration
- Fixture/setup: `scripts/ubuntu/*.sh` exist.
- Steps: Run `bash -n scripts/ubuntu/*.sh`; inspect helper docs or dry-run output for target path, backup behavior, rollback behavior, and user-local or machine-wide scope.
- Expected result: Helpers parse cleanly and do not hide broad writes.
- Failure proves: Optional helpers are unsafe to run or review.
- Automation location: `tests/shell/ubuntu-helper-contract.test.*`

### T-M4-001. Neovim config strategy and language profiles match the contract

- Covers: R27, R28, R29, R30, EC12
- Level: integration
- Fixture/setup: Neovim guide and `config/nvim/` exist.
- Steps: Check that Windows and Ubuntu install paths are documented; one single-file shared config is present at `config/nvim/init.lua`; plugin/runtime state is not shared through a Windows-mounted path; the profile covers editing, navigation, diagnostics, Git indicators, and LSP wiring; additional language support is optional and user-installed.
- Expected result: The Neovim setup is useful without becoming a full distribution or platform-coupled runtime.
- Failure proves: Editor config strategy drifted from the ADR and spec.
- Automation location: `tests/markdown/nvim-policy.test.*` and config layout tests.

### T-M4-002. Neovim runtime verification is documented and runnable where available

- Covers: R27, R31, E5, EC12
- Level: smoke
- Fixture/setup: Neovim installed in Windows and/or Ubuntu environment, or manual transcript.
- Steps: Run or document `nvim --version`; start Neovim without config errors; verify plugin manager status; document `:checkhealth` troubleshooting.
- Expected result: Windows and Ubuntu Neovim checks are separate and failures identify the failing layer.
- Failure proves: The editor setup cannot be verified.
- Automation location: smoke command when `nvim` is installed; otherwise manual checklist.

### T-M4-003. tmux config is Ubuntu-scoped and loadable

- Covers: R33, R34, E5, EC13
- Level: smoke
- Fixture/setup: Ubuntu environment with tmux installed and `config/tmux/` present.
- Steps: Check docs for prefix, panes, windows, mouse, status, and copy mode; run `tmux -V`; load configuration in a clean session when available.
- Expected result: tmux setup is minimal, daily-useful, and verifiable in Ubuntu.
- Failure proves: tmux config is incomplete or incompatible with the documented terminal path.
- Automation location: `tests/shell/tmux-config.test.*` plus manual Ubuntu checklist.

### T-M4-004. Native Windows tmux is not claimed

- Covers: R32
- Level: static
- Fixture/setup: tmux guide and README exist.
- Steps: Search docs for native Windows tmux support claims and verify tmux is scoped to Ubuntu.
- Expected result: The first slice does not claim native Windows tmux support.
- Failure proves: Scope has expanded beyond the spec.
- Automation location: `tests/markdown/tmux-scope.test.*`

### T-M5-001. Doctor status contract is consistent and mostly read-only

- Covers: R35, R36, E5
- Level: contract
- Fixture/setup: Verification guide and doctor helper scripts exist.
- Steps: Check that every doctor layer uses pass, fail, skipped, or needs manual action; inspect doctor helpers for broad writes and require any mutation to be narrowly scoped and documented.
- Expected result: Doctor behavior is predictable and primarily observational.
- Failure proves: Verification can mutate user state unexpectedly or produce inconsistent statuses.
- Automation location: `tests/markdown/doctor-contract.test.*` and helper-script checks.

### T-M5-002. Rollback coverage exists for every state-changing area

- Covers: R38
- Level: static
- Fixture/setup: Guides and troubleshooting docs exist.
- Steps: Check rollback sections for WSL relocation, `.wslconfig`, `/etc/wsl.conf`, fstab/data mount, sudoers, proxy fallback, Neovim config, and tmux config.
- Expected result: Each state-changing setup area has a rollback path.
- Failure proves: Users cannot safely recover from setup changes.
- Automation location: `tests/markdown/rollback-coverage.test.*`

### T-M5-003. Version recording and publication gates are present

- Covers: R3, R4, R14
- Level: contract
- Fixture/setup: Verification guide and release-note/version-record artifact exist.
- Steps: Check that latest stable policy is stated, tested versions are recorded for publication, and WSL command-contract evidence includes official docs and local or release-captured `wsl --help` excerpts.
- Expected result: Published guidance is current, stable-channel, and reviewable.
- Failure proves: Users cannot know what versions were tested or whether command contracts were validated.
- Automation location: `tests/markdown/version-record.test.*`

### T-M5-004. Staged whitespace validation gate is enforced

- Covers: plan PR-001 resolution
- Level: contract
- Fixture/setup: Plan and implementation validation docs exist.
- Steps: Check that milestone validation requires staging intended files, reviewing `git diff --cached --name-only`, and running `git diff --cached --check`; check that repository-wide `git diff --check` remains advisory while known unrelated baseline drift exists.
- Expected result: Whitespace validation blocks new milestone regressions without forcing unrelated cleanup.
- Failure proves: PR-001 regressed.
- Automation location: `tests/markdown/whitespace-policy.test.*`

### T-M5-005. README final orientation matches completed guide set

- Covers: R40
- Level: smoke
- Fixture/setup: README and all numbered guides exist.
- Steps: Verify README links to all numbered guides, states audience/scope, warning labels, setup layers, verification posture, and non-goals.
- Expected result: README is an accurate first-entry point after implementation.
- Failure proves: New users cannot navigate or understand setup risk.
- Automation location: `tests/markdown/readme-final.test.*`

### T-M5-006. Helper write contract is enforced

- Covers: R37
- Level: contract
- Fixture/setup: Helper scripts and their guide sections exist.
- Steps: For each helper that writes files, verify docs and/or dry-run output disclose target path, backup behavior, rollback behavior, and user-local or machine-wide scope.
- Expected result: No helper silently edits sudoers, fstab, WSL config, profile files, or editor/terminal config.
- Failure proves: Automation violates the architecture safety boundary.
- Automation location: `tests/markdown/helper-write-contract.test.*` plus script contract checks.

## Fixtures and data

- Markdown fixtures: README, numbered guides, troubleshooting docs, release notes or version record, review artifacts, and this test spec.
- Windows fixture: Windows 11 machine with current WSL for manual host, WSL install-location, migration/import-in-place, and Windows Neovim checks.
- Ubuntu fixture: Ubuntu on WSL2, preferably disposable or backed up for sudoers, fstab, mount, and tmux checks.
- Disposable migration fixture: a non-production Ubuntu distro or backup/export used only for migration walkthroughs.
- Config fixtures: `config/nvim/` and `config/tmux/` once implemented.
- Script fixtures: `scripts/windows/*.ps1` and `scripts/ubuntu/*.sh` once implemented.
- No secrets, proxy credentials, private hostnames, token material, or private paths beyond documented examples may be used as fixtures.

## Mocking/stubbing policy

- Static documentation tests must inspect real repository files, not mocked docs.
- Script syntax tests may run without executing state-changing behavior.
- Machine-changing paths such as `wsl --unregister`, sudoers edits, fstab writes, and mount commands must be manual, dry-run, or performed only against disposable/backed-up fixtures.
- WSL negative-path behavior may use captured `wsl --help` excerpts or documented manual evidence when an old WSL version is not available.
- Proxy, PAC, corporate CA, and enterprise policy tests may use static/troubleshooting checks and manual notes; do not fabricate enterprise environment behavior.

## Migration or compatibility tests

- T-M2-002 is the primary migration test for existing Ubuntu to `D:\Software\WSL\Ubuntu`.
- T-SR001-008 covers compatibility when `--location` is unavailable.
- T-M2-001 covers Windows 11, Windows Terminal, PowerShell, WinGet, WSL, elevation, and enterprise-policy host compatibility.
- T-M3-001 covers proxy compatibility and first-slice PAC/custom CA deferral.
- T-M3-002 covers DrvFs direct-subdirectory mount fallback.
- T-M4-002 covers Windows versus Ubuntu Neovim differences.
- T-M4-003 and T-M4-004 cover tmux terminal compatibility and Ubuntu-only scope.

## Observability verification

- Doctor outputs must include layer names for Windows host, WSL storage, WSL config, Ubuntu baseline, proxy, data mount, locale, sudo, Neovim Windows, Neovim Ubuntu, and tmux Ubuntu.
- Doctor outputs must use pass, fail, skipped, or needs manual action and include a short remediation hint when failing.
- Verification docs must show the command used to observe each claim.
- Version recording must include PowerShell, WSL, Ubuntu distro, Neovim, tmux, and core lint/format tools when installed.

## Security/privacy verification

- Static checks must confirm warnings appear before destructive or sensitive commands, including `wsl --unregister`, sudoers edits, fstab writes, WSL global config, package sources, proxy settings, and administrator-sensitive Windows commands.
- Proxy docs must warn against putting credentials into shell history when secure alternatives exist.
- Passwordless sudo must be labeled as a local security tradeoff and must be opt-in.
- Tests and manual transcripts must not contain secrets, proxy credentials, tokens, private hostnames, or private machine paths beyond documented examples.

## Performance checks

- Static checks must confirm the guide warns that Linux-heavy project work generally belongs in the WSL filesystem, such as `~/src`, rather than mounted Windows paths.
- Static checks must confirm `D:\Data` and `/home/<user>/data` are described as shared data unless the user accepts mounted-drive performance tradeoffs.
- Doctor checks should be reviewed for repeatable runtime expectations; slow or interactive checks must be labeled before they run.
- No synthetic performance benchmark is required for the first slice.

## Manual QA checklist

- On Windows 11, record `pwsh`, `winget`, `wt`, and WSL availability checks.
- Record `wsl --version`, `wsl --help`, and `wsl --list --online` before fresh custom-location install.
- Select an explicit Ubuntu LTS distro name from `wsl --list --online`.
- Verify the fresh install command uses `wsl --install --distribution <UbuntuLtsDistroName> --location "D:\Software\WSL\Ubuntu"`.
- Verify `wsl --list --verbose` and distro launch after install.
- For migration, use only a backed-up or disposable distro; verify export/backup before any unregister command.
- Verify `D:\Data` to `/home/<user>/data` mount or fallback symlink and `sudo mount -a`.
- Verify locale output is UTF-8 and warning-free.
- If passwordless sudo is enabled, verify `visudo` and non-interactive sudo; if skipped, verify the skip path is documented.
- Verify Windows and Ubuntu Neovim independently.
- Verify Ubuntu tmux with `tmux -V` and clean config load.
- Record any unrun Windows-only checks honestly.

## What not to test and why

- Do not test Windows versions older than Windows 11; they are outside first-slice scope.
- Do not test arbitrary WSL storage roots; only `D:\Software\WSL\Ubuntu` is in scope.
- Do not test native Windows tmux support; the spec explicitly excludes it.
- Do not test full PAC setup or automatic corporate CA setup; first slice keeps corporate CA handling manual and troubleshooting-only.
- Do not test broad language runtime, Docker, database, cloud, Kubernetes, or AI tooling setup; those are non-goals.
- Do not execute destructive migration commands on a production distro during automated tests.
- Do not require repository-wide whitespace cleanup as part of this feature; use staged milestone-scoped whitespace validation.

## Uncovered gaps

None blocking. Windows-specific and machine-changing behavior requires manual verification or disposable fixtures because the current workspace cannot safely execute those paths.

## Next artifacts

- Implement M1.
- Add concrete test files under `tests/markdown/`, `tests/powershell/`, and `tests/shell/` as milestones introduce docs, scripts, and config.
- Update the active plan's progress and validation notes during implementation.

## Follow-on artifacts

None yet.

## Readiness

Active proof surface for implementation. Ready to implement M1. Readiness is not implementation completion, code-review approval, verification, branch readiness, or PR readiness.
