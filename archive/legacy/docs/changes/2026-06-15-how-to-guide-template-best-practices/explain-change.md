# Explain Change: How-To Guide Template Best Practices

## Summary

This change turns the accepted two-speed guide direction into a concrete, reusable how-to guide authoring contract for `docs/guides/`. It updates the Markdown template, validates the proxy guide as a reference exemplar, converts `03-ubuntu-baseline.md` as the independent portability pilot, and adds static validation for guide structure, troubleshooting links, backup cues, guardrails, and proposal acceptance status.

All implementation milestones M1-M4 are closed after code review with no material findings. Final verification and PR handoff have not run.

## Problem

The repository already accepted two-speed how-to guides, but contributors still needed a copyable and reviewable template that prevents common drift: missing shell context, unclear expected results, fast paths that become too long, walkthroughs that become tutorials, missing backup or rollback guidance before machine-changing edits, and troubleshooting links placed only at the end.

This is safety-sensitive for this project because guides may touch WSL configuration, Ubuntu system files, sudoers behavior, mounts, shell profiles, editor runtime state, proxy behavior, and tmux configuration.

## Decision Trail

| Stage | Decision or evidence |
| --- | --- |
| Proposal | `docs/proposals/2026-06-15-how-to-guide-template-best-practices.md` selected a small required core plus conditional safety modules. |
| Proposal review | `docs/changes/2026-06-15-how-to-guide-template-best-practices/reviews/proposal-review.md` approved the proposal after reframing `proxy-setup.md` as the reference exemplar and `03-ubuntu-baseline.md` as the non-circular portability pilot. |
| Spec | `specs/how-to-guide-template-best-practices.md` defined R1-R54 and AC1-AC14 for the template, published guides, backup guidance, validation boundaries, compatibility, and non-goals. |
| Spec review | `docs/changes/2026-06-15-how-to-guide-template-best-practices/reviews/spec-review.md` approved the spec after `docs/changes/2026-06-15-how-to-guide-template-best-practices/reviews/spec-review-resolution.md` addressed HGT-SR-001 by making backup guidance testable for file-editing guides. |
| Architecture | Architecture was not required because this is Markdown documentation structure and static validation, not generated assets, setup automation, data flow, or machine-changing runtime behavior. |
| Test spec | `specs/how-to-guide-template-best-practices.test.md` maps coverage to T1-T9, including template structure, guide conformance, backup-before-edit checks, troubleshooting links and anchors, validation boundaries, and AC1-AC14 proof. |
| Plan | `docs/plans/2026-06-15-how-to-guide-template-best-practices.md` split implementation into M1 template, M2 exemplar/pilot, M3 validation, and M4 lifecycle evidence. |
| Code review | `review-log.md` records clean M1-M4 code reviews with no material findings. |

## Diff Rationale By Area

| File | Change | Reason | Source artifact | Test/evidence |
| --- | --- | --- | --- | --- |
| `docs/templates/how-to-guide.md` | Replaced the prior minimal template with a copyable two-speed template containing visible metadata, fast path, walkthrough, rollback, troubleshooting, explicit command context, expected results, conditional `Scope` and `Safety`, backup-before-edit guidance, and command-block conventions. | Gives contributors the concrete authoring contract required by the accepted proposal. | Spec R1-R29, R52-R53; plan M1; test spec T1-T2. | M1 proof script checks and code-review M1 R1. |
| `docs/guides/proxy-setup.md` | Added a fast-path backup cue before editing `%UserProfile%\.wslconfig`. | Satisfies the HGT-SR-001 backup-before-edit rule for the reference exemplar. | Spec R35a, AC9; spec review resolution HGT-SR-001; plan M2. | Proof script checks proxy backup text; exemplar review evidence. |
| `docs/guides/03-ubuntu-baseline.md` | Converted the guide to the two-speed shape while preserving existing command semantics for proxy mirroring, `/etc/wsl.conf`, APT posture, shared data mount, locale readiness, optional sudo, doctor expectations, rollback, and troubleshooting. | Validates template portability on a guide that was not the template source. | Spec R30-R45, R52-R54; plan M2; test spec T3-T6. | Static guide checks and `portability-pilot-review.md`; code-review M2 R1. |
| `docs/guides/03-ubuntu-baseline.md` | Restored semantic cues expected by the older Ubuntu-baseline smoke test, including `http_proxy`, `https_proxy`, lowercase `corporate CA`, `APT source configuration`, and `create, skip, or choose`. | Final verification found that the two-speed rewrite had preserved behavior but dropped exact wording used by the broad semantic smoke test. | Spec R52; existing `m3-ubuntu-baseline.test.sh`. | Full Markdown/static suite initially failed, then passed after restoring the cues. |
| `docs/changes/2026-06-15-how-to-guide-template-best-practices/exemplar-review.md` | Added dry-run review evidence for `proxy-setup.md` as the reference exemplar. | Avoids circular validation by labeling proxy as exemplar, not the only pilot. | Spec R40; AC7; test spec T6. | Proof script evidence-record checks. |
| `docs/changes/2026-06-15-how-to-guide-template-best-practices/portability-pilot-review.md` | Added dry-run evidence for the Ubuntu baseline portability pilot, including reviewer separation, prerequisites, fast-path result, verification signal, walkthrough use, defects, and backup coverage. | Proves the template works beyond the source guide and records fast-path-only validation conditions. | Spec R41-R45; AC8-AC9; test spec T6. | Proof script evidence-record checks. |
| `tests/markdown/how-to-guide-template-best-practices.test.sh` | Added and expanded a Bash static proof script for template structure, guide metadata, section order, backup cues, review evidence, troubleshooting link and anchor resolution, first-slice guardrails, security-sensitive examples, pilot path compatibility, and accepted proposal status. | Provides repeatable proof without executing guide command blocks or requiring a Windows + WSL runner. | Spec R46-R54; AC10-AC14; test spec T1-T9; plan M1-M4. | M1-M4 validation runs and code reviews. |
| `tests/markdown/m1-project-entrypoint.test.sh` | Updated the broad entrypoint smoke check so `03-ubuntu-baseline.md` is checked for the accepted two-speed sections instead of the old numbered-guide section set. | Final verification found the broad smoke still assumed every numbered guide used the original setup-guide headings, while this change intentionally makes `03-ubuntu-baseline.md` the two-speed portability pilot. | Spec R41, R54; test spec T7-T9; plan M2/M4. | Full Markdown/static suite initially failed, then passed after this verification-stage drift fix. |
| `docs/proposals/2026-06-15-how-to-guide-template-best-practices.md` | Recorded the accepted proposal with the non-circular exemplar/pilot framing and an explicit exemplar-only option rejection. | Preserves the product and process decision that downstream spec and implementation rely on. | Proposal-review findings and AC14. | M4 proof checks `status: accepted` and rendered `accepted` status. |
| `specs/how-to-guide-template-best-practices.md` | Added the normative template, guide conformance, backup, validation, compatibility, and non-goal contract. | Makes the proposal reviewable and testable before implementation. | Proposal and spec-review resolution. | Spec review approved; test spec maps requirements to tests. |
| `specs/how-to-guide-template-best-practices.test.md` | Added traceable T1-T9 test requirements. | Defines how implementation proves template, guide, validation, security, non-goal, and acceptance-criteria coverage. | Spec R1-R54 and AC1-AC14. | Implemented by the proof script and evidence records. |
| `docs/plans/2026-06-15-how-to-guide-template-best-practices.md` | Added and maintained the milestone plan, validation notes, progress, risks, and current handoff summary. | Keeps implementation order and lifecycle state auditable. | Plan-review R1 and implement/code-review skill requirements. | M1-M4 review records and handoff marker checks. |
| `docs/changes/2026-06-15-how-to-guide-template-best-practices/change.yaml` and `docs/plan.md` | Added compact change metadata and plan-index routing. | Makes the active change discoverable and keeps lifecycle handoff state synchronized. | Workflow conventions used by this repo. | State-sync checks after each milestone and review. |
| `docs/changes/2026-06-15-how-to-guide-template-best-practices/review-log.md` and `reviews/code-review-*.md` | Recorded plan review and M1-M4 code-review results. | Keeps review outcomes durable without requiring an empty review-resolution artifact for clean reviews. | Code-review and plan-review skill rules. | All M1-M4 code reviews recorded `clean-with-notes` and no material findings. |

## Tests Added Or Changed

| Test or evidence | What it proves | Why this level is appropriate |
| --- | --- | --- |
| `tests/markdown/how-to-guide-template-best-practices.test.sh` | Proves stable Markdown structure, required metadata, command-context conventions, backup cues, guide section order, evidence records, troubleshooting links and anchors, no-command-execution boundaries, security-sensitive guardrails, and proposal accepted status. | The change is documentation-first, so static Markdown checks and review evidence match the risk without pretending to execute Windows + WSL setup commands. |
| `exemplar-review.md` | Records that `proxy-setup.md` is a reference exemplar and not the sole pilot. | The circularity concern is qualitative and needs durable review evidence. |
| `portability-pilot-review.md` | Records the non-exemplar pilot review, fast-path usability conditions, verification signal, and backup coverage. | Portability and skimmability cannot be fully proven by grep; the evidence record captures reviewer judgment without claiming command execution. |
| Code-review records M1-M4 | Show independent review of each implementation slice against the diff and governing artifacts. | The plan is milestone-based; each slice needs review before downstream closeout. |

## Validation Evidence Available Before Final Verify

Recorded validation includes:

- `bash -n tests/markdown/how-to-guide-template-best-practices.test.sh && bash tests/markdown/how-to-guide-template-best-practices.test.sh`
- `rg -n 'status: accepted|^## Status$|^accepted$' docs/proposals/2026-06-15-how-to-guide-template-best-practices.md`
- `rg` checks for template metadata, sections, backup guidance, command context, expected results, rollback, troubleshooting, and evidence-file existence
- `git diff --check`
- `git diff --cached --check`
- `git show --check --format=short HEAD`
- `bash -c 'set -euo pipefail; for test_script in tests/markdown/*.test.sh; do echo "== $test_script"; bash "$test_script"; done'`

Important limits:

- No hosted CI result has been claimed.
- No guide command block has been executed as setup validation.
- No Windows 11 + WSL runner result has been claimed.

## Review Resolution Summary

There are no material code-review findings to resolve. M1, M2, M3, and M4 code reviews are recorded as `clean-with-notes` with no material findings in `docs/changes/2026-06-15-how-to-guide-template-best-practices/review-log.md`.

The only spec-review finding requiring resolution was HGT-SR-001, recorded in `docs/changes/2026-06-15-how-to-guide-template-best-practices/reviews/spec-review-resolution.md`; it was addressed before implementation by making backup guidance testable and adding the proxy fast-path backup cue.

## Alternatives Rejected

- **Exemplar-only, no template file:** rejected because contributors need a copyable authoring artifact, not just an example guide.
- **Headings-only template:** rejected because it would not prevent missing shell context, expected results, backup cues, or rollback guidance.
- **Strict all-sections-required template:** rejected because simple guides would accumulate filler and lose the fast-path benefit.
- **Generated scaffolder or template engine:** rejected as premature and outside the documentation-first scope.
- **Command-execution CI in the first slice:** rejected because Windows + WSL runner assumptions and command contracts are not settled.
- **Renaming `docs/guides/03-ubuntu-baseline.md`:** rejected for this slice; the existing path remains the portability pilot until broader guide migration chooses final task-scoped filenames.

## Scope Control

This change does not:

- convert every guide;
- change PowerShell, WSL, Ubuntu, Neovim, tmux, proxy, sudoers, fstab, mount, or package-source command semantics;
- add a one-command installer, hidden automation, generated documentation site, scaffolder, wizard, or template engine;
- add command-execution CI;
- require a Windows + WSL CI runner;
- move deep troubleshooting into guide pages;
- claim final verification, branch readiness, PR body readiness, or PR open readiness.

## Risks And Follow-Ups

- Static checks are intentionally grep-based and can miss some Markdown edge cases. Code review accepted this as appropriate for the first slice.
- The proof script does not prove that setup commands work on a real Windows 11 + WSL machine; command execution remains a deferred follow-up.
- Future guide conversions still need human review for fast-path skimmability, walkthrough usefulness, and safety judgment.
- Final verification found and fixed one broad-smoke drift in `m1-project-entrypoint.test.sh`; PR handoff remains downstream after verification records branch readiness.

## Current State

The active plan says M1-M4 are closed after code review, no implementation milestones remain, and the next stage is final closeout. This explanation is a final-closeout input before `verify`; it does not claim final verification or PR readiness.
