# PR Handoff: How-To Guide Template Best Practices

## Title

docs: add best-practice how-to guide template

## PR Open Status

- Status: opened.
- URL: https://github.com/xiongxianfei/terminal-first-windows-dev/pull/3
- Local branch: `proposal/how-to-guide-template-best-practices`
- Base branch: `main`
- Blocker: none.

## Summary

- Add the accepted proposal, spec, test spec, plan, review records, explanation, and verification report for the how-to guide template contract.
- Replace the reusable how-to template with a two-speed, copyable Markdown contract for fast paths, walkthroughs, explicit command context, expected results, backup guidance, rollback, and troubleshooting routing.
- Validate the shape with `proxy-setup.md` as the reference exemplar and `03-ubuntu-baseline.md` as the independent portability pilot.
- Add static Markdown validation for template, guide, evidence, troubleshooting-link, anchor, backup, non-goal, and security guardrails.

## Why

- The accepted two-speed guide direction needed a concrete contributor-facing template, not only an example guide.
- Terminal-first Windows + WSL setup docs can touch WSL config, Ubuntu system files, sudoers, mounts, proxy behavior, shell/editor state, and tmux config, so guides need visible safety and recovery cues before edits.
- Contributors need reviewable static checks that keep guide structure consistent without introducing setup automation or command-execution CI.

## Spec / Plan / Architecture

- Proposal: `docs/proposals/2026-06-15-how-to-guide-template-best-practices.md`
- Proposal review: `docs/changes/2026-06-15-how-to-guide-template-best-practices/reviews/proposal-review.md`
- Spec: `specs/how-to-guide-template-best-practices.md`
- Spec review: `docs/changes/2026-06-15-how-to-guide-template-best-practices/reviews/spec-review.md`
- Spec review resolution: `docs/changes/2026-06-15-how-to-guide-template-best-practices/reviews/spec-review-resolution.md`
- Test spec: `specs/how-to-guide-template-best-practices.test.md`
- Plan: `docs/plans/2026-06-15-how-to-guide-template-best-practices.md`
- Architecture / ADRs: not required; this change is Markdown documentation structure, guide evidence, and local static validation only.
- Explain change: `docs/changes/2026-06-15-how-to-guide-template-best-practices/explain-change.md`
- Verify report: `docs/changes/2026-06-15-how-to-guide-template-best-practices/verify-report.md`

## What Changed

- `docs/templates/how-to-guide.md`: canonical two-speed guide template with required metadata, conditional state-changing modules, explicit command context, expected results, rollback, and troubleshooting routing.
- `docs/guides/proxy-setup.md`: backup cue before the fast-path `.wslconfig` edit.
- `docs/guides/03-ubuntu-baseline.md`: converted into the portability pilot while preserving existing Ubuntu baseline command semantics and broad-smoke semantic cues.
- `tests/markdown/how-to-guide-template-best-practices.test.sh`: static proof for template, guide, evidence, troubleshooting links/anchors, backup coverage, no-command-execution, security, and accepted-proposal guardrails.
- `tests/markdown/m1-project-entrypoint.test.sh`: broad smoke now accepts the converted two-speed Ubuntu pilot while retaining old section checks for the remaining numbered setup guides.
- Change-local artifacts: proposal/spec/test-spec/reviews/plan/explanation/verification/PR handoff records.

## Tests and Verification

- [x] `bash -n tests/markdown/how-to-guide-template-best-practices.test.sh && bash tests/markdown/how-to-guide-template-best-practices.test.sh` - passed.
- [x] `rg -n 'status: accepted|^## Status$|^accepted$' docs/proposals/2026-06-15-how-to-guide-template-best-practices.md` - passed.
- [x] `git diff --check && git diff main...HEAD --check` - passed before verification-stage edits.
- [x] `bash tests/markdown/m3-ubuntu-baseline.test.sh` - initially failed on semantic-cue drift, then passed after restoring the guide cues.
- [x] `bash -c 'set -euo pipefail; for test_script in tests/markdown/*.test.sh; do echo "== $test_script"; bash "$test_script"; done'` - initially failed on broad-smoke drift, then passed after verification-stage fixes.
- [x] `git diff --check` - passed after verification-stage fixes.
- [ ] Hosted CI - not available or not observed; no GitHub Actions workflow is present under `.github/`.

## Requirement Coverage

| Requirement area | Evidence |
| --- | --- |
| R1-R21 template core and guide-shape contract | `docs/templates/how-to-guide.md`; proof script; M1 code review |
| R22-R29 command-block and security-sensitive example conventions | Template conventions; proof script guardrails |
| R30-R39 published guide conformance, safety, backup, rollback, and troubleshooting boundaries | `proxy-setup.md`, `03-ubuntu-baseline.md`; proof script; full Markdown/static suite |
| R40-R45 reference exemplar and portability pilot evidence | `exemplar-review.md`, `portability-pilot-review.md`; M2 code review |
| R46-R51 static validation and no-command-execution boundary | `how-to-guide-template-best-practices.test.sh`; M3 code review |
| R52-R54 compatibility, command-semantics boundary, and pilot path preservation | `03-ubuntu-baseline.md`; broad-smoke verification; `m1-project-entrypoint.test.sh` |
| AC1-AC14 | `verify-report.md` traceability table and full Markdown/static suite |

## Review Resolution Summary

- Accepted: 0 code-review findings
- Rejected: 0
- Deferred: 0
- Partially accepted: 0
- Needs decision: 0
- Review-resolution: not required for code-review findings

Spec-review finding HGT-SR-001 was addressed before implementation in `docs/changes/2026-06-15-how-to-guide-template-best-practices/reviews/spec-review-resolution.md`.

## Risks and Rollback

- Static checks validate Markdown structure, links, evidence, and guardrails; they do not execute setup commands or prove live Windows 11 + WSL behavior.
- The portability pilot evidence is dry-run documentation review, not execution on a live Windows + WSL machine.
- Rollback can revert the template, Ubuntu pilot conversion, proxy backup cue, proof script, and change-local artifacts from this branch. No runtime scripts, generated files, migrations, or machine-changing automation were added.

## Reviewer Notes

- Focus review on whether the template is strong enough without making simple guides too heavy.
- Check that `03-ubuntu-baseline.md` preserved setup semantics while adopting the two-speed structure.
- The proof script intentionally stays local/static and avoids command execution by design.
- No hosted CI is present; all verification evidence is local.

## Follow-Ups

- Convert more guides only after this template shape remains acceptable in review.
- Propose command-execution validation later only after command contracts and Windows + WSL runner assumptions are settled.
