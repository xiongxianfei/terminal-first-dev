# Explain Change: Two-Speed How-To Guide Structure

## Summary

This change turns `docs/guides/` into a reader-intent how-to area without converting every guide at once. It adds a guide router, a reusable contributor template, a two-speed proxy pilot guide, pilot benefit evidence, and a lightweight static validation script.

The implementation preserves the documentation-first project posture. It does not add setup automation, command-execution CI, static-site generation, or new setup command semantics.

## Problem

The project needed a guide structure that lets readers configure a terminal-first Windows development workstation quickly while keeping deeper troubleshooting and design rationale out of the happy path. Existing setup content was numbered and useful, but the accepted direction called for task-scoped guides, inline troubleshooting links, and a reusable two-speed template.

## Decision Trail

| Stage | Decision or evidence |
| --- | --- |
| Proposal | `docs/proposals/2026-06-07-guides-two-speed-how-to-structure.md` accepted the two-speed guide structure, reader-intent router, separate troubleshooting area, unnumbered task guide filenames, and proxy pilot. |
| Proposal review | `docs/changes/2026-06-07-guides-two-speed-how-to-structure/reviews/proposal-review.md` recorded no material findings after revision. |
| Spec | `specs/guides-two-speed-how-to-structure.md` defined R1-R42 and AC1-AC12 for router, template, proxy pilot, troubleshooting boundary, and validation boundaries. |
| Spec review | `docs/changes/2026-06-07-guides-two-speed-how-to-structure/reviews/spec-review.md` approved the spec. |
| Test spec | `specs/guides-two-speed-how-to-structure.test.md` mapped requirements to T1-T9, including static structure checks and manual pilot evidence. |
| Plan | `docs/plans/2026-06-07-guides-two-speed-how-to-structure.md` split implementation into M1 router/template, M2 proxy pilot, and M3 lightweight validation. |
| Reviews | M1, M2, and M3 code reviews recorded `clean-with-notes` with no material findings under `docs/changes/2026-06-07-guides-two-speed-how-to-structure/reviews/`. |

Architecture was marked not required because this change affects documentation structure and validation expectations only.

## Diff Rationale By Area

| File | Change | Reason | Source artifact | Test or evidence |
| --- | --- | --- | --- | --- |
| `docs/guides/README.md` | Added a reader-intent router and later routed proxy readers to the pilot guide. | Satisfies R1-R8 and AC3 while preserving discoverability for existing numbered guides. | Spec R1-R8, R41-R42; plan M1/M2. | M1 validation and `tests/markdown/guides-two-speed-how-to-structure.test.sh`. |
| `docs/templates/how-to-guide.md` | Added contributor-facing guide template outside `docs/guides/`. | Satisfies R9-R11 and keeps meta content out of reader-facing guides. | Spec R9-R11; owner decision on template location. | M1 validation and M3 proof script. |
| `docs/guides/proxy-setup.md` | Added the first task-scoped two-speed pilot guide. | Satisfies R12-R30, R40, AC4-AC6, and AC12 using proxy setup as the representative hard case. | Spec R12-R30, R40; plan M2. | M2 validation, M2 code review, M3 proof script. |
| `docs/changes/2026-06-07-guides-two-speed-how-to-structure/pilot-review.md` | Recorded manual fast-path walkthrough evidence and command-execution limits. | Satisfies R31-R32 and AC7 without claiming live Windows/WSL/proxy execution. | Spec R31-R32; test spec T4. | M2 validation and M2 code review. |
| `tests/markdown/guides-two-speed-how-to-structure.test.sh` | Added static Markdown proof script. | Satisfies R33-R36 and AC8-AC10 by checking guide shape, links, anchors, migration discoverability, pilot evidence, and no-command-execution guardrails. | Spec R33-R36; test spec T5-T8; plan M3. | M3 validation and M3 code review. |
| `tests/markdown/m1-project-entrypoint.test.sh` | Scoped legacy setup-guide section checks to numbered setup guides. | Final verification found that the previous `docs/guides/*.md` glob incorrectly treated the new router and task guide as old numbered setup guides. | Existing workstation setup validation plus this change's new guide taxonomy. | Full Markdown test suite passed after the fix. |
| `docs/plans/2026-06-07-guides-two-speed-how-to-structure.md` | Recorded milestone progress, validation, review closeout, and final-closeout readiness. | Keeps the living plan aligned with implementation and review state. | Workflow and plan requirements. | Code review records and validation notes. |
| `docs/changes/2026-06-07-guides-two-speed-how-to-structure/change.yaml` | Updated compact lifecycle stage as milestones advanced. | Keeps change metadata aligned with plan state. | Workflow metadata expectations. | Plan/index consistency checks. |
| `docs/plan.md` | Updated active plan index through milestone handoffs and final closeout readiness. | Keeps project-level lifecycle routing current. | Workflow guidance. | Plan/index consistency checks. |
| `docs/changes/2026-06-07-guides-two-speed-how-to-structure/review-log.md` and `reviews/*.md` | Recorded proposal/spec/plan/code-review outcomes. | Preserves formal review evidence and confirms no material code-review findings remain. | Review skills and workflow recording rules. | Review records M1-M3. |

## Tests Added Or Changed

| Test or proof | What it proves | Why this level is appropriate |
| --- | --- | --- |
| `tests/markdown/guides-two-speed-how-to-structure.test.sh` | Router, template, proxy pilot, troubleshooting anchors, pilot evidence, migration discoverability, and validation guardrails exist. | The approved slice is Markdown documentation structure. Static checks are enough for shape and link/anchor contracts. |
| `pilot-review.md` manual walkthrough record | The proxy fast path can be evaluated from documented prerequisites and records command-execution limits. | The benefit claim is reader workflow quality, not executable behavior in CI. |
| Milestone validation commands in `plan.md` | Each implementation slice had targeted proof before review. | The plan intentionally avoids broad command-execution CI for setup commands. |

## Validation Evidence Before Final Verify

- M1 implementation and review ran file, heading, router discoverability, template placement, whitespace, and ASCII checks.
- M2 implementation and review ran proxy-guide structure, troubleshooting-link, anchor, pilot-evidence, numbered-step, whitespace, and ASCII checks.
- M3 implementation and review ran `bash tests/markdown/guides-two-speed-how-to-structure.test.sh`, `git diff --check`, `git diff --cached --check`, `git diff HEAD^..HEAD --check`, and `git show --check --format=short HEAD`.
- Final closeout ran the full `tests/markdown/*.test.sh` suite. It initially exposed that `tests/markdown/m1-project-entrypoint.test.sh` still treated every file under `docs/guides/` as a numbered setup guide; the glob was narrowed to `docs/guides/[0-9][0-9]-*.md`, and the full suite then passed.
- No hosted CI result has been observed or claimed.

## Review Resolution Summary

No material code-review findings were recorded for M1, M2, or M3, so no implementation review-resolution loop was required.

Earlier plan-review finding PR-001 was resolved before implementation by keeping `specs/guides-two-speed-how-to-structure.test.md` upstream of implementation and assigning M3 ownership to `tests/markdown/guides-two-speed-how-to-structure.test.sh`.

## Alternatives Rejected

- A one-large-guide migration was rejected because it would make targeted task completion harder.
- A generated or interactive documentation system was rejected as premature for a documentation-first project.
- Command-execution CI for setup command blocks was deferred because the command surface and Windows + WSL runner environment are not stable enough for reliable enforcement.
- Putting the how-to template under `docs/guides/` was rejected because `docs/guides/` should remain reader-facing.

## Scope Control

This change does not:

- convert every setup guide;
- redefine PowerShell, WSL, Neovim, tmux, proxy, sudoers, fstab, mount, or package-source command contracts;
- add a one-command installer or hidden setup automation;
- add static-site generation or a docs wizard;
- execute setup command blocks in CI;
- solve every PAC, VPN, proxy, or certificate environment.

## Risks And Follow-Ups

- The proof script is intentionally static and grep-based. It should stay focused on stable guide shape and links, not command correctness.
- Real Windows/WSL/proxy behavior still depends on local WSL version, VPN, enterprise policy, PAC, and certificate trust settings.
- Future guide conversions should reuse `docs/templates/how-to-guide.md` and add targeted troubleshooting anchors before broad migration.
- If command specs and a Windows + WSL runner later stabilize, command-execution validation can be proposed as a separate change.

## Current State

All in-scope implementation milestones are closed after clean code reviews. The current workflow stage is final closeout: final verification and PR handoff remain.
