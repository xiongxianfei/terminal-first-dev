# PR Handoff: Two-Speed How-To Guide Structure

## Title

Adopt two-speed how-to guide structure

## PR Open Status

- Status: merged.
- URL: https://github.com/xiongxianfei/terminal-first-windows-dev/pull/2
- Merged at: 2026-06-15T17:17:29Z
- Merge commit: `0a49d6262c98efa36ab88c452ea9bcf48dd807c4`
- Local branch: `feature/guides-two-speed-how-to-structure`
- Base branch: `main`
- Blocker: none.

## Summary

- Add a reader-intent guide router and contributor how-to template.
- Add `proxy-setup.md` as the first two-speed task guide with inline troubleshooting links and pilot evidence.
- Add a lightweight static Markdown proof script for guide structure, links, migration discoverability, pilot evidence, and no-command-execution guardrails.

## Why

- Readers need guides that help them complete one task quickly without scrolling through tutorial, troubleshooting, and design-rationale content.
- Contributors need a reusable structure that keeps fast paths, walkthroughs, verification, and troubleshooting links consistent.
- The project should preserve the documentation-first posture and avoid hidden setup automation.

## Spec / Plan / Architecture

- Proposal: `docs/proposals/2026-06-07-guides-two-speed-how-to-structure.md`
- Proposal review: `docs/changes/2026-06-07-guides-two-speed-how-to-structure/reviews/proposal-review.md`
- Spec: `specs/guides-two-speed-how-to-structure.md`
- Spec review: `docs/changes/2026-06-07-guides-two-speed-how-to-structure/reviews/spec-review.md`
- Test spec: `specs/guides-two-speed-how-to-structure.test.md`
- Plan: `docs/plans/2026-06-07-guides-two-speed-how-to-structure.md`
- Architecture: not required; this change is documentation structure plus local static validation.
- Explain change: `docs/changes/2026-06-07-guides-two-speed-how-to-structure/explain-change.md`
- Verify report: `docs/changes/2026-06-07-guides-two-speed-how-to-structure/verify-report.md`

## What Changed

- `docs/guides/README.md`: reader-intent router for current numbered guides and planned task-scoped guides.
- `docs/templates/how-to-guide.md`: reusable contributor-facing two-speed guide template.
- `docs/guides/proxy-setup.md`: proxy pilot guide with fast path, walkthrough, rollback, and troubleshooting links.
- `docs/changes/2026-06-07-guides-two-speed-how-to-structure/pilot-review.md`: manual pilot benefit evidence.
- `tests/markdown/guides-two-speed-how-to-structure.test.sh`: static proof for guide structure and link boundaries.
- `tests/markdown/m1-project-entrypoint.test.sh`: scoped legacy setup-guide checks to numbered setup guides so router/task guides are validated by their own checks.
- Change-local review, explanation, verification, and plan metadata were updated.

## Tests And Verification

- [x] `bash tests/markdown/guides-two-speed-how-to-structure.test.sh` - passed.
- [x] `bash tests/markdown/m1-project-entrypoint.test.sh` - initially failed on stale guide glob, then passed after scoping to numbered guides.
- [x] `bash -c 'set -euo pipefail; for test_script in tests/markdown/*.test.sh; do echo "== $test_script"; bash "$test_script"; done'` - passed.
- [x] `git diff --check -- ...` - passed for final verification paths.
- [x] ASCII scan with `LC_ALL=C rg -n "[^\\x00-\\x7F]" ...` - returned no matches.
- [ ] Hosted CI - not available or not observed; no GitHub Actions workflow is present.

## Requirement Coverage

| Requirement area | Evidence |
| --- | --- |
| R1-R8, R41-R42 router and migration | `docs/guides/README.md`; M1 review; static proof script |
| R9-R11 template placement and structure | `docs/templates/how-to-guide.md`; M1 review; static proof script |
| R12-R28, R40 proxy pilot and troubleshooting boundary | `docs/guides/proxy-setup.md`; M2 review; static proof script |
| R29-R32 pilot benefit evidence | `pilot-review.md`; M2 review |
| R33-R36 validation and CI boundary | `tests/markdown/guides-two-speed-how-to-structure.test.sh`; M3 review |
| AC1-AC12 | `verify-report.md` traceability table and full Markdown test suite |

## Review Resolution Summary

- Accepted: 0 implementation review findings
- Rejected: 0
- Deferred: 0
- Partially accepted: 0
- Needs decision: 0
- Review resolution: not required for code-review findings

Earlier plan-review finding PR-001 was resolved before implementation and approved by plan-review R2.

## Risks And Rollback

- Static checks validate Markdown shape and links; they do not execute setup commands or prove real Windows/WSL/proxy behavior.
- The proxy pilot was manually walked through as documentation, not executed in a live enterprise proxy environment.
- Rollback can remove `docs/guides/proxy-setup.md`, `docs/templates/how-to-guide.md`, the router update, and the new guide-structure proof script while keeping existing numbered setup guides.

## Reviewer Notes

- The proof script intentionally checks stable guide structure and troubleshooting anchors only.
- Command-execution CI is explicitly out of scope for this slice.
- `docs/guides/README.md` now acts as the compatibility path for existing numbered guides while task-scoped guides are introduced.

## Follow-Ups

- Convert more task-scoped guides only after the proxy pilot pattern remains acceptable.
- Propose command-execution validation later only after command specs and a Windows + WSL runner environment stabilize.
