# Code Review M3 R1: Two-Speed How-To Guide Structure

## Result

- Skill: code-review
- Status: completed
- Artifacts changed: `docs/changes/2026-06-07-guides-two-speed-how-to-structure/reviews/code-review-m3-r1.md`, `docs/changes/2026-06-07-guides-two-speed-how-to-structure/review-log.md`, `docs/plans/2026-06-07-guides-two-speed-how-to-structure.md`, `docs/changes/2026-06-07-guides-two-speed-how-to-structure/change.yaml`, `docs/plan.md`
- Open blockers: none
- Next stage: final closeout
- Review status: clean-with-notes
- Material findings: none
- Recording status: recorded
- Recording blocker: none
- Review record: `docs/changes/2026-06-07-guides-two-speed-how-to-structure/reviews/code-review-m3-r1.md`
- Review log: `docs/changes/2026-06-07-guides-two-speed-how-to-structure/review-log.md`
- Review resolution: not-required
- Reviewed milestone: M3
- Milestone closeout: closed
- Remaining implementation milestones: none
- Required review-resolution: no
- Finding IDs: none
- Verify readiness: not-claimed

## Review Inputs

- Diff/review surface: commit `b7d0079` (`M3: add guide structure validation`).
- Tracked governing branch state: commit `b7d0079` includes the M3 proof script, plan updates, change metadata, project plan index, and explain-change update.
- Governing artifacts: `specs/guides-two-speed-how-to-structure.md`, `specs/guides-two-speed-how-to-structure.test.md`, and `docs/plans/2026-06-07-guides-two-speed-how-to-structure.md`.
- Validation evidence: M3 implementation validation recorded in the plan, plus reviewer rerun of the proof script, commit whitespace checks, and setup-command string guard.

## Diff Summary

M3 adds `tests/markdown/guides-two-speed-how-to-structure.test.sh`, a static Markdown proof script for the guide-structure slice. The script checks router, template, proxy pilot, troubleshooting anchors, migration discoverability, pilot evidence, advisory command-review language, and the no-command-execution boundary. The commit also updates the active plan, change metadata, project plan index, and explain-change record for M3 handoff.

## Findings

No blocking or required-change findings.

## Checklist Coverage

| Check | Result | Evidence |
| --- | --- | --- |
| Spec alignment | pass | The proof script covers R33-R36 and AC8-AC10 by checking required guide shape, relative troubleshooting anchors, advisory command-review language, and no command-execution CI requirement. |
| Test coverage | pass | Reviewer reran `bash tests/markdown/guides-two-speed-how-to-structure.test.sh`; it exited cleanly. The script checks router/template/proxy guide shape, numbered guide discoverability, proxy anchors, pilot evidence, and guardrail phrases. |
| Edge cases | pass | The script checks migration compatibility for current numbered guides, verifies task-scoped proxy routing, and confirms required troubleshooting anchors exist. |
| Error handling | pass | Script helper functions emit specific missing-file, missing-text, missing-pattern, and missing-anchor messages before exiting. |
| Architecture boundaries | pass | The script is a local Markdown/static check. It does not add setup automation, generated docs, static-site tooling, or command-execution CI. |
| Compatibility | pass | Existing `tests/markdown/*.test.sh` files use plain Bash static checks and non-executable mode; the new script follows that convention and is invoked with `bash`. |
| Security/privacy | pass | The script checks for no proxy credentials/private hostnames language and includes a guard against setup-command execution strings in the proof script. No secrets or private proxy values were added. |
| Derived artifact currency | pass | No generated artifacts are involved. Change metadata, plan, explain-change, review log, and project plan index are synchronized for M3 closeout. |
| Unrelated changes | pass | The reviewed commit surface is limited to the M3 proof script and lifecycle metadata/explanation updates. |
| Validation evidence | pass | `bash tests/markdown/guides-two-speed-how-to-structure.test.sh`, `git diff HEAD^..HEAD --check`, and `git show --check --format=short HEAD` passed during review; `rg -n "apt update|sudo apt|winget |wsl --install|update-ca-certificates" tests/markdown/guides-two-speed-how-to-structure.test.sh` returned no matches. |

## No-Finding Rationale

The M3 contract is to add lightweight validation for guide shape and links without running setup commands. The script directly checks the approved stable surfaces and keeps command correctness outside this slice, matching the test spec's static-proof boundary. The implementation-owned proof script lives under `tests/`, while the upstream test spec remains unmodified.

## Residual Risks

- The proof script is intentionally static and grep-based; it does not replace human review of guide clarity or real Windows/WSL/proxy behavior.
- Full final verification and PR readiness have not been claimed by this review.

## Milestone Handoff State

- Reviewed milestone: M3
- Review status: clean-with-notes
- Milestone state after review: closed
- Required review-resolution: no
- Remaining in-scope implementation milestones: none
- Next stage: final closeout
- Final closeout readiness: ready for final closeout sequence; final verification and PR handoff have not run.
