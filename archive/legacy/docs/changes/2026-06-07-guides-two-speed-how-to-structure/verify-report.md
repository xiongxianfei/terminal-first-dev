# Verify Report: Two-Speed How-To Guide Structure

## Result

- Skill: verify
- Status: passed
- Branch readiness: branch-ready for PR handoff based on local verification
- Open blockers: none
- Next stage: pr
- CI status: not available; no GitHub Actions or project CI workflow was present or observed
- Verification date: 2026-06-15

## Scope

Verified the completed change pack for `2026-06-07-guides-two-speed-how-to-structure` after M1, M2, and M3 implementation milestones were closed by code review.

## Traceability

| Requirement area | Test or evidence | Files changed | Status |
| --- | --- | --- | --- |
| R1-R8, R41-R42 router and migration | `tests/markdown/guides-two-speed-how-to-structure.test.sh`; M1 code review | `docs/guides/README.md` | pass |
| R9-R11 template placement and structure | `tests/markdown/guides-two-speed-how-to-structure.test.sh`; M1 code review | `docs/templates/how-to-guide.md` | pass |
| R12-R28, R40 proxy guide shape and troubleshooting boundary | `tests/markdown/guides-two-speed-how-to-structure.test.sh`; M2 code review | `docs/guides/proxy-setup.md` | pass |
| R29-R32 pilot benefit evidence | `pilot-review.md`; M2 code review | `docs/changes/2026-06-07-guides-two-speed-how-to-structure/pilot-review.md` | pass |
| R33-R36 validation and CI boundary | `tests/markdown/guides-two-speed-how-to-structure.test.sh`; M3 code review | `tests/markdown/guides-two-speed-how-to-structure.test.sh` | pass |
| AC1-AC12 acceptance criteria | Full Markdown suite and review records | Proposal, spec, guides, tests, change record | pass |

## Validation Commands

Run from repository root `/home/xiongxianfei/data/20260607-terminal-first-windows-dev`.

| Command | Result | Notes |
| --- | --- | --- |
| `bash tests/markdown/guides-two-speed-how-to-structure.test.sh` | pass | Targeted guide-structure proof. |
| `bash tests/markdown/m1-project-entrypoint.test.sh` | initial fail, then pass | Initially failed because legacy setup-guide checks applied to `docs/guides/README.md`; fixed by scoping those checks to numbered setup guides. |
| `bash -c 'set -euo pipefail; for test_script in tests/markdown/*.test.sh; do echo "== $test_script"; bash "$test_script"; done'` | pass | Full local Markdown/static test suite. |
| `git diff --check -- tests/markdown/m1-project-entrypoint.test.sh docs/changes/2026-06-07-guides-two-speed-how-to-structure/explain-change.md docs/plans/2026-06-07-guides-two-speed-how-to-structure.md` | pass | Whitespace check for verification-stage edits. |
| `LC_ALL=C rg -n "[^\\x00-\\x7F]" tests/markdown/m1-project-entrypoint.test.sh docs/changes/2026-06-07-guides-two-speed-how-to-structure/explain-change.md docs/plans/2026-06-07-guides-two-speed-how-to-structure.md` | pass | Returned no matches. |

## Verification Dimensions

| Dimension | Result | Evidence |
| --- | --- | --- |
| Spec coverage | pass | R1-R42 are mapped through M1-M3 plan coverage and the targeted proof script. |
| Requirement satisfaction | pass | The router, template, proxy pilot, pilot evidence, and static proof script exist and are checked. |
| Test coverage | pass | Test spec T1-T9 are covered by milestone validations, manual pilot evidence, code reviews, and the final proof script. |
| Test validity | pass | M1, M2, and M3 recorded expected baseline failures before implementation; final verification fixed one stale broad test assumption and reran the full suite. |
| Architecture coherence | pass | Architecture was not required; the change remains documentation structure plus local static validation. |
| Artifact lifecycle state | pass | Proposal is accepted, spec is approved, test spec is active, all milestones are closed, and review records show no material code-review findings. |
| Plan completion | pass | No in-scope implementation milestones remain. Plan and project plan index now point to PR handoff after verification. |
| Validation evidence | pass | Local commands above passed. Hosted CI was not available or observed. |
| Drift detection | pass | Verification found and fixed stale legacy test glob behavior in `m1-project-entrypoint.test.sh`. |
| Risk closure | pass | The implementation preserves troubleshooting split, avoids command-execution CI, keeps existing numbered guide discoverability, and documents rollback/follow-up limits. |
| Release readiness | pass | Local branch is ready for PR handoff; no generated files, migrations, secrets, or hosted CI claims are involved. |

## Review State

- M1 code review: clean-with-notes, no material findings.
- M2 code review: clean-with-notes, no material findings.
- M3 code review: clean-with-notes, no material findings.
- Review resolution: not required for code-review findings.
- Earlier plan-review PR-001 was resolved before implementation and approved by plan-review R2.

## CI Status

No hosted CI workflow was present under `.github/`, and no hosted CI run was observed. This report claims local verification only.

## Residual Risks

- The static proof script checks stable Markdown shape and anchors; it does not execute setup commands or prove real Windows/WSL/proxy behavior.
- The proxy pilot was manually walked through as documentation; it was not executed in a live enterprise proxy environment.
- PR handoff may need branch/push handling because the current local branch is `main` ahead of `origin/main`.

## Handoff

Final verification passed locally. Next stage is PR handoff.
