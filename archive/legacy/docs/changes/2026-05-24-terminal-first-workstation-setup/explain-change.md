# Explain Change: Terminal-First Workstation Setup First Slice

## Summary

This change turns the repository from a generic starter template into a documentation-first playbook for a terminal-first Windows 11 development workstation.

The implementation adds:

- project identity and workflow/governance docs;
- proposal, spec, architecture, ADR, plan, review, and test-spec artifacts;
- numbered setup guides for Windows host, WSL2 Ubuntu, Ubuntu baseline, Neovim, tmux, optional uv, and verification;
- troubleshooting notes for enterprise policy, proxy, WSL, and Ubuntu baseline issues;
- example Neovim and tmux config files;
- static proof scripts for each implementation milestone;
- a tested-version release note template and publication gate.

The work intentionally remains readable and documentation-first. It does not add a one-command installer, mandatory broad runtime setup, CI, or state-changing helper scripts.

## Problem

The repository existed as a generic template, but the owner wanted a concise project for setting up terminal-first Windows 11 development. The final guide needed to cover latest stable PowerShell, WSL2 Ubuntu stored under `D:\Software\WSL\Ubuntu`, shared `D:\Data` exposure in Ubuntu, locale/proxy/sudo posture, Neovim on Windows and Ubuntu, and tmux on Ubuntu.

The key risks were unsafe automation, ambiguous WSL command contracts, destructive WSL migration, sudoers/fstab mistakes, proxy credential leakage, and unverified Windows-only behavior being treated as passed.

## Decision Trail

| Stage | Decision | Source |
| --- | --- | --- |
| Exploration/proposal | Use a documentation-first guide with small inspectable helpers only when needed. | `docs/proposals/2026-05-24-bootstrap-terminal-first-windows-dev.md` |
| Proposal review | Resolve open questions as decisions: explicit Ubuntu LTS, latest stable policy, `D:\Software\WSL\Ubuntu`, `/home/<user>/data`, `C.UTF-8`, WSL auto proxy, optional sudo, shared Neovim source config, Windows Terminal. | `docs/changes/2026-05-24-terminal-first-workstation-setup/reviews/proposal-review.md` |
| Spec | Requirements R1-R40 define the observable setup contract. | `specs/terminal-first-workstation-setup.md` |
| Architecture | Keep the architecture documentation-first; separate guides, config examples, validation, and optional future helpers. | `docs/architecture/system/architecture.md` |
| ADRs | Record version/package policy, WSL storage/data mount policy, proxy strategy, and Neovim plugin baseline. | `docs/adr/` |
| Plan | Implement five reviewable milestones: entry point, Windows/WSL, Ubuntu baseline, Neovim/tmux, final verification. | `docs/plans/2026-05-24-terminal-first-workstation-setup.md` |
| Test spec | Use static docs checks, config smoke checks, and manual Windows check records where execution is not possible from this workspace. | `specs/terminal-first-workstation-setup.test.md` |

## Diff Rationale By Area

| File or area | Change | Reason | Source artifact | Test/evidence |
| --- | --- | --- | --- | --- |
| `README.md` | Replaced template README with project orientation, guide order, warning labels, scope, troubleshooting, and workflow links. | First-time readers need audience, scope, risk labels, and verification posture before running commands. | R1-R4, R39-R40; M1/M5 | `m1-project-entrypoint`, `m5-release-readiness` |
| `.gitignore`, `CODE_OF_CONDUCT.md`, `CONTRIBUTING.md`, `LICENSE`, `SECURITY.md` | Added or refreshed standard repository hygiene and community files. | The bootstrap change makes the repository public-facing, so it needs baseline ignore rules, contribution expectations, license terms, and security reporting guidance alongside the setup guide. | Project bootstrap scope; README public project posture | Final `git diff --check`; PR readiness inspection |
| `VISION.md`, `docs/vision/strategic-positioning.md` | Added project identity, audience, goals, non-goals, and falsifiability. | Bootstrap proposal required a durable vision before long-term setup docs became source of truth. | Proposal readiness note; Constitution docs rule | M1 static checks and review |
| `CONSTITUTION.md`, `AGENTS.md`, `docs/workflows.md`, `docs/project-map.md` | Added governance, agent rules, workflow artifact map, and repository map. | The project uses RigorLoop-style artifacts and needed stable rules for proposals, specs, changes, reviews, and docs/changes. | Workflow/constitution/project-map stages | Plan-review and later milestone reviews |
| `docs/proposals/`, `specs/`, `docs/architecture/`, `docs/adr/` | Added durable decision records and approved requirement/design artifacts, including certificate trust policy for WSL. | Setup behavior changes package sources, WSL storage, proxy, certificate trust, sudoers, fstab, editor config, and terminal config, so spec/architecture decisions were required before implementation. | Constitution source-of-truth order | Proposal/spec/architecture reviews |
| `docs/changes/2026-05-24-terminal-first-workstation-setup/` | Added active change metadata, plan, review log, review resolution, and this explanation. | A multi-milestone change needed traceable progress, validation, review outcomes, and durable rationale. | Plan skill and workflow guide | Plan-review, code-review M1-M5 |
| `docs/guides/01-windows-host.md` | Documented PowerShell/WinGet install/update, Windows Terminal, WSL availability, PowerShell profile best practices, elevation, and enterprise-policy caveats. | R5-R7 require a supported PowerShell path and host verification without unsafe execution-policy changes. | R1-R7 | `m2-windows-wsl-storage` |
| `docs/guides/02-wsl2-ubuntu.md` | Documented fresh WSL install to `D:\Software\WSL\Ubuntu`, version-gated `--location`, `--web-download` fallback, migration/import-in-place, destructive unregister warnings, and rollback. | R8-R15 require explicit Ubuntu LTS selection, D-drive WSL storage, safe migration, and storage/data separation. | R8-R15; SR-001 resolution | `m2-windows-wsl-storage` |
| `docs/guides/03-ubuntu-baseline.md` | Documented WSL auto proxy, manual proxy fallback, `/etc/wsl.conf`, apt source configuration, fstab data mount, locale checks, optional passwordless sudo, doctor status expectations, validation, and rollback. | R16-R26 require reversible Ubuntu baseline setup with explicit safety gates. | R16-R26 | `m3-ubuntu-baseline` |
| `docs/guides/04-neovim.md`, `config/nvim/` | Added Windows/Ubuntu Neovim guide, Ubuntu release-tarball fallback, and one concise shared `init.lua` config with a small Lazy plugin baseline. | R27-R31 require Neovim on both environments, a single-file shared config, optional language tooling, and health checks; the fallback covers Ubuntu package sources that are too old for the desired stable release. | R27-R31; Neovim ADR | `m4-neovim-tmux`, Neovim headless load |
| `docs/guides/05-tmux.md`, `config/tmux/tmux.conf` | Added Ubuntu-only tmux guide, quick-start commands, and config for prefix, panes, windows, mouse, status, and copy-mode behavior. | R32-R34 scope tmux to Ubuntu and require verifiable daily-use configuration. | R32-R34 | `m4-neovim-tmux`, tmux clean-session load |
| `docs/guides/06-uv.md` | Added optional Windows and Ubuntu `uv` install, update, package-index, verification, and rollback guidance. | R41-R43 allow optional `uv` tooling while keeping Python runtime setup non-mandatory and package-source configuration safe. | R41-R43 | `m1-project-entrypoint` |
| `docs/guides/99-verification.md` | Added consolidated verification matrix, command checks, publication gate, static check list, staged whitespace policy, and rollback coverage. | R35-R38 require consistent doctor states, mostly observational checks, helper write disclosure, and rollback coverage; R14 requires WSL command publication gate. | R14, R35-R38; PR-001 plan review resolution | `m5-release-readiness` |
| `docs/troubleshooting/` | Added enterprise policy, proxy, WSL, and Ubuntu baseline troubleshooting. | Named edge cases need a durable place for blocked package sources, WSL option drift, proxy limits, fstab/sudoers failures, and rollback notes. | EC2-EC11; R20, R38 | M1-M3 static checks |
| `docs/release-notes/2026-05-24-tested-versions.md` | Added latest-stable version record and WSL command-contract evidence checklist. | The guide must record tested versions and not treat unrun Windows checks as passed. | R3-R4, R14; version ADR | `m5-release-readiness` |
| `tests/markdown/*.test.sh` | Added milestone static proof scripts M1-M5. | Documentation-only setup behavior still needs failing-first proof for command contracts, safety warnings, rollback, and verification surfaces. | Test spec T-M1 through T-M5 | All milestone validations |

## Tests Added Or Changed

| Test | What it proves | Level |
| --- | --- | --- |
| `tests/markdown/m1-project-entrypoint.test.sh` | README, guide skeletons, command environments, warning posture, doctor vocabulary, and no one-command installer baseline exist. | static docs |
| `tests/markdown/m2-windows-wsl-storage.test.sh` | Windows host commands, explicit WSL install-location command, migration safety gates, storage/data separation, and WSL troubleshooting are documented. | static docs |
| `tests/markdown/m3-ubuntu-baseline.test.sh` | Proxy, `.wslconfig`, `/etc/wsl.conf`, fstab, `/home/<user>/data`, locale, optional sudoers, rollback, and doctor vocabulary are covered. | static docs |
| `tests/markdown/m4-neovim-tmux.test.sh` | Neovim guide/config layout, plugin/language profile, Ubuntu-only tmux config, verification entries, and no native-Windows-tmux support claims. | static docs plus config fixture checks |
| `tests/markdown/m5-release-readiness.test.sh` | Final verification matrix, publication gate, tested-version record, README final orientation, rollback coverage, and staged whitespace policy. | static docs |

The test level is appropriate because most first-slice behavior is documentation and command-contract guidance. Live Windows/WSL destructive paths are intentionally manual or release-captured, not automated from this Linux workspace.

## Validation Evidence Before Final Verify

The following validation evidence exists in `docs/plans/2026-05-24-terminal-first-workstation-setup.md` and review records:

```bash
bash tests/markdown/m1-project-entrypoint.test.sh
bash tests/markdown/m2-windows-wsl-storage.test.sh
bash tests/markdown/m3-ubuntu-baseline.test.sh
bash tests/markdown/m4-neovim-tmux.test.sh
bash tests/markdown/m5-release-readiness.test.sh
nvim --headless --cmd 'set runtimepath^=config/nvim' -u config/nvim/init.lua +qa
tmux -f config/tmux/tmux.conf new-session -d -s terminal-first-check && tmux kill-session -t terminal-first-check
```

Path-scoped whitespace checks passed for each milestone. M5 also passed the temporary-index staged gate:

```bash
git diff --cached --name-only
git diff --cached --check
```

CI status: no CI workflow was added and no hosted CI run is claimed.

Manual checks: Windows 11, WSL fresh install-location, WSL migration/import-in-place, Windows Terminal, and Windows Neovim checks remain unrun from this Linux workspace. The release note records those as `unrun` or manual evidence required.

## Review Summary

Code reviews for M1 through M5 completed with `clean-with-notes` and no material findings. Review records are in `docs/changes/2026-05-24-terminal-first-workstation-setup/review-log.md`.

Material review findings before implementation:

- Plan review PR-001 found that repository-wide `git diff --check` was not executable because of unrelated baseline drift. It was resolved by staged milestone-scoped whitespace validation in `docs/changes/2026-05-24-terminal-first-workstation-setup/review-resolution.md`.

No code-review `review-resolution.md` was required for M1-M5 because no material code-review findings were recorded.

## Alternatives Rejected

| Alternative | Why rejected |
| --- | --- |
| One-command unattended installer | Too risky for WSL storage, sudoers, fstab, proxy, package sources, and Windows policy in a new public guide. |
| Manual guide with no checks | Easier to write but too easy for users and contributors to miss command-contract drift or safety warnings. |
| Dotfiles-first repo | Would not solve Windows host, WSL storage, proxy, mount, locale, and verification requirements. |
| Moving all project code under `D:\Data` | Mounted Windows paths can be slower or semantically different for Linux-heavy tooling; `~/src` remains preferred. |
| Silent passwordless sudo | Weakens local security and violates the opt-in reversible profile requirement. |
| Native Windows tmux support | Out of first-slice scope; tmux is scoped to Ubuntu. |
| Full PAC/corporate CA support | Deferred to troubleshooting because enterprise proxy/certificate behavior is environment-specific and higher risk. |
| Adding CI in M5 | Premature until the repository has stable script and lint tooling; local static checks are enough for this slice. |

## Scope Control

Preserved non-goals:

- no support for Windows versions older than Windows 11;
- no arbitrary WSL storage roots beyond `D:\Software\WSL\Ubuntu`;
- no full runtime setup for Node.js, Python, Go, Rust, Java, Docker, databases, cloud, Kubernetes, or AI tooling;
- no native Windows tmux support;
- no full corporate PAC/custom CA implementation;
- no broad dotfiles framework;
- no one-command unattended installer.

No state-changing helper scripts were added. The guides document target paths, backup behavior, rollback behavior, and scope instead.

## Risks And Follow-Ups

Remaining risks:

- Manual Windows checks are not yet executed. They must be recorded before publication as tested.
- WSL `--location` behavior depends on installed WSL version. Publication still requires local or release-captured `wsl --help`.
- Existing repository-wide whitespace drift remains outside this feature. Staged/path-scoped validation protects new milestone changes.
- Neovim plugin behavior can drift. Keep the config concise and add lockfile policy only if the setup becomes more automated.
- Proxy/PAC/corporate CA behavior remains troubleshooting-only.

Recommended next stage: `verify`.

This explanation does not claim final verification, branch readiness, PR readiness, hosted CI success, or release readiness.
