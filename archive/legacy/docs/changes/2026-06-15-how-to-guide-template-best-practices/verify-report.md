# Verify Report: How-To Guide Template Best Practices

## Result

- Skill: verify
- Status: passed
- Branch readiness: branch-ready for PR handoff based on local verification
- Open blockers: none
- Next stage: pr
- CI status: not available; no GitHub Actions or project CI workflow was present or observed
- Verification date: 2026-06-15
- Verification timestamp: 2026-06-15T12:53:18-07:00

## Scope

Verified the completed change pack for `2026-06-15-how-to-guide-template-best-practices` after M1, M2, M3, and M4 implementation milestones were closed by code review and the durable explanation was updated.

This verification covers local artifact-code-test coherence and branch readiness for PR handoff. It does not claim PR body readiness, PR open readiness, hosted CI success, or Windows + WSL setup command execution.

## Traceability

| Requirement area | Test or evidence | Files changed | Status |
| --- | --- | --- | --- |
| R1-R21 template core and guide-shape contract | `tests/markdown/how-to-guide-template-best-practices.test.sh`; M1 code review | `docs/templates/how-to-guide.md` | pass |
| R22-R29 command-block and security-sensitive example conventions | Proof script; explain-change scope control | `docs/templates/how-to-guide.md`, `tests/markdown/how-to-guide-template-best-practices.test.sh` | pass |
| R30-R39 published guide conformance, safety, backup, rollback, and troubleshooting boundaries | Proof script; full Markdown/static suite; M2 code review | `docs/guides/proxy-setup.md`, `docs/guides/03-ubuntu-baseline.md` | pass |
| R40-R45 reference exemplar and portability pilot evidence | `exemplar-review.md`, `portability-pilot-review.md`; M2 code review | Change-local evidence records | pass |
| R46-R51 static validation and no-command-execution boundary | Proof script; full Markdown/static suite; M3 code review | `tests/markdown/how-to-guide-template-best-practices.test.sh` | pass |
| R52-R54 compatibility, command-semantics boundary, and `03-ubuntu-baseline.md` path preservation | Proof script; full Markdown/static suite; verification-stage smoke-test fix | `docs/guides/03-ubuntu-baseline.md`, `tests/markdown/m1-project-entrypoint.test.sh` | pass |
| AC1-AC14 acceptance criteria | T9 proof, proposal accepted-status check, review records, full suite | Proposal, spec, template, guides, tests, change records | pass |

## Validation Commands

Run from repository root `/home/xiongxianfei/data/20260524-terminal-dev`.

| Command | Result | Notes |
| --- | --- | --- |
| `bash -n tests/markdown/how-to-guide-template-best-practices.test.sh && bash tests/markdown/how-to-guide-template-best-practices.test.sh` | pass | Targeted how-to template proof. |
| `rg -n 'status: accepted|^## Status$|^accepted$' docs/proposals/2026-06-15-how-to-guide-template-best-practices.md` | pass | AC14 proposal-status evidence. |
| `git diff --check && git diff main...HEAD --check` | pass | Whitespace validation for working tree and branch diff before verification-stage edits. |
| `bash tests/markdown/m3-ubuntu-baseline.test.sh` | initial fail, then pass | Initially failed because the two-speed rewrite dropped exact semantic cues expected by the older smoke test; restored the guide cues. |
| `bash -c 'set -euo pipefail; for test_script in tests/markdown/*.test.sh; do echo "== $test_script"; bash "$test_script"; done'` | initial fail, then pass | Initially failed on stale `m1-project-entrypoint` assumptions and then on Ubuntu baseline semantic cues; both drift issues were fixed. |
| `git diff --check` | pass | Whitespace validation after verification-stage fixes and report edits. |

## Verification Dimensions

| Dimension | Result | Evidence |
| --- | --- | --- |
| Spec coverage | pass | R1-R54 map to template, guide, evidence, and proof-script changes in the traceability table. |
| Requirement satisfaction | pass | Required template, exemplar, pilot, validation, backup, troubleshooting, compatibility, and non-goal surfaces exist and are checked. |
| Test coverage | pass | Test spec T1-T9 are covered by the proof script, evidence records, full Markdown/static suite, and code-review records. |
| Test validity | pass | M1 and M2 recorded expected proof-first failures; final verification found and fixed broad-suite drift before passing the full suite. |
| Architecture coherence | pass | Architecture was not required; the change remains Markdown documentation, guide evidence, and local static validation. |
| Artifact lifecycle state | pass | Proposal is accepted, spec is approved, test spec is active, M1-M4 are closed, explain-change is current, and this report records final verification. |
| Plan completion | pass | All implementation milestones are closed; `docs/plan.md` and the plan body are updated for PR handoff by this verification stage. |
| Validation evidence | pass | Local commands above passed. Hosted CI was not available or observed. |
| Drift detection | pass | Verification found and fixed two drift points: stale broad entrypoint expectations for the converted Ubuntu pilot and missing exact semantic cues required by the Ubuntu baseline smoke test. |
| Risk closure | pass | The change preserves documentation-first scope, avoids command-execution CI, keeps the portability pilot path, preserves setup command semantics, and records static-check limits. |
| Release readiness | pass | Branch is ready for PR handoff locally; no generated files, migrations, secrets, hosted CI claims, or setup-command execution claims are involved. |

## Review State

- Plan review: approved, no material findings.
- M1 code review: clean-with-notes, no material findings.
- M2 code review: clean-with-notes, no material findings.
- M3 code review: clean-with-notes, no material findings.
- M4 code review: clean-with-notes, no material findings.
- Code-review resolution: not required.
- Spec-review resolution: HGT-SR-001 was addressed before implementation by making backup guidance testable and adding the proxy fast-path backup cue.

## CI Status

No hosted CI workflow was present under `.github/`, and no hosted CI run was observed. This report claims local verification only.

## Verification-Stage Fixes

- Updated `tests/markdown/m1-project-entrypoint.test.sh` so `docs/guides/03-ubuntu-baseline.md` is checked for the accepted two-speed sections instead of the old numbered-guide section set.
- Restored semantic cues in `docs/guides/03-ubuntu-baseline.md` required by `tests/markdown/m3-ubuntu-baseline.test.sh`: `http_proxy`, `https_proxy`, lowercase `corporate CA`, `APT source configuration`, and `create, skip, or choose`.
- Updated `explain-change.md` to record both verification-stage fixes.

## Residual Risks

- The proof suite is static and grep-based; it does not execute setup commands or prove live Windows 11 + WSL behavior.
- The portability pilot evidence is dry-run documentation review, not execution on a live Windows + WSL machine.
- PR handoff still needs PR-body preparation and any remote branch/push handling.

## Handoff

Final verification passed locally. The branch is ready for PR handoff. Next stage is `pr`.
