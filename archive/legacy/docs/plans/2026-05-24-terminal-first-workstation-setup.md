# Plan: Terminal-First Workstation Setup First Slice

## Status

- Plan lifecycle state: active
- Terminal disposition: not-terminal

## Purpose / big picture

This plan sequences the first implementation slice for a documentation-first Windows 11 terminal development workstation guide. The work turns the accepted proposal, approved spec, approved architecture package, and ADRs into a reviewable set of guides, optional helpers, configuration examples, and verification surfaces.

Implementation proceeds milestone by milestone after plan-review approval and active test-spec acceptance.

## Source artifacts

- Proposal: `docs/proposals/2026-05-24-bootstrap-terminal-first-windows-dev.md`
- Proposal review: `docs/changes/2026-05-24-terminal-first-workstation-setup/reviews/proposal-review.md`
- Spec: `specs/terminal-first-workstation-setup.md`
- Spec review: `docs/changes/2026-05-24-terminal-first-workstation-setup/reviews/spec-review.md`
- Architecture: `docs/architecture/system/architecture.md`
- Architecture review: `docs/changes/2026-05-24-terminal-first-workstation-setup/reviews/architecture-review.md`
- Architecture review resolution: `docs/changes/2026-05-24-terminal-first-workstation-setup/reviews/architecture-review-resolution.md`
- ADRs:
  - `docs/adr/2026-05-24-version-and-package-policy.md`
  - `docs/adr/2026-05-24-wsl-storage-and-data-mount-policy.md`
  - `docs/adr/2026-05-24-proxy-strategy.md`
  - `docs/adr/2026-05-24-neovim-plugin-baseline.md`
- Test spec: `specs/terminal-first-workstation-setup.test.md`

## Context and orientation

The repository is currently documentation-first. There is no implementation code, test framework, CI workflow, setup script, or established local validation command yet.

The implementation surface should follow the architecture package:

- `README.md` becomes the first-reader entry point and guide index.
- `docs/guides/` contains numbered setup guides for Windows host, WSL2 Ubuntu, Ubuntu baseline, Neovim, tmux, and consolidated verification.
- `scripts/windows/` contains optional PowerShell helpers and doctor checks.
- `scripts/ubuntu/` contains optional shell helpers and doctor checks.
- `config/nvim/` contains one concise shared Neovim `init.lua`.
- `config/tmux/` contains Ubuntu tmux configuration.
- `specs/terminal-first-workstation-setup.test.md` will be created by the test-spec stage before implementation.

Machine-changing commands must stay visible in the docs near their safety notes. Helpers must disclose target paths, backup behavior, rollback behavior, and whether the write affects user-local or machine-wide state.

## Non-goals

- Do not create a one-command unattended installer.
- Do not add broad language-runtime setup for Node.js, Python, Go, Rust, Java, databases, Docker, Kubernetes, cloud CLIs, or AI tooling.
- Do not support native Windows tmux.
- Do not support arbitrary WSL storage roots beyond `D:\Software\WSL\Ubuntu`.
- Do not implement full PAC or corporate CA setup in the first slice.
- Do not silently enable passwordless sudo.

## Requirements covered

| Requirements | Planned coverage |
| --- | --- |
| R1-R7, R40 | M1 and M2 establish README orientation, Windows 11 scope, Windows Terminal, PowerShell, WinGet, elevation/policy notes, and host verification. |
| R8-R15, R38 | M2 covers explicit Ubuntu LTS selection, WSL fresh custom-location install, migration/import-in-place, destructive warnings, storage/data separation, verification, and rollback. |
| R16-R26, R35-R38 | M3 covers Ubuntu locale, proxy, wsl.conf, fstab/data mount, optional passwordless sudo, doctor status values, helper write rules, and rollback. |
| R27-R34 | M4 covers Neovim on Windows and Ubuntu, one single-file shared config, optional language support, health checks, and Ubuntu tmux config/verification. |
| R3-R4, R14, R35-R40 | M5 covers version records, publication gates, static checks, doctor-check consistency, consolidated verification, README readiness, and release notes. |

## Current Handoff Summary

- Current milestone: final closeout
- Current milestone state: verify-complete
- Last reviewed milestone: M5
- Review status: M5 code-review completed with clean-with-notes; M5 closed
- Remaining in-scope implementation milestones: none
- Next stage: pr
- Final closeout readiness: ready for PR handoff
- Reason final closeout is or is not ready: all implementation milestones are closed, explain-change is complete, final verify passed, and PR handoff remains.

## Milestones

### M1. Project entry point and guide skeleton

- Milestone state: closed
- Goal: Replace generic first-reader content with project-specific orientation and create the numbered guide structure without adding risky helper behavior yet.
- Requirements: R1, R2, R3, R7, R35, R37, R39, R40
- Files/components likely touched:
  - `README.md`
  - `docs/guides/01-windows-host.md`
  - `docs/guides/02-wsl2-ubuntu.md`
  - `docs/guides/03-ubuntu-baseline.md`
  - `docs/guides/04-neovim.md`
  - `docs/guides/05-tmux.md`
  - `docs/guides/99-verification.md`
  - `docs/troubleshooting/`
- Dependencies:
  - Approved plan-review.
  - Test spec defining static guide and safety-warning checks.
- Tests to add/update:
  - Static docs checks for guide index, environment labels, warning placement, and absence of one-command unattended installer language.
- Implementation steps:
  - Replace template README content with concise project orientation and guide index.
  - Create guide files with scoped sections, command environment labels, safety-warning placeholders, validation sections, and rollback sections.
  - Add troubleshooting placeholders for enterprise policy, proxy limitations, and WSL command-version drift.
- Validation commands:
  - `test -f docs/guides/01-windows-host.md && test -f docs/guides/99-verification.md`
  - `grep -n 'one-command unattended' README.md docs/guides/*.md`
  - Static checks from `specs/terminal-first-workstation-setup.test.md` after test-spec exists.
- Result:
  - Added static proof first in `tests/markdown/m1-project-entrypoint.test.sh`; initial run failed because the guide skeleton did not exist.
  - Replaced README template content with project-specific orientation while preserving the vision block.
  - Added numbered guide skeletons with command environment, safety notes, validation, and rollback sections.
  - Added troubleshooting placeholders for enterprise policy, proxy limits, and WSL command/version drift.
  - Validation passed with the M1 static test, required file check, one-command unattended guardrail grep, and scoped whitespace check.
- Expected observable result: First-time readers can see scope, supported path, warnings, guide order, and verification posture before running commands.
- Commit message: `M1: add workstation guide entry point`
- Milestone closeout:
  - validation passed
  - progress updated
  - decision log updated if needed
  - validation notes updated
  - milestone committed
- Risks:
  - README could duplicate or drift from `VISION.md`.
  - Guide skeleton could look complete before commands are validated.
- Rollback/recovery:
  - Revert README and guide skeleton changes for this milestone, preserving upstream governance artifacts.

### M2. Windows host and WSL storage guides

- Milestone state: closed
- Goal: Document Windows host setup, WSL fresh install to `D:\Software\WSL\Ubuntu`, existing-distro migration, verification, and rollback.
- Requirements: R1-R15, R35, R37, R38
- Files/components likely touched:
  - `docs/guides/01-windows-host.md`
  - `docs/guides/02-wsl2-ubuntu.md`
  - `docs/guides/99-verification.md`
  - `scripts/windows/doctor-windows.ps1`
  - `scripts/windows/check-wsl-storage.ps1`
  - `docs/troubleshooting/wsl.md`
- Dependencies:
  - M1 guide structure.
  - Test spec checks for SR-001 command contract and migration safety.
- Tests to add/update:
  - Static docs tests for `wsl --list --online`, `wsl --help`, `--distribution`, `--location`, `wsl --list --verbose`, and absence of positional install-location command as primary.
  - PowerShell syntax checks for Windows doctor helpers if scripts are added.
  - Manual Windows 11 verification checklist for fresh install and migration paths.
- Implementation steps:
  - Document PowerShell 7 install/update through supported package paths and host verification commands.
  - Document fresh WSL install-location path using `wsl --install --distribution <UbuntuLtsDistroName> --location "D:\Software\WSL\Ubuntu"`.
  - Document migration path with `wsl --shutdown`, successful export/backup before unregister, `wsl --import-in-place`, default reset, launch verification, and rollback.
  - Add read-only or narrowly scoped Windows doctor helpers only where they can be inspected and tested.
- Validation commands:
  - `grep -n 'wsl --install --distribution <UbuntuLtsDistroName> --location "D:\\Software\\WSL\\Ubuntu"' docs/guides/02-wsl2-ubuntu.md`
  - `! grep -n 'wsl --install Ubuntu --location' docs/guides/02-wsl2-ubuntu.md`
  - `grep -n 'wsl --list --verbose' docs/guides/02-wsl2-ubuntu.md docs/guides/99-verification.md`
  - PowerShell parser or analyzer command selected by the test spec.
- Result:
  - Added static proof first in `tests/markdown/m2-windows-wsl-storage.test.sh`; initial run failed because the M2 guide details were not yet implemented.
  - Filled Windows host setup with latest-stable PowerShell WinGet install/update path, host verification commands, and elevation/policy notes.
  - Filled WSL2 Ubuntu setup with storage policy, fresh D-drive install-location prechecks, explicit long-option install command, unsupported-option stop behavior, migration/import-in-place path, verification, and rollback.
  - Updated consolidated verification with Windows host, WSL fresh install, and WSL migration checks.
  - Updated WSL troubleshooting with unsupported `--location`, import-in-place recovery, and storage path notes.
  - No Windows helper scripts were added in M2; the approved M2 contract is satisfied by auditable documentation and static proof, and helper scripts remain optional for later implementation.
  - Validation passed with the M2 static test, M1 regression test, exact WSL command grep, positional-command negative grep, and scoped whitespace check.
- Expected observable result: Users have a safe, version-gated WSL setup path for both fresh install and migration to D-drive storage.
- Commit message: `M2: document Windows host and WSL storage setup`
- Milestone closeout:
  - validation passed
  - progress updated
  - decision log updated if needed
  - validation notes updated
  - milestone committed
- Risks:
  - WSL command options vary by installed WSL version.
  - Migration commands can destroy a distro if users skip backup/export verification.
- Rollback/recovery:
  - Keep migration rollback instructions in the guide.
  - Revert milestone docs/scripts if command contract or validation evidence fails review.

### M3. Ubuntu baseline, proxy, data mount, locale, and sudo

- Milestone state: closed
- Goal: Document and optionally script Ubuntu baseline setup with explicit safety gates for WSL config, proxy, data mount, locale, and passwordless sudo.
- Requirements: R16-R26, R35-R38
- Files/components likely touched:
  - `docs/guides/03-ubuntu-baseline.md`
  - `docs/guides/99-verification.md`
  - `docs/troubleshooting/proxy.md`
  - `docs/troubleshooting/ubuntu-baseline.md`
  - `scripts/ubuntu/baseline.sh`
  - `scripts/ubuntu/setup-data-mount.sh`
  - `scripts/ubuntu/doctor-ubuntu.sh`
- Dependencies:
  - M1 guide structure.
  - M2 WSL storage guide for target paths and WSL assumptions.
  - Test spec checks for fstab, sudoers, proxy, locale, and doctor status behavior.
- Tests to add/update:
  - Shell syntax checks for Ubuntu helpers.
  - Static docs checks for `%UserProfile%\.wslconfig`, `[wsl2] autoProxy=true`, `/etc/wsl.conf`, `/home/<user>/data`, `sudo mount -a`, `C.UTF-8`, `visudo`, and rollback instructions.
  - Manual verification checklist for data mount, locale warnings, proxy fallback, and non-interactive sudo when enabled.
- Implementation steps:
  - Document `.wslconfig` auto-proxy primary path and manual environment-variable fallback.
  - Document `/etc/wsl.conf` and fstab data mount with fallback symlink path.
  - Document locale validation and `C.UTF-8` healthy default without rejecting user-selected UTF-8 locales.
  - Document optional passwordless sudo as a personal-workstation convenience profile with project-owned sudoers drop-in, `visudo`, non-interactive verification, and rollback.
  - Add helpers only if they disclose targets, backup behavior, rollback behavior, and scope before writes.
- Validation commands:
  - `grep -n 'autoProxy=true' docs/guides/03-ubuntu-baseline.md`
  - `grep -n '/home/<user>/data' docs/guides/03-ubuntu-baseline.md docs/guides/99-verification.md`
  - `grep -n 'visudo' docs/guides/03-ubuntu-baseline.md`
  - `bash -n scripts/ubuntu/*.sh` once scripts exist.
- Result:
  - Added static proof first in `tests/markdown/m3-ubuntu-baseline.test.sh`; initial run failed because `docs/troubleshooting/ubuntu-baseline.md` did not exist and M3 guide details were not implemented.
  - Filled Ubuntu baseline setup with WSL automatic proxy mirroring, manual proxy fallback, `/etc/wsl.conf`, fstab data mount, fallback symlink path, locale checks, optional passwordless sudo, doctor status expectations, validation, and rollback.
  - Updated proxy troubleshooting with auto-proxy restart behavior, manual fallback cautions, and PAC/corporate CA known limitations.
  - Added Ubuntu baseline troubleshooting for WSL config, data mount, locale, sudoers validation, and helper write disclosure.
  - Updated consolidated verification with WSL config, proxy, data mount, locale, and optional sudo checks.
  - No Ubuntu helper scripts were added in M3; the approved M3 contract is satisfied by auditable documentation and static proof, and helper scripts remain optional for later implementation.
  - Validation passed with the M3 static test, M1 and M2 regression tests, required command greps, and scoped whitespace check.
- Expected observable result: Ubuntu baseline setup is explicit, reversible, and verifiable without hiding machine-changing writes.
- Commit message: `M3: add Ubuntu baseline setup and checks`
- Milestone closeout:
  - validation passed
  - progress updated
  - decision log updated if needed
  - validation notes updated
  - milestone committed
- Risks:
  - fstab or sudoers mistakes can break login ergonomics or mount behavior.
  - Proxy behavior may vary under VPN, PAC, or corporate CA environments.
- Rollback/recovery:
  - Require backup files before helper writes.
  - Document removal of project-owned sudoers drop-in, fstab entries, profile snippets, and WSL config entries.

### M4. Neovim and tmux setup

- Milestone state: closed
- Goal: Provide minimal, useful Neovim and tmux setup without turning the project into a full dotfiles distribution.
- Requirements: R27-R34, R35, R37, R38
- Files/components likely touched:
  - `docs/guides/04-neovim.md`
  - `docs/guides/05-tmux.md`
  - `docs/guides/99-verification.md`
  - `config/nvim/`
  - `config/tmux/`
  - `scripts/windows/doctor-windows.ps1`
  - `scripts/ubuntu/doctor-ubuntu.sh`
- Dependencies:
  - M1 guide structure.
  - Test spec checks for config layout, plugin profile, and verification commands.
- Tests to add/update:
  - Static docs checks for Windows and Ubuntu Neovim install paths, `nvim --version`, startup verification, plugin manager status, and `:checkhealth`.
  - Static docs checks for `tmux -V` and clean-session config loading.
  - Config syntax or startup checks where available in the current environment.
- Implementation steps:
  - Add one concise shared Neovim `init.lua`.
  - Keep the editor profile concise; document additional language support as optional and user-installed.
  - Add Ubuntu-only tmux config covering prefix, panes, windows, mouse, status, and copy mode.
  - Extend doctor guidance for Neovim Windows, Neovim Ubuntu, and tmux Ubuntu.
- Validation commands:
  - `grep -n 'nvim --version' docs/guides/04-neovim.md docs/guides/99-verification.md`
  - `grep -n ':checkhealth' docs/guides/04-neovim.md`
  - `grep -n 'tmux -V' docs/guides/05-tmux.md docs/guides/99-verification.md`
  - Config-specific syntax checks selected by the test spec.
- Result:
  - Added static proof first in `tests/markdown/m4-neovim-tmux.test.sh`; initial run failed because `config/nvim/init.lua` and the M4 config layout did not exist.
  - Filled Neovim guide with Windows and Ubuntu install paths, one single-file shared config strategy, optional language support, plugin baseline, verification, and rollback.
  - Added shared Neovim config under `config/nvim/init.lua` with a small plugin baseline and Lua LSP wiring.
  - Filled tmux guide with Ubuntu-only scope, install path, daily-use baseline, `tmux -V`, clean-session config-load verification, and rollback.
  - Added Ubuntu tmux config under `config/tmux/tmux.conf` covering prefix, panes, windows, mouse, status, and copy-mode behavior.
  - Updated consolidated verification with Neovim Windows, Neovim Ubuntu, and tmux Ubuntu checks.
  - Validation passed with the M4 static test, M1-M3 regression tests, Neovim source-config smoke with explicit runtimepath, tmux clean-session config load, required command greps, and scoped whitespace check.
- Expected observable result: Users can install and verify a small terminal editor and tmux baseline on the documented platforms.
- Commit message: `M4: add Neovim and tmux setup`
- Milestone closeout:
  - validation passed
  - progress updated
  - decision log updated if needed
  - validation notes updated
  - milestone committed
- Risks:
  - Neovim plugin drift can make startup checks unstable.
  - Windows and Ubuntu config paths can diverge if the single-file config is not deployed consistently.
- Rollback/recovery:
  - Document restoring backed-up Neovim and tmux config directories.
  - Keep plugin runtime state out of Windows-mounted shared paths.

### M5. Verification, static checks, and release readiness docs

- Milestone state: closed
- Goal: Add the consolidated verification surface, version-record policy, static checks, and release-readiness notes needed before final review.
- Requirements: R3-R4, R14, R35-R40
- Files/components likely touched:
  - `docs/guides/99-verification.md`
  - `docs/release-notes/`
  - `tests/markdown/`
  - `tests/powershell/`
  - `tests/shell/`
  - `.github/workflows/` if lightweight CI becomes justified by test-spec
  - `README.md`
- Dependencies:
  - M1-M4 implementation surfaces.
  - Test spec must define exact static, syntax, negative-path, and manual checks.
- Tests to add/update:
  - Static docs checks for requirement coverage and command contract gates.
  - Markdown linting or link checking if tooling is added.
  - PowerShell and shell syntax checks for helper scripts.
  - Manual verification checklist for Windows-only behavior not runnable in this environment.
- Implementation steps:
  - Add consolidated doctor/verification guide with pass, fail, skipped, and needs manual action statuses.
  - Add tested-version record format for publication.
  - Add static test structure and minimal CI only if the commands are reliable and scoped.
  - Confirm README links to final guide set and warning labels.
- Validation commands:
  - Static command suite defined by `specs/terminal-first-workstation-setup.test.md`.
  - `git diff --cached --name-only`
  - `git diff --cached --check`
  - Manual Windows 11 walkthrough evidence when available, or clearly marked unrun risk when unavailable.
- Result:
  - Added static proof first in `tests/markdown/m5-release-readiness.test.sh`; initial run failed because `docs/release-notes/2026-05-24-tested-versions.md` did not exist.
  - Replaced the verification guide placeholder with a consolidated verification matrix, publication gate, static check commands, whitespace validation policy, rollback coverage, and final validation summary.
  - Added `docs/release-notes/2026-05-24-tested-versions.md` with latest-stable policy, tested-version recording fields, WSL command-contract evidence requirements, and explicit unrun/manual Windows check status.
  - Updated README troubleshooting links to include Ubuntu baseline troubleshooting.
  - Validation passed with M1-M5 static tests, Neovim/tmux config smoke checks, required publication-gate greps, and scoped whitespace check.
- Expected observable result: Reviewers can verify the implementation against spec requirements before final lifecycle closeout.
- Commit message: `M5: add verification and release readiness checks`
- Milestone closeout:
  - validation passed
  - progress updated
  - decision log updated if needed
  - validation notes updated
  - milestone committed
- Risks:
  - CI may be premature before scripts and tests stabilize.
  - Manual Windows checks cannot run from the current Linux workspace.
- Rollback/recovery:
  - Revert CI or test harness additions independently if unreliable.
  - Keep manual verification gaps explicit rather than treating them as passing.

## Validation plan

- Plan review: `docs/plans/2026-05-24-terminal-first-workstation-setup.md` must be reviewed before test-spec or implementation.
- Test-spec: create `specs/terminal-first-workstation-setup.test.md` after plan-review and before implementation.
- Static docs checks: validate required command strings, forbidden primary command strings, warning placement, guide links, and requirement coverage.
- Script syntax checks: use PowerShell parser/analyzer for `scripts/windows/*.ps1` and `bash -n` or shell linting for `scripts/ubuntu/*.sh` when scripts exist.
- Config checks: validate Neovim and tmux config syntax/startup where available; otherwise document unrun platform-specific checks.
- Manual checks: record Windows 11/WSL verification evidence for WSL install-location, migration/import-in-place, Windows Terminal, PowerShell, and Windows Neovim behavior.
- Milestone whitespace gate: stage only files intentionally changed for the current milestone, review `git diff --cached --name-only`, then run `git diff --cached --check`.
- Advisory repository check: `git diff --check` remains useful only after the known unrelated template/community whitespace baseline is resolved or when its failures are explicitly triaged as unrelated.

### Whitespace validation policy

The required whitespace gate for this change is staged and milestone-scoped:

```bash
git diff --cached --name-only
git diff --cached --check
```

Before running the gate, stage only files intentionally changed for the current milestone. The staged file list must be reviewed as part of milestone validation.

For local prechecks before staging, contributors may run a path-scoped working-tree check:

```bash
git diff --check -- <milestone-file-or-directory> [<more-paths>...]
```

Whitespace validation is scoped to the staged milestone diff. Do not use repository-wide `git diff --check` as a required milestone gate while the repository has known unrelated template/community whitespace drift.

Repository-wide `git diff --check` is advisory until the known pre-existing whitespace baseline is resolved. A repository-wide failure from unrelated template/community files must not block this change unless the current milestone intentionally edits those files.

## Risks and recovery

- Risk: WSL storage migration can lose data if unregister happens before export/backup verification.
  - Recovery: keep migration docs gated, require backup/export evidence, and stop on failed export.
- Risk: WSL install-location support varies by WSL version.
  - Recovery: require `wsl --help` and official documentation evidence before publication; route unsupported systems to migration/import guidance.
- Risk: fstab, sudoers, and proxy helper writes can break local behavior.
  - Recovery: require target disclosure, backups, validation commands, and rollback sections before helper writes are accepted.
- Risk: Neovim plugin behavior can drift.
  - Recovery: keep plugin set small, use lockfiles where reproducibility matters, and separate optional profiles.
- Risk: This Linux workspace cannot execute Windows-specific validation.
  - Recovery: document manual Windows verification commands and mark unrun checks honestly until a Windows walkthrough exists.
- Risk: Repository-wide whitespace baseline is already dirty.
  - Recovery: use staged milestone-scoped `git diff --cached --check`; keep full `git diff --check` advisory until a separate cleanup change resolves the baseline.

## Dependencies

- Plan-review must approve this plan before test-spec.
- Test-spec must define static, syntax, manual, and negative-path checks before implementation.
- Implementation must preserve accepted proposal, approved spec, approved architecture, and accepted ADR boundaries.
- Windows-specific verification depends on access to a Windows 11 machine with current WSL.
- No downstream stage may claim final readiness until all milestones are closed and review/verification evidence exists.

## Progress

- 2026-05-24: Plan created after proposal acceptance, spec approval, architecture approval, and architecture status normalization.
- 2026-05-24: Plan-review approved, test spec accepted by owner, and test spec activated for implementation.
- 2026-05-24: M1 implemented and moved to review-requested after static proof and scoped validation passed.
- 2026-05-24: M1 code-review completed with clean-with-notes; M1 closed and handoff moved to M2 implementation.
- 2026-05-24: M2 implemented and moved to review-requested after static proof and scoped validation passed.
- 2026-05-24: M2 code-review completed with clean-with-notes; M2 closed and handoff moved to M3 implementation.
- 2026-05-24: M3 implemented and moved to review-requested after static proof and scoped validation passed.
- 2026-05-24: M3 code-review completed with clean-with-notes; M3 closed and handoff moved to M4 implementation.
- 2026-05-24: M4 implemented and moved to review-requested after static proof, config smoke checks, and scoped validation passed.
- 2026-05-24: M4 code-review completed with clean-with-notes; M4 closed and handoff moved to M5 implementation.
- 2026-05-24: M5 implemented and moved to review-requested after release-readiness static proof and scoped validation passed.
- 2026-05-24: M5 code-review completed with clean-with-notes; M5 closed and handoff moved to final closeout via explain-change.
- 2026-05-24: Final explain-change artifact refreshed from the actual diff, review outcomes, and validation evidence; handoff moved to verify.
- 2026-05-24: Final verify passed on committed branch state; handoff moved to PR preparation.

## Decision log

| Date | Decision | Reason | Alternatives rejected |
| --- | --- | --- | --- |
| 2026-05-24 | Use five implementation milestones split by setup layer and verification maturity | Matches the architecture boundaries and keeps each slice reviewable | One large implementation milestone; tiny per-file milestones |
| 2026-05-24 | Put the active execution plan under `docs/changes/2026-05-24-terminal-first-workstation-setup/plan.md` | Matched the workflow guide's change-plan location at the time | A standalone `docs/plans/` plan outside the change record |
| 2026-06-17 | Migrate the active execution plan to `docs/plans/2026-05-24-terminal-first-workstation-setup.md` | Owner updated workflow routing so plan bodies live under `docs/plans/` | Keeping the plan body under `docs/changes/<change-id>/plan.md` |
| 2026-05-24 | Defer test-spec until after plan-review | Matches the lifecycle order and lets tests trace to approved milestones | Writing tests directly from spec without reviewing implementation sequence |
| 2026-05-24 | Use staged milestone-scoped whitespace validation | Full `git diff --check` is known to fail before implementation due to unrelated template/community baseline drift | Forcing unrelated cleanup into this feature; ignoring whitespace validation entirely |

## Surprises and discoveries

- The plan skill assets were present under `.agents/skills/plan/assets/`.
- Architecture status needed normalization from `draft` to `approved` before downstream planning relied on it.
- The M1 static proof failed first on the missing guide skeleton, then passed after README and guide skeleton implementation.
- The M2 static proof failed first on missing host/WSL guide details, then passed after the Windows host, WSL storage, verification, and troubleshooting docs were filled.
- The M3 static proof failed first on the missing Ubuntu baseline troubleshooting surface, then passed after Ubuntu baseline, verification, proxy troubleshooting, and Ubuntu troubleshooting docs were filled.
- The M4 static proof failed first on the missing Neovim config layout, then passed after Neovim docs/config, tmux docs/config, and verification docs were filled.
- The M5 static proof failed first on the missing tested-version release note, then passed after the verification guide, release note, README link, and release-readiness checks were filled.

## Validation notes

- Plan-review approved.
- Test spec active: `specs/terminal-first-workstation-setup.test.md`.
- Known baseline issue: repository-wide `git diff --check` currently fails before implementation because unrelated template/community files have existing trailing-whitespace or line-ending drift, including `CODE_OF_CONDUCT.md`, `CONTRIBUTING.md`, `LICENSE`, `README.md`, and `SECURITY.md`. This plan uses staged milestone-scoped whitespace validation so new regressions are blocked without forcing unrelated cleanup into this feature.
- M1 validation:
  - `bash tests/markdown/m1-project-entrypoint.test.sh` passed.
  - `test -f docs/guides/01-windows-host.md && test -f docs/guides/99-verification.md` passed.
  - `grep -n 'one-command unattended' README.md docs/guides/*.md` passed.
  - `git diff --check -- README.md docs/guides docs/troubleshooting tests/markdown/m1-project-entrypoint.test.sh` passed.
- M1 code-review:
  - Review status: clean-with-notes.
  - Review record: `docs/changes/2026-05-24-terminal-first-workstation-setup/review-log.md`.
  - Required review-resolution: no.
- M2 validation:
  - `bash tests/markdown/m2-windows-wsl-storage.test.sh` passed.
  - `bash tests/markdown/m1-project-entrypoint.test.sh` passed.
  - `grep -n 'wsl --install --distribution <UbuntuLtsDistroName> --location "D:\\Software\\WSL\\Ubuntu"' docs/guides/02-wsl2-ubuntu.md` passed.
  - `! grep -n 'wsl --install Ubuntu --location' docs/guides/02-wsl2-ubuntu.md` passed.
  - `git diff --check -- docs/guides/01-windows-host.md docs/guides/02-wsl2-ubuntu.md docs/guides/99-verification.md docs/troubleshooting/wsl.md tests/markdown/m2-windows-wsl-storage.test.sh` passed.
- M2 code-review:
  - Review status: clean-with-notes.
  - Review record: `docs/changes/2026-05-24-terminal-first-workstation-setup/review-log.md`.
  - Required review-resolution: no.
- M3 validation:
  - `bash tests/markdown/m3-ubuntu-baseline.test.sh` passed.
  - `bash tests/markdown/m1-project-entrypoint.test.sh` passed.
  - `bash tests/markdown/m2-windows-wsl-storage.test.sh` passed.
  - `grep -n 'autoProxy=true' docs/guides/03-ubuntu-baseline.md` passed.
  - `grep -n '/home/<user>/data' docs/guides/03-ubuntu-baseline.md docs/guides/99-verification.md` passed.
  - `grep -n 'visudo' docs/guides/03-ubuntu-baseline.md` passed.
  - `git diff --check -- docs/guides/03-ubuntu-baseline.md docs/guides/99-verification.md docs/troubleshooting/proxy.md docs/troubleshooting/ubuntu-baseline.md tests/markdown/m3-ubuntu-baseline.test.sh` passed.
  - `bash -n scripts/ubuntu/*.sh` was not run because no Ubuntu helper scripts exist yet.
- M3 code-review:
  - Review status: clean-with-notes.
  - Review record: `docs/changes/2026-05-24-terminal-first-workstation-setup/review-log.md`.
  - Required review-resolution: no.
- M4 validation:
  - `bash tests/markdown/m4-neovim-tmux.test.sh` passed.
  - `bash tests/markdown/m1-project-entrypoint.test.sh` passed.
  - `bash tests/markdown/m2-windows-wsl-storage.test.sh` passed.
  - `bash tests/markdown/m3-ubuntu-baseline.test.sh` passed.
  - `nvim --headless --cmd 'set runtimepath^=config/nvim' -u config/nvim/init.lua +qa` passed.
  - `tmux -f config/tmux/tmux.conf new-session -d -s terminal-first-check && tmux kill-session -t terminal-first-check` passed.
  - `grep -n 'nvim --version' docs/guides/04-neovim.md docs/guides/99-verification.md` passed.
  - `grep -n ':checkhealth' docs/guides/04-neovim.md` passed.
  - `grep -n 'tmux -V' docs/guides/05-tmux.md docs/guides/99-verification.md` passed.
  - `git diff --check -- docs/guides/04-neovim.md docs/guides/05-tmux.md docs/guides/99-verification.md config/nvim config/tmux tests/markdown/m4-neovim-tmux.test.sh` passed.
- M4 code-review:
  - Review status: clean-with-notes.
  - Review record: `docs/changes/2026-05-24-terminal-first-workstation-setup/review-log.md`.
  - Required review-resolution: no.
- M5 validation:
  - `bash tests/markdown/m5-release-readiness.test.sh` passed.
  - `bash tests/markdown/m1-project-entrypoint.test.sh` passed.
  - `bash tests/markdown/m2-windows-wsl-storage.test.sh` passed.
  - `bash tests/markdown/m3-ubuntu-baseline.test.sh` passed.
  - `bash tests/markdown/m4-neovim-tmux.test.sh` passed.
  - `nvim --headless --cmd 'set runtimepath^=config/nvim' -u config/nvim/init.lua +qa` passed.
  - `tmux -f config/tmux/tmux.conf new-session -d -s terminal-first-check && tmux kill-session -t terminal-first-check` passed.
  - `grep -n 'Publication gate' docs/guides/99-verification.md` passed.
  - `grep -n 'Microsoft Learn' docs/guides/99-verification.md docs/release-notes/2026-05-24-tested-versions.md` passed.
  - `grep -n 'git diff --cached --check' docs/guides/99-verification.md docs/plans/2026-05-24-terminal-first-workstation-setup.md` passed.
  - `git diff --check -- docs/guides/99-verification.md docs/release-notes/2026-05-24-tested-versions.md README.md tests/markdown/m5-release-readiness.test.sh docs/plans/2026-05-24-terminal-first-workstation-setup.md docs/changes/2026-05-24-terminal-first-workstation-setup/change.yaml docs/changes/2026-05-24-terminal-first-workstation-setup/explain-change.md docs/plan.md` passed.
  - Temporary-index staged gate passed with the M5 file set: `git diff --cached --name-only` and `git diff --cached --check`.
- M5 code-review:
  - Review status: clean-with-notes.
  - Review record: `docs/changes/2026-05-24-terminal-first-workstation-setup/review-log.md`.
  - Required review-resolution: no.
- Explain-change:
  - Updated `docs/changes/2026-05-24-terminal-first-workstation-setup/explain-change.md`.
  - `bash tests/markdown/m1-project-entrypoint.test.sh` passed.
  - `bash tests/markdown/m2-windows-wsl-storage.test.sh` passed.
  - `bash tests/markdown/m3-ubuntu-baseline.test.sh` passed.
  - `bash tests/markdown/m4-neovim-tmux.test.sh` passed.
  - `bash tests/markdown/m5-release-readiness.test.sh` passed.
  - `git diff --check -- docs/changes/2026-05-24-terminal-first-workstation-setup/explain-change.md` passed.
- Final verify:
  - `bash tests/markdown/m1-project-entrypoint.test.sh` passed.
  - `bash tests/markdown/m2-windows-wsl-storage.test.sh` passed.
  - `bash tests/markdown/m3-ubuntu-baseline.test.sh` passed.
  - `bash tests/markdown/m4-neovim-tmux.test.sh` passed.
  - `bash tests/markdown/m5-release-readiness.test.sh` passed.
  - `nvim --headless --cmd 'set runtimepath^=config/nvim' -u config/nvim/init.lua +qa` passed.
  - `tmux -f config/tmux/tmux.conf new-session -d -s terminal-first-check && tmux kill-session -t terminal-first-check` passed.
  - `git diff --check` passed on the committed branch state before lifecycle handoff metadata was updated.

## Outcome and retrospective

- Implementation, review, explain-change, and final verify are complete. PR handoff remains.

## Readiness

- See `Current Handoff Summary`.
- M1, M2, M3, M4, and M5 are closed. Explain-change and final verify are complete. Ready for PR handoff.
- Readiness is not Done; PR handoff remains.
