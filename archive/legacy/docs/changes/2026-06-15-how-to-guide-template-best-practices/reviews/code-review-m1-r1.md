# Code Review M1 R1: How-To Guide Template Best Practices

## Result

- Skill: code-review
- Status: completed
- Review status: clean-with-notes
- Material findings: none
- Recording status: recorded
- Recording blocker: none
- Review record: `docs/changes/2026-06-15-how-to-guide-template-best-practices/reviews/code-review-m1-r1.md`
- Review log: `docs/changes/2026-06-15-how-to-guide-template-best-practices/review-log.md`
- Review resolution: not-required
- Reviewed milestone: M1
- Milestone closeout: closed
- Remaining implementation milestones: M2, M3, M4
- Required review-resolution: no
- Finding IDs: none
- Verify readiness: not-claimed

## Review Inputs

- Diff/review surface: commit `864fd37` (`M1: update how-to guide template contract`)
- Tracked governing branch state: clean worktree before review recording
- Governing artifacts:
  - `specs/how-to-guide-template-best-practices.md`
  - `specs/how-to-guide-template-best-practices.test.md`
  - `docs/plans/2026-06-15-how-to-guide-template-best-practices.md`
  - `docs/changes/2026-06-15-how-to-guide-template-best-practices/reviews/spec-review.md`
- Validation evidence:
  - `bash -n tests/markdown/how-to-guide-template-best-practices.test.sh && bash tests/markdown/how-to-guide-template-best-practices.test.sh`
  - `git diff HEAD^..HEAD --check`
  - `git show --check --format=short HEAD`
  - M1 template `rg` checks recorded in the plan

## Diff Summary

M1 updates `docs/templates/how-to-guide.md` from a minimal two-speed skeleton into a contributor-facing template contract. It adds removable contributor notes, required visible metadata, conditional `Scope` and `Safety`, fast path and walkthrough command context, expected results, backup-before-edit fields, rollback guidance, troubleshooting routing, and command-block conventions.

M1 also adds `tests/markdown/how-to-guide-template-best-practices.test.sh` to statically prove the template contract and records change-local lifecycle artifacts. The commit includes the already-approved HGT-SR-001 proxy fast-path backup cue so the tracked branch contains the spec-review resolution before downstream M2 review.

## Findings

No blocking or required-change findings.

## Checklist Coverage

| Check | Verdict | Evidence |
| --- | --- | --- |
| Spec alignment | pass | Template lines 1-17 distinguish required and conditional author guidance; lines 21-26 provide visible metadata; lines 28, 68, 120, and 126 provide required sections; lines 134-144 document command conventions. |
| Test coverage | pass | `tests/markdown/how-to-guide-template-best-practices.test.sh` checks template existence, metadata, section order, backup-before-command placement, command fences, troubleshooting boundary, and non-goal guardrails. Reviewer reran the script successfully. |
| Edge cases | pass | Template lines 38-40 and 80-82 demonstrate explicit mixed-environment command context; lines 34 and 76 place backup guidance before snippets; lines 122-124 cover persistent-change rollback and verification-only not-applicable handling. |
| Error handling | pass | The proof script exits on missing files, missing text, ordering failures, misplaced template location, or forbidden generated-tooling/hidden-automation language. |
| Architecture boundaries | pass | No architecture-triggering runtime, generated docs, machine-changing automation, or command execution was added. |
| Compatibility | pass | Template preserves the accepted two-speed guide structure and keeps `docs/templates/how-to-guide.md` as the canonical template path. |
| Security/privacy | pass | Template line 142 prohibits secrets, proxy credentials, tokens, private hostnames, and private certificate material; no committed examples contain real secret material. |
| Derived artifact currency | pass | No generated artifacts are introduced; proposal, spec, test spec, plan, change metadata, and review log are tracked in the same commit series. |
| Unrelated changes | pass | The proxy-guide backup cue is tied to the accepted HGT-SR-001 spec-review resolution and is recorded as pre-existing implementation context for M2. No unrelated runtime or setup behavior changed. |
| Validation evidence | pass | Reviewer reran targeted proof, commit whitespace checks, and M1 template marker checks successfully. |

## No-Finding Rationale

The template implements the M1 requirements R1-R29 and preserves R52-R54 boundaries without expanding into command semantics, generated documentation tooling, or command-execution CI. The proof script directly checks the stable M1 contract and failed against the previous template before the implementation, giving useful proof-first evidence. Reviewer reruns matched the recorded validation evidence.

## Residual Risks

- M1 does not prove published guide conformance, portability-pilot usability, or troubleshooting anchor coverage beyond the template contract. Those are assigned to M2 and M3.
- The static proof is intentionally grep-based and should stay focused on stable structure, not command correctness.

## Handoff

M1 is closed. Next stage is `implement M2`; final closeout remains not ready because M2, M3, M4, final verification, and PR handoff remain open.
