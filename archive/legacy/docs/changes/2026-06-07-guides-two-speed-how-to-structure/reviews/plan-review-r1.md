# Plan Review R1: Two-Speed How-To Guide Structure

## Result

- Skill: plan-review
- Review status: changes-requested
- Material findings: PR-001
- Recording status: recorded
- Recording blocker: none
- Review record: `docs/changes/2026-06-07-guides-two-speed-how-to-structure/reviews/plan-review-r1.md`
- Review log: `docs/changes/2026-06-07-guides-two-speed-how-to-structure/review-log.md`
- Review resolution: not-required before fixing; required after revision only if the finding disposition needs separate explanation
- Open blockers: PR-001
- Immediate next stage: plan revision

## Findings

### PR-001 - Test-spec artifact is assigned to an implementation milestone

- Finding ID: PR-001
- Severity: major
- Location: `docs/plans/2026-06-07-guides-two-speed-how-to-structure.md`, M3 "Files/components likely touched", M3 dependencies, validation plan
- Evidence: The plan correctly says the test spec is pending and expected after plan-review, and M3 depends on "Test spec exists and names the checks." However, M3 also lists `specs/guides-two-speed-how-to-structure.test.md` under "Files/components likely touched" and includes that path in the M3 path-scoped whitespace command. This makes the implementation milestone appear to own or modify the test-spec artifact, which conflicts with the workflow sequence where `test-spec` is authored before implementation and then used as source evidence.
- Required outcome: Remove the test-spec file from implementation-owned M3 files and implementation-surface validation commands. Keep it as a source artifact/dependency and ensure the plan states test-spec authoring happens after plan-review and before implementation.
- Safe resolution path: In M3, replace `specs/guides-two-speed-how-to-structure.test.md` under "Files/components likely touched" with the actual implementation proof script path, likely `tests/markdown/guides-two-speed-how-to-structure.test.sh`. In the validation plan and M3 whitespace command, scope implementation whitespace to implementation-owned files and the change-local plan/review evidence, not the already-authored test spec. Preserve the dependency line that the test spec must exist before implementation.

## Review Dimensions

| Review dimension | Verdict | Notes |
| --- | --- | --- |
| self-contained context | pass | The plan names current guide files, troubleshooting files, source artifacts, and the command-semantics boundary. |
| source alignment | concern | Requirements map to milestones, but PR-001 blurs ownership of the test-spec artifact. |
| milestone size | pass | M1 router/template, M2 proxy pilot, and M3 validation are reviewable slices. |
| sequencing | concern | High-level sequence is right, but M3 currently implies implementation may touch the test spec after the test-spec stage. |
| scope discipline | pass | The plan excludes full guide conversion, command-contract changes, command-execution CI, generated docs, and hidden automation. |
| validation quality | concern | Validation is useful, but PR-001 should be corrected so validation surfaces match stage ownership. |
| TDD readiness | concern | Test-spec is correctly required before implementation, but the plan needs to keep that artifact out of implementation-owned file lists. |
| risk coverage | pass | Router drift, proxy troubleshooting sprawl, command drift, numbered-guide discoverability, and brittle checks are covered. |
| architecture alignment | pass | Architecture is reasonably marked not required because the work is documentation structure and validation, not automation or machine-changing behavior. |
| operational readiness | pass | The plan preserves manual/advisory command review and avoids CI command execution. |
| plan maintainability | pass | Current handoff, progress, decisions, validation notes, and remaining gates are visible. |

## Missing Milestones Or Dependencies

No missing implementation milestones. The required fix is to keep test-spec as an upstream dependency rather than an implementation-touched file.

## Suggested Edits

- In M3 "Files/components likely touched", remove `specs/guides-two-speed-how-to-structure.test.md`.
- Add `tests/markdown/guides-two-speed-how-to-structure.test.sh` explicitly as the M3 proof-script target.
- In M3 validation and the global validation plan, avoid including the test-spec path in implementation-surface `git diff --check` unless the same stage actually modifies it.
- Keep "Test spec exists and names the checks" as a dependency.

## Recommendation

Revise the plan for PR-001, then rerun plan-review. No automatic downstream handoff occurs from this review-only invocation.
