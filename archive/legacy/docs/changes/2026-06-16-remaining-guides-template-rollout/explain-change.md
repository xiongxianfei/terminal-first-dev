# Explain Change: Remaining Guides Template Rollout

## Summary

This change applies the approved how-to guide template to the remaining first-slice guide set in risk-tiered milestones. It keeps the repository documentation-first, preserves setup command semantics, and records compatibility boundaries before any later filename migration.

The implementation converts smaller tool guides, the Windows host guide, WSL install and migration guidance, and the verification guide into the accepted visible metadata, `Fast path`, `Walkthrough`, expected-result, backup, rollback, and troubleshooting-link shape. It also adds static Markdown checks and lifecycle evidence for review, final verification, and PR handoff.

## Problem

The accepted guide-structure and guide-template work left several first-slice guides in the older `Purpose`, `Command environment`, `Safety notes`, `Validation`, and `Rollback` shape. Those guides already had useful content, but readers did not consistently get quick fast paths, explicit execution context, visible backup-before-edit guidance, or reviewable compatibility boundaries.

The change needed to continue the template rollout without changing PowerShell, WSL, Ubuntu, Neovim, tmux, uv, or verification command semantics.

## Decision trail

| Source | Decision or requirement | Result in this change |
| --- | --- | --- |
| Proposal | Use a risk-tiered rollout with compatibility paths. | Implemented five reviewed milestones instead of one broad rewrite. |
| Proposal | Treat WSL splitting as a safety exception, not broad filename migration. | Split only `02-wsl2-ubuntu.md` into install and migration guides; kept other numbered paths. |
| Spec R1-R4 | Preserve setup command semantics and apply the accepted template contract. | Guide bodies were reorganized while command behavior remained governed by existing setup specs. |
| Spec R19-R21 | Put backup guidance before file edits or hard-to-undo changes and include rollback. | Converted guides include backup/export and rollback coverage near state-changing steps. |
| Spec R27-R39 | Convert tmux, Neovim, and uv first; keep uv optional and credential-free. | M1 converted `05-tmux.md`, `04-neovim.md`, and `06-uv.md`. |
| Spec R40-R43 | Keep Windows host setup unified and policy-aware. | M2 converted `01-windows-host.md` without splitting Windows Terminal and PowerShell. |
| Spec R44-R57 | Split WSL install and migration, keep the old numbered path as a command-free stub. | M3 added `wsl-ubuntu-install.md`, `wsl-ubuntu-migration.md`, and a route-only `02-wsl2-ubuntu.md`. |
| Spec R58-R60 | Convert verification only when active referenced paths exist or unresolved targets are inventoried. | M4 added the verification target inventory and converted `99-verification.md`. |
| Spec R61-R75 | Preserve the router, defer broad filename migration, and record completion evidence. | Router and lifecycle artifacts now reflect converted paths, compatibility paths, validation, and non-claims. |
| Plan M1-M5 | Implement in reviewed slices with validation after each milestone. | M1-M5 are closed after clean code reviews with no material findings. |

Architecture and ADR decisions: not applicable. The approved spec and plan keep this change to Markdown guide structure, router updates, compatibility stubs, static checks, and review evidence.

## Diff rationale by area

| Area | Files | Change | Reason | Source artifact | Test/evidence |
| --- | --- | --- | --- | --- | --- |
| Change governance | `docs/proposals/2026-06-16-remaining-guides-template-rollout.md`, proposal review, spec, spec review, spec review resolution, test spec, plan, review log, review records, `change.yaml`, `docs/plan.md` | Added the durable workflow artifacts for the rollout. | The change is multi-guide, migration-sensitive, and governed by the repository workflow. | Constitution, proposal, spec, plan | Plan review approved; M1-M5 code reviews recorded clean-with-notes. |
| Smaller tool guides | `docs/guides/05-tmux.md`, `docs/guides/04-neovim.md`, `docs/guides/06-uv.md` | Converted to visible metadata, fast path, walkthrough, expected results, rollback, and troubleshooting-router shape. | M1 needed to exercise the template on lower-risk tool guides while preserving numbered paths. | R27-R39 | `T-RGT-001` through `T-RGT-004`, `T-RGT-011`, M1 evidence and review. |
| Windows host guide | `docs/guides/01-windows-host.md` | Converted as one unified host-baseline guide with policy and elevation notes near relevant commands. | The spec explicitly rejected splitting Windows Terminal and PowerShell during body conformance. | R40-R43 | `T-RGT-005`, M2 evidence and review. |
| WSL install and migration | `docs/guides/wsl-ubuntu-install.md`, `docs/guides/wsl-ubuntu-migration.md`, `docs/guides/02-wsl2-ubuntu.md` | Split fresh install and migration into task guides; kept `02-wsl2-ubuntu.md` as a command-free compatibility stub. | Fresh install and migration have different starting states, destructive risks, and recovery needs. | R44-R57 | `T-RGT-006`, M3 high-risk review evidence and review. |
| Verification proof surface | `docs/guides/99-verification.md`, `docs/changes/2026-06-16-remaining-guides-template-rollout/verification-target-inventory.md` | Converted the verification guide and recorded active references plus unresolved follow-ups. | Verification conversion needed observable sequencing and valid active links. | R58-R60, R75 | `T-RGT-007`, M4 inventory and review. |
| Router | `docs/guides/README.md` | Updated routing while numbered and task-scoped paths coexist. | Readers need current paths without removing compatibility paths. | R61-R63 | `T-RGT-008`, link checks. |
| Static checks | `tests/markdown/remaining-guides-template-rollout.test.sh` and adjusted existing Markdown checks | Added scoped rollout checks and updated older checks to accept converted guide wording. | The validation model is static and review-based, with no guide command execution. | R67-R75 | Rollout proof script and regression checks. |

Converted guides:

- `docs/guides/05-tmux.md`
- `docs/guides/04-neovim.md`
- `docs/guides/06-uv.md`
- `docs/guides/01-windows-host.md`
- `docs/guides/wsl-ubuntu-install.md`
- `docs/guides/wsl-ubuntu-migration.md`
- `docs/guides/99-verification.md`

Compatibility paths:

- `docs/guides/02-wsl2-ubuntu.md` remains as a command-free compatibility path that routes by starting state to the WSL install or migration guide.
- `docs/guides/03-ubuntu-baseline.md` remains an existing unconverted guide and is recorded as an unresolved verification follow-up.
- Numbered paths outside the WSL safety split remain in place during body conformance.

## Tests added or changed

| Test ID | Location | What it proves | Why this level is appropriate |
| --- | --- | --- | --- |
| `T-RGT-001` | `tests/markdown/remaining-guides-template-rollout.test.sh` | Converted guides have visible metadata, fast path before walkthrough, command context, expected results, fences, and no placeholders. | Static structure checks match the documentation-only scope. |
| `T-RGT-002` | Same | Backup, safety, rollback, and hard-to-undo state-change coverage are visible. | Static checks can catch required text placement; reviews cover judgment-heavy adequacy. |
| `T-RGT-003` | Same | Troubleshooting links and anchors resolve for converted guides. | Link checks are the right proof for failure-point routing. |
| `T-RGT-004` | Same | M1 tool guides are converted, uv remains optional, and package-source examples stay credential-free. | Guide-specific static checks preserve the approved scope. |
| `T-RGT-005` | Same | Windows host remains unified and policy-aware. | Static text checks cover the no-split and policy/elevation requirements. |
| `T-RGT-006` | Same | WSL install/migration split exists and the old numbered file is a command-free stub. | Static checks can verify paths, routing, and command-duplication boundaries. |
| `T-RGT-007` | Same | Verification conversion is sequenced by existing active paths and target inventory. | Static reference checks make R58 observable. |
| `T-RGT-008` | Same | Router behavior stays useful while old and new paths coexist. | Router links are documentation structure, not runtime behavior. |
| `T-RGT-009` | Same | Broad final filename migration remains deferred. | Static path checks protect compatibility scope. |
| `T-RGT-010` | Review evidence | Parity, command semantics, backup adequacy, WSL risk, and uv package-source review are recorded. | Manual review is required where text structure alone cannot prove semantics. |
| `T-RGT-011` | Same | Secrets, private hostnames, tokens, and credential-like examples are rejected. | Contract checks protect security/privacy without executing commands. |
| `T-RGT-012` | Same | The proof script does not become command-execution CI. | The rollout explicitly forbids workstation setup command execution. |
| `T-RGT-013` | Same | Completion evidence and non-claims are present for final closeout. | Lifecycle evidence is a documentation artifact and can be checked statically. |

Existing Markdown tests were updated only where older wording assumptions conflicted with the accepted guide shape. Their underlying contracts remain in place.

## Validation evidence available before final verify

Checks run:

- `bash tests/markdown/remaining-guides-template-rollout.test.sh`
- `bash tests/markdown/how-to-guide-template-best-practices.test.sh`
- `bash tests/markdown/guides-two-speed-how-to-structure.test.sh`
- `bash tests/markdown/m1-project-entrypoint.test.sh`
- `bash tests/markdown/m2-windows-wsl-storage.test.sh`
- `bash tests/markdown/m3-ubuntu-baseline.test.sh`
- `bash tests/markdown/m4-neovim-tmux.test.sh`
- `bash tests/markdown/m5-release-readiness.test.sh`
- `git diff --check`
- M5 code-review rerun: the same Markdown validation set plus `git diff --check HEAD^ HEAD`

Checks intentionally not run:

- Command execution: not executed.
- Hosted CI: not observed.

This rollout intentionally does not execute PowerShell, WSL, Ubuntu setup, package-manager, mount, sudoers, Neovim, tmux, uv, proxy, or workstation verification command blocks from the guides. The approved validation model for this change is static and review-based.

## Review resolution summary

No material implementation review findings were recorded for M1, M2, M3, M4, or M5, so no implementation `review-resolution.md` was required.

Review state:

- M1-M5 code reviews: clean-with-notes.
- Material findings: none.
- Required review-resolution: no.
- Verification report: docs/changes/2026-06-16-remaining-guides-template-rollout/verify-report.md.
- Branch readiness: owned by verify.
- PR readiness: not claimed.
- Hosted CI: not claimed.

## Alternatives rejected

- One broad rewrite of every remaining guide was rejected because command-contract drift and WSL migration safety issues would be harder to review.
- Simplest-guides-only conversion was rejected because it would delay high-risk WSL and verification cleanup too long.
- Highest-risk WSL-first conversion was rejected because it would front-load the hardest split before lower-risk template rollout evidence existed.
- Rename-first migration was rejected because body conformance and filename compatibility are separate risks.
- Generated docs tooling, scaffolders, installers, and command-execution CI were rejected as out of scope for this documentation-first rollout.

## Scope control

The change preserves these non-goals:

- No changed setup command contracts.
- No guide command-block execution in CI.
- No generated documentation site or custom docs tooling.
- No one-command installer or hidden automation.
- No removal of numbered paths without compatibility routing.
- No broad final filename migration beyond the WSL safety split.
- No deep troubleshooting content moved into guide pages.
- No tutorial expansion of the how-to guides.
- No changes to unrelated README, vision, constitution, or release policy content.

## Risks and follow-ups

- PR readiness is still pending and must not be claimed until the PR stage prepares the handoff.
- Hosted CI has not been observed.
- Broad final filename migration remains deferred to a later compatibility slice.
- `03-ubuntu-baseline.md`, WSL config, data mount, locale, and sudo verification targets remain unresolved verification follow-ups rather than active converted-guide links.

## Readiness

M1-M5 are closed after code-review, and this explanation records why the branch changed and what evidence exists for final verification.

Final verification is recorded separately in `verify-report.md`.
