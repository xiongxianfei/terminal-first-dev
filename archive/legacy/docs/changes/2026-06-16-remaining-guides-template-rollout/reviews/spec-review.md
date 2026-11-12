---
id: 2026-06-16-remaining-guides-template-rollout-spec-review
spec: specs/remaining-guides-template-rollout.md
review_status: approved
created: 2026-06-16
repo: xiongxianfei/terminal-first-windows-dev
---

# Spec Review: Remaining Guides Template Rollout

## Result

- Skill: spec-review
- Review status: approved
- Material findings: none
- Recording status: recorded
- Recording blocker: none
- Review record: `docs/changes/2026-06-16-remaining-guides-template-rollout/reviews/spec-review.md`
- Review log: `docs/changes/2026-06-16-remaining-guides-template-rollout/reviews/spec-review.md`
- Review resolution: `docs/changes/2026-06-16-remaining-guides-template-rollout/reviews/spec-review-resolution.md`
- Open blockers: none
- Immediate next stage: plan
- Eventual test-spec readiness: ready
- Stop condition: none

Latest review round: 2026-06-16 second pass.

The spec is approved for planning. `RGT-SR-001` is addressed by the spec revision and review-resolution record. Before downstream plan, test-spec, or implementation relies on the spec, normalize `specs/remaining-guides-template-rollout.md` status from `draft` to `approved`.

## Review Log

| Round | Date | Status | Findings | Notes |
| --- | --- | --- | --- | --- |
| 1 | 2026-06-16 | changes-requested | RGT-SR-001 | Verification guide sequencing was not observable because R58 used `enough stable targets`. |
| 2 | 2026-06-16 | approved | none | RGT-SR-001 resolved; spec is ready for planning after status normalization. |

## Prior Finding Resolution

| Finding ID | Disposition | Evidence |
| --- | --- | --- |
| RGT-SR-001 | addressed | R58 now excludes `99-verification.md` from the first smaller-guide slice and requires every active setup-guide path referenced by `99-verification.md` to exist after the same change, or to be recorded as an unresolved verification follow-up instead of an active reference. The glossary defines active verification reference, unresolved verification follow-up, and verification target inventory. R75 requires the inventory and AC21 makes sequencing acceptance observable. |

## Findings

None in the latest review round.

## Original Finding RGT-SR-001

- Finding ID: RGT-SR-001
- Severity: major
- Location: `specs/remaining-guides-template-rollout.md` R58, lines 208-210; related rollout sequencing in lines 419-424.
- Evidence: R58 says `docs/guides/99-verification.md` "MUST be converted after setup-guide conversion has enough stable targets for the verification matrix." The phrase "enough stable targets" is not defined in the glossary, requirements, acceptance criteria, or rollout text. A plan or test spec would have to guess whether this means after the first smaller-guide slice, after Windows host, after the WSL split, after all setup guides, or after a reviewer decides the matrix is stable.
- Required outcome: The spec must make verification-guide sequencing observable without relying on reviewer interpretation of "enough stable targets."
- Safe resolution path: Replace R58 with a concrete rule, and add or adjust acceptance coverage. A safe wording is: `R58. docs/guides/99-verification.md MUST NOT be converted in the first smaller-guide slice. It MUST be converted only after the converted setup-guide paths it references exist, or the same slice updates those paths and records unresolved verification targets as follow-ups.` Add a matching acceptance criterion such as: `AC21. The spec defines an observable sequencing rule for 99-verification.md conversion, including how missing or not-yet-converted verification targets are handled.`
- needs-decision rationale: none

## Review Dimensions

| Review dimension | Verdict | Notes |
| --- | --- | --- |
| requirement clarity | pass | Requirements are clear and traceable, including the now-observable `99-verification.md` sequencing rule. |
| normative language | pass | `MUST` statements are testable through static checks, review evidence, or manual review; R58 no longer uses reviewer-discretion language. |
| completeness | pass | The spec covers normal conversion, WSL split, compatibility stubs, router behavior, backup-before-edit, security, migration, and validation boundaries. |
| testability | pass | Structure, link, backup, parity, privacy, WSL split, compatibility-stub, and verification sequencing requirements are testable through static checks and review evidence. |
| examples | pass | Examples cover smaller-guide conversion, optional uv, WSL split, compatibility stubs, unified Windows host, and verification as proof surface. |
| compatibility | pass | The spec preserves numbered paths during body conformance, defines WSL stubs, defers broad filename migration, and preserves command semantics. |
| observability | pass | Review evidence and static-check reporting are covered, including verification target inventory evidence for `99-verification.md`. |
| security/privacy | pass | The spec excludes credentials, private hostnames, private indexes, personal paths, and private machine data, and calls out uv package-index risk. |
| non-goals | pass | Non-goals preserve command semantics, avoid command-execution CI, avoid generated tooling, and keep broad filename migration out of scope. |
| acceptance criteria | pass | Acceptance criteria cover the rollout decisions and AC21 ties verification-guide sequencing to observable inventory evidence. |

## Eventual test-spec readiness

Ready.

The test spec can map requirements to:

- static converted-guide structure checks;
- path-scoped checks for the first smaller-guide slice;
- WSL split and compatibility-stub checks;
- router checks while numbered and task-scoped paths coexist;
- troubleshooting link and anchor checks;
- backup-before-edit static or review-evidence checks;
- review evidence for fast-path/walkthrough parity and command-context coverage;
- privacy checks for uv package-index examples;
- no command-execution-CI checks;
- verification target inventory checks for `99-verification.md` sequencing.

## Stop condition

None. No automatic downstream handoff occurs from this review.
