# Code Review M3 R1: How-To Guide Template Best Practices

## Result

- Skill: code-review
- Status: completed
- Review status: clean-with-notes
- Material findings: none
- Recording status: recorded
- Recording blocker: none
- Review record: `docs/changes/2026-06-15-how-to-guide-template-best-practices/reviews/code-review-m3-r1.md`
- Review log: `docs/changes/2026-06-15-how-to-guide-template-best-practices/review-log.md`
- Review resolution: not-required
- Reviewed milestone: M3
- Milestone closeout: closed
- Remaining implementation milestones: M4
- Required review-resolution: no
- Finding IDs: none
- Verify readiness: not-claimed

## Review Inputs

- Diff/review surface: commit `6d3bc94` (`M3: add how-to template validation`)
- Tracked governing branch state: clean worktree before review recording
- Governing artifacts:
  - `specs/how-to-guide-template-best-practices.md`
  - `specs/how-to-guide-template-best-practices.test.md`
  - `docs/plans/2026-06-15-how-to-guide-template-best-practices.md`
  - `CONSTITUTION.md`
- Validation evidence:
  - `bash -n tests/markdown/how-to-guide-template-best-practices.test.sh && bash tests/markdown/how-to-guide-template-best-practices.test.sh`
  - `git show --check --format=short HEAD`
  - Review-time inspection of the M3 diff with `git diff HEAD^ HEAD -- ...`

## Diff Summary

M3 extends `tests/markdown/how-to-guide-template-best-practices.test.sh` from template and guide conformance checks into a broader static proof. The script now resolves troubleshooting links and heading-derived anchors, checks the Ubuntu pilot path remains present, verifies first-slice validation boundaries in the governing specs, and rejects generated-doc tooling, one-command installer language, hidden automation language, and credential-like examples across the template, exemplar, pilot, and evidence records.

M3 also updates the change plan, change metadata, plan index, and change explanation to mark the milestone as ready for code review before this review.

## Findings

No blocking or required-change findings.

## Checklist Coverage

| Check | Verdict | Evidence |
| --- | --- | --- |
| Spec alignment | pass | Spec R46-R54 require static metadata/section checks, troubleshooting file and anchor resolution, no guide command execution, no Windows + WSL runner requirement, no command-semantic drift, compatibility with the two-speed spec, and preserving `docs/guides/03-ubuntu-baseline.md`. The M3 script covers these at lines 159-217 and 219-230. |
| Test coverage | pass | The proof script now checks heading-derived anchors through `slugify_heading` and `require_anchor` at lines 41-61, troubleshooting target files and anchors at lines 64-80 and 210-211, and first-slice boundary text at lines 213-217. Reviewer reran the script successfully. |
| Edge cases | pass | Missing troubleshooting files or anchors fail through `require_file` and `require_anchor`; pilot path compatibility is checked at line 213; setup command execution is guarded by checking the script itself for un-obfuscated setup commands at lines 229-230. |
| Error handling | pass | Failure helpers report the missing file, missing text, missing pattern, ordered-text problem, missing anchor, or rejected boundary text. These are appropriate for static Markdown validation. |
| Architecture boundaries | pass | The diff adds shell-based static validation only. It does not add generated documentation tooling, a template engine, a setup runner, or machine-changing automation. |
| Compatibility | pass | The script checks the earlier two-speed guide spec's command-execution CI boundary at line 217 and requires `docs/guides/03-ubuntu-baseline.md` to remain present at line 213. |
| Security/privacy | pass | The script rejects credential-like examples and private hostnames across the changed guide/template/evidence surfaces at lines 219-227. No secrets were visible in the reviewed diff. |
| Derived artifact currency | pass | `change.yaml`, `plan.md`, `docs/plan.md`, and `explain-change.md` were updated to reflect M3 review-requested state before review. This review updates them again for M3 closeout. |
| Unrelated changes | pass | The commit is scoped to the M3 proof script and milestone handoff metadata; no unrelated guide content or setup command semantics changed. |
| Validation evidence | pass | Reviewer reran the targeted proof script and commit whitespace check successfully. No CI result is claimed. |

## No-Finding Rationale

The M3 implementation satisfies the static-validation milestone without crossing the first-slice boundary. It resolves troubleshooting targets using existing Markdown headings, validates current exemplar and pilot conformance, verifies compatibility guardrail text in the governing specs, and uses negative checks for generated tooling, hidden automation, and sensitive examples. The reviewed diff does not execute guide code blocks, require a Windows + WSL runner, rename the portability pilot, or alter setup command semantics.

## Residual Risks

- The anchor checker intentionally supports normal GitHub-style heading slugs and does not implement every possible Markdown anchor edge case. This is acceptable for the current troubleshooting documents and matches the plan's static-check scope.
- The negative command-execution guard is not a full shell static analyzer. It is a focused first-slice guardrail paired with manual diff review.

## Handoff

M3 is closed. Next stage is `implement M4`; final closeout remains not ready because M4, final verification, and PR handoff remain open.
