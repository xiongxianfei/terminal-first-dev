# Code Review M4 R1: How-To Guide Template Best Practices

## Result

- Skill: code-review
- Status: completed
- Artifacts changed: `docs/changes/2026-06-15-how-to-guide-template-best-practices/reviews/code-review-m4-r1.md`, `docs/changes/2026-06-15-how-to-guide-template-best-practices/review-log.md`, `docs/plans/2026-06-15-how-to-guide-template-best-practices.md`, `docs/changes/2026-06-15-how-to-guide-template-best-practices/change.yaml`, `docs/plan.md`
- Open blockers: none
- Next stage: final closeout
- Review status: clean-with-notes
- Material findings: none
- Recording status: recorded
- Recording blocker: none
- Review record: `docs/changes/2026-06-15-how-to-guide-template-best-practices/reviews/code-review-m4-r1.md`
- Review log: `docs/changes/2026-06-15-how-to-guide-template-best-practices/review-log.md`
- Review resolution: not-required
- Reviewed milestone: M4
- Milestone closeout: closed
- Remaining implementation milestones: none
- Required review-resolution: no
- Finding IDs: none
- Verify readiness: not-claimed

## Review Inputs

- Diff/review surface: commit `24f4dfe` (`M4: close how-to template plan evidence`)
- Tracked governing branch state: commit `24f4dfe` includes the M4 proof-script assertion, plan updates, change metadata, project plan index, and explain-change update
- Governing artifacts:
  - `specs/how-to-guide-template-best-practices.md`
  - `specs/how-to-guide-template-best-practices.test.md`
  - `docs/plans/2026-06-15-how-to-guide-template-best-practices.md`
  - `CONSTITUTION.md`
- Validation evidence:
  - `bash -n tests/markdown/how-to-guide-template-best-practices.test.sh && bash tests/markdown/how-to-guide-template-best-practices.test.sh`
  - `rg -n 'status: accepted|^## Status$|^accepted$' docs/proposals/2026-06-15-how-to-guide-template-best-practices.md`
  - `git show --check --format=short HEAD`
  - Review-time inspection of the M4 diff with `git diff HEAD^ HEAD -- ...`

## Diff Summary

M4 adds the accepted proposal as an explicit proof-script input and checks both `status: accepted` and a rendered-body `accepted` status line. This closes the AC14 evidence gap in the acceptance-criteria proof without scanning the proposal for rejected-option language that intentionally appears in options and non-goals.

M4 also updates the active plan, change metadata, project plan index, and explain-change record to mark M4 as ready for code review before this review. The wording preserves downstream boundaries by stating that final verification and PR handoff remain open.

## Findings

No blocking or required-change findings.

## Checklist Coverage

| Check | Verdict | Evidence |
| --- | --- | --- |
| Spec alignment | pass | AC14 requires the proposal status to be settled to `accepted`; M4 checks the proposal file exists and asserts `status: accepted` plus a rendered `accepted` line in the proof script. |
| Test coverage | pass | `tests/markdown/how-to-guide-template-best-practices.test.sh` now defines `proposal` at line 96, requires the file at line 103, and checks accepted status at lines 220-221. Reviewer reran the proof script successfully. |
| Edge cases | pass | The proposal is deliberately not included in the generated-tooling/hidden-automation negative scan, avoiding false failures on rejected-option and non-goal wording while still checking AC14 directly. |
| Error handling | pass | The existing `require_file`, `require_text`, and `require_regex` helpers fail with concrete missing-file, missing-text, or missing-pattern messages. |
| Architecture boundaries | pass | M4 only changes static validation and lifecycle evidence. It does not introduce generated docs tooling, setup automation, command execution, or machine-changing behavior. |
| Compatibility | pass | The static proof remains plain Bash and still runs locally without Windows + WSL. Existing guide paths and earlier milestone evidence are unchanged. |
| Security/privacy | pass | No credentials, tokens, private hostnames, or private certificate material are introduced. The implementation-surface negative scan remains scoped to template, guide, and evidence files. |
| Derived artifact currency | pass | `change.yaml`, `plan.md`, `docs/plan.md`, and `explain-change.md` all point to M4 `review-requested` before review. This review updates them for M4 closeout. |
| Unrelated changes | pass | The commit is scoped to AC14 proof and lifecycle handoff evidence; no guide content, setup command semantics, or troubleshooting content changed. |
| Validation evidence | pass | Reviewer reran the targeted proof script, AC14 `rg` check, and commit whitespace check successfully. No CI result is claimed. |

## No-Finding Rationale

The M4 implementation satisfies T9 and AC10-AC14 for lifecycle evidence without widening scope. It adds direct proof for accepted proposal status, keeps final verification and PR handoff explicitly downstream, and avoids creating premature `verify-report.md` or PR artifacts. The reviewed diff does not claim branch readiness, final verification, CI success, or setup command execution.

## Residual Risks

- Final verification and PR handoff have not run; they remain downstream final-closeout work.
- The static proof remains grep-based by design and does not prove command correctness on a Windows 11 + WSL machine.

## Milestone Handoff State

- Reviewed milestone: M4
- Review status: clean-with-notes
- Milestone state after review: closed
- Required review-resolution: no
- Remaining in-scope implementation milestones: none
- Next stage: final closeout
- Final closeout readiness: ready for final closeout sequence; final verification and PR handoff have not run.
