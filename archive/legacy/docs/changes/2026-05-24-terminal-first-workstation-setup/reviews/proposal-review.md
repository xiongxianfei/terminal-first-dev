---
id: 2026-05-24-proposal-review-terminal-first-windows-dev
proposal: docs/proposals/2026-05-24-bootstrap-terminal-first-windows-dev.md
review_status: approved
created: 2026-05-24
repo: xiongxianfei/terminal-first-windows-dev
---

# Proposal Review: Bootstrap Terminal-First Windows Dev Workstation

## Review Status

approved

Latest review round: 2026-05-24 second pass.

The proposal is approved for spec authoring. The prior material finding is resolved, and the later WSL storage revision is adequately represented in scope, architecture impact, verification, rollout/rollback, risks, decision log, intent preservation, and next artifacts.

Before downstream specs rely on the proposal, the owner should normalize the proposal artifact status from `draft` to `accepted`. This is a lifecycle bookkeeping step, not a material proposal defect.

## Review Log

| Round | Date | Status | Findings | Notes |
| --- | --- | --- | --- | --- |
| 1 | 2026-05-24 | changes-requested | PR-001 | Resolved owner decisions were still listed as open questions. |
| 2 | 2026-05-24 | approved | none | Prior finding resolved; proposal ready for spec after owner acceptance/status normalization. |

## Prior Finding Resolution

| Finding ID | Disposition | Evidence |
| --- | --- | --- |
| PR-001 | accepted and resolved | Proposal now records no blocking open questions, appends resolved decisions to Decision Log, and updates Readiness to ready for spec after proposal decisions are recorded. |

## Second-Pass Review Dimensions

| Dimension | Result | Notes |
| --- | --- | --- |
| Problem clarity | pass | The proposal frames the risk of an unstructured workstation checklist and the need for a clear public guide. |
| User value | pass | User value is concrete across Windows host, WSL Ubuntu, Neovim, tmux, and validation workflows. |
| Option diversity | pass | Manual guide, one-command installer, dotfiles-first, and documentation-first helper approaches are compared. |
| Decision rationale | pass | The selected direction follows the safety, auditability, and repeatability tradeoff. |
| Scope control | pass | Non-goals and scope budget protect against language runtimes, broad corporate proxy support, full dotfiles, and broad relocation paths. |
| Architecture awareness | pass | Docs, scripts, config, doctor checks, WSL storage, WSL config, fstab, and rollback boundaries are visible. |
| Testability | pass | Verification expectations are layered and concrete enough for spec authoring. |
| Risk honesty | pass | Data-loss risk from WSL relocation, storage-path failure, sudo, proxy, mounted-drive performance, and automation risks are named. |
| Rollout realism | pass | Rollout starts with docs and helper scripts; rollback calls out WSL backup/re-import and config rollback. |
| Readiness for spec | pass | No blocking open questions remain; implementation planning is correctly deferred until spec and safety gates exist. |

## Scope Preservation Review

Scope-preservation result: pass.

The proposal visibly classifies the initial goals, including PowerShell, WSL2/Ubuntu, D-drive WSL storage, `D:\Data` exposure, passwordless sudo, proxy handling, locale, Neovim, linting, tmux, and best-practice validation.

## Recommended Proposal Edits

- Normalize proposal front matter and `## Status` from `draft` to `accepted` once the owner accepts this approved review result.
- In spec, validate the exact WSL command syntax for the target WSL version, including whether `wsl --install Ubuntu --location ...` or `wsl --install --distribution Ubuntu --location ...` is preferred for the documented distro name.

## Recommendation

Recommendation: approved for spec authoring after owner acceptance/status normalization.

Immediate next stage: isolated stop. No automatic handoff to `spec` occurs from this review-only invocation.

## Original Review Status

changes-requested

The proposal direction is sound. The required change is to revise the proposal so the now-resolved open questions are recorded as decisions, update the Decision Log, and update Readiness from "not ready for implementation planning" to "ready for spec after proposal decisions are recorded".

## Material Findings

### PR-001 - Resolved owner decisions are not yet recorded in the proposal

Severity: medium

Location: Open Questions, Decision Log, Readiness

Evidence: The proposal still lists distro, version policy, data mount path, project-code location, locale, proxy mode, sudo posture, Neovim language baseline, shared Neovim config, and Windows Terminal as open questions. The owner has now provided decisions for most of these.

Required outcome: Replace blocking open questions with explicit decisions, append Decision Log rows, and update Readiness.

Safe resolution path: Keep the proposal architecture and scope. Do not redesign it. Apply the decision table below and keep PAC/corporate CA handling as a deferred troubleshooting follow-up.

## Resolved Open Questions

| Question | Decision |
| --- | --- |
| Ubuntu distro | Use an explicit current Ubuntu LTS distro name, not mutable `Ubuntu`. Current target: latest Ubuntu LTS available through `wsl --list --online`; as of 2026-05-24 this is Ubuntu 26.04 LTS if listed, with Ubuntu 24.04 LTS as compatibility fallback. |
| Meaning of "newest" | Latest stable at setup time, not preview/nightly. Record tested versions in release notes. Pin only where reproducibility matters, such as Neovim plugin lockfiles. |
| `D:\Data` Linux path | Use `/home/<user>/data` as the documented path. Keep it lowercase and home-relative. |
| Project-code location | Store Linux-heavy project code in the WSL filesystem by default, for example `~/src`. Treat `~/data` as shared Windows/Linux data unless the user accepts performance tradeoffs. |
| Locale | Use `C.UTF-8` as the healthy default. Validate that locale output is UTF-8 and warning-free. Keep user-selected UTF-8 locales supported. |
| Proxy mode | Use WSL automatic proxy mirroring as primary via `%UserProfile%\.wslconfig` `[wsl2] autoProxy=true`. Document manual env-var fallback. |
| PAC files and corporate CA certificates | Defer from first implementation slice. Add troubleshooting notes and known limitations only. |
| Passwordless sudo | Include as an explicit personal-workstation convenience profile, not silent automation. Use a project-owned sudoers drop-in, validate with `visudo`, and make rollback clear. |
| Initial Neovim profile | Keep the config concise. Include editing, navigation, diagnostics, Git indicators, and LSP wiring. Treat additional language servers, formatters, and linters as optional and user-installed. |
| Neovim config strategy | Use one single-file shared config at `config/nvim/init.lua`. Deploy or sync it separately to Windows and WSL config paths; do not rely on plugin/runtime state shared through a Windows-mounted path. |
| Windows Terminal | Assume Windows Terminal as the primary terminal emulator. Keep PowerShell and Ubuntu profiles documented. |

## Recommended WSL Configuration Posture

`%UserProfile%\.wslconfig`:

```ini
[wsl2]
autoProxy=true
```

`/etc/wsl.conf`:

```ini
[automount]
enabled=false
mountFsTab=true

[interop]
enabled=true
appendWindowsPath=false
```

`/etc/fstab` target policy:

```fstab
# Preferred target: expose D:\Data at /home/<user>/data through DrvFs.
# Validate the final syntax with: sudo mount -a
D:/Data /home/<user>/data drvfs metadata,uid=1000,gid=1000,umask=022,fmask=011,case=off 0 0
```

If direct subdirectory mounting is unreliable on a user's WSL version, fall back to mounting `D:` through fstab and creating a documented symlink from `/home/<user>/data` to the `Data` directory.

## Readiness

Ready for spec after the proposal is updated with these decisions.

Not ready for implementation planning until the spec records requirements, validation checks, rollback requirements, and safety gates for sudoers, WSL configuration, proxy behavior, and data mounting.
