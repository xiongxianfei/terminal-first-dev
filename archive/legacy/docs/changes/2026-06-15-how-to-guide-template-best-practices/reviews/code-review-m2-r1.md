# Code Review M2 R1: How-To Guide Template Best Practices

## Result

- Skill: code-review
- Status: completed
- Review status: clean-with-notes
- Material findings: none
- Recording status: recorded
- Recording blocker: none
- Review record: `docs/changes/2026-06-15-how-to-guide-template-best-practices/reviews/code-review-m2-r1.md`
- Review log: `docs/changes/2026-06-15-how-to-guide-template-best-practices/review-log.md`
- Review resolution: not-required
- Reviewed milestone: M2
- Milestone closeout: closed
- Remaining implementation milestones: M3, M4
- Required review-resolution: no
- Finding IDs: none
- Verify readiness: not-claimed

## Review Inputs

- Diff/review surface: commit `f14c1d9` (`M2: validate how-to guide exemplar and pilot`)
- Tracked governing branch state: clean worktree before review recording
- Governing artifacts:
  - `specs/how-to-guide-template-best-practices.md`
  - `specs/how-to-guide-template-best-practices.test.md`
  - `docs/plans/2026-06-15-how-to-guide-template-best-practices.md`
  - `docs/changes/2026-06-15-how-to-guide-template-best-practices/reviews/spec-review.md`
- Validation evidence:
  - `bash -n tests/markdown/how-to-guide-template-best-practices.test.sh && bash tests/markdown/how-to-guide-template-best-practices.test.sh`
  - M2 guide and review-evidence `rg` checks
  - `git diff HEAD^..HEAD --check`
  - `git show --check --format=short HEAD`

## Diff Summary

M2 converts `docs/guides/03-ubuntu-baseline.md` into the two-speed how-to shape while preserving the baseline setup surfaces: WSL proxy mirroring, `/etc/wsl.conf`, optional APT source posture, shared data mount, locale readiness, optional passwordless sudo, doctor expectations, rollback, and troubleshooting. The guide now has visible metadata, `Fast path`, `Walkthrough`, backup guidance before file edits, scope and safety notes, expected results, and explicit command contexts.

M2 also adds dry-run evidence records for `docs/guides/proxy-setup.md` as the reference exemplar and `docs/guides/03-ubuntu-baseline.md` as the portability pilot, then extends the proof script to check the guide shape and evidence records.

## Findings

No blocking or required-change findings.

## Checklist Coverage

| Check | Verdict | Evidence |
| --- | --- | --- |
| Spec alignment | pass | Ubuntu pilot metadata appears before commands at lines 3-8; `Fast path`, `Walkthrough`, `Rollback`, and `Troubleshooting` appear at lines 10, 209, 499, and 509. Exemplar/pilot evidence records satisfy R40-R45. |
| Test coverage | pass | `tests/markdown/how-to-guide-template-best-practices.test.sh` lines 109-158 check guide metadata, section order, backup coverage, review files, dry-run/evidence fields, and exemplar/pilot separation. Reviewer reran the script successfully. |
| Edge cases | pass | Backup-before-edit is visible before `.wslconfig`, `/etc/wsl.conf`, APT sources, `/etc/fstab`, and sudoers changes at lines 18, 47, 79, 124, and 182. Dry-run status is recorded at `portability-pilot-review.md` lines 11 and 25. |
| Error handling | pass | The guide gives rollback paths near state-changing edits and in the dedicated rollback section at lines 499-507; missing troubleshooting anchors for non-proxy symptoms are handled with local backup/rollback guidance at line 517 rather than fake anchors. |
| Architecture boundaries | pass | No scripts, generated docs, automation, or setup command execution were introduced; M2 remains documentation and static proof work. |
| Compatibility | pass | `docs/guides/03-ubuntu-baseline.md` remains at the existing numbered path and is explicitly recorded as the portability pilot. |
| Security/privacy | pass | Evidence records state no private machine data, credentials, private hostnames, tokens, or personal paths are recorded. Guide text warns against proxy credentials in shell history and avoids private hostnames. |
| Derived artifact currency | pass | Change metadata, plan, review evidence, guide, and proof script all point to M2 `review-requested` state before this review. |
| Unrelated changes | pass | The diff is scoped to M2 guide conformance, M2 proof checks, exemplar/pilot evidence, and lifecycle state. |
| Validation evidence | pass | Reviewer reran targeted proof, M2 `rg` checks, and commit whitespace checks successfully. |

## No-Finding Rationale

The M2 implementation satisfies R30-R45 and AC7-AC9 through a conforming portability pilot and explicit dry-run evidence. It avoids circular validation by keeping `proxy-setup.md` as the exemplar and using `03-ubuntu-baseline.md` as the non-exemplar pilot. The dry-run records avoid overclaiming command execution, and the guide exposes backup, scope, safety, expected result, and rollback information before risky edits.

## Residual Risks

- This review does not prove that the Ubuntu commands work on a real Windows 11 + WSL machine. The evidence is intentionally dry-run because first-slice validation avoids command execution.
- Troubleshooting link and anchor coverage beyond the existing proxy links is assigned to M3 static validation.

## Handoff

M2 is closed. Next stage is `implement M3`; final closeout remains not ready because M3, M4, final verification, and PR handoff remain open.
