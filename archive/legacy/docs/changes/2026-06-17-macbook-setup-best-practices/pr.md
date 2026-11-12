# Pull Request: Review Artifact Routing and MacBook Companion Setup

## Result

- Skill: pr
- Status: merged
- Artifacts changed: `docs/changes/2026-06-17-macbook-setup-best-practices/pr.md`, `docs/changes/2026-06-17-macbook-setup-best-practices/change.yaml`, `docs/plan.md`, `docs/plans/2026-06-17-macbook-setup-best-practices.md`
- Open blockers: none
- Next stage: none
- Readiness: done
- Current repository PR: https://github.com/xiongxianfei/terminal-first-windows-dev/pull/5
- Current repository merge commit: `abd7998cb4e19e0e64f4c697993e310b2d7f3a74`
- Companion repository PR: https://github.com/xiongxianfei/terminal-first-macos-dev/pull/1
- Companion repository merge commit: `8d3521798dde9af1aec1d803591eda1fbacbf18f`

## PR Title

docs: route workflow artifacts and add MacBook companion setup plan

## Opened PRs

- Current repository: https://github.com/xiongxianfei/terminal-first-windows-dev/pull/5
- Companion repository: https://github.com/xiongxianfei/terminal-first-macos-dev/pull/1

Merge status:

- Current repository PR #5 merged at `abd7998cb4e19e0e64f4c697993e310b2d7f3a74`.
- Companion repository PR #1 merged at `8d3521798dde9af1aec1d803591eda1fbacbf18f`.

## PR Body

## Summary

- Route workflow review artifacts into `docs/changes/<change-id>/reviews/` and plans into `docs/plans/`.
- Add durable learnings for proposal-review and plan artifact placement.
- Add the MacBook setup best-practices proposal, spec, test spec, plan, review records, explanation, and verification report for the new macOS companion surface.
- Coordinate with the companion implementation PR: https://github.com/xiongxianfei/terminal-first-macos-dev/pull/1

## Why

- Prior workflow runs showed review files and plan files were being recorded in ambiguous locations.
- The MacBook setup request needs durable guidance, but the current repository remains Windows-first.
- The accepted direction is a separate macOS companion repository, with this repository holding lifecycle evidence and no macOS reader-facing guide content by default.

## Spec / plan / architecture

- Proposal: `docs/proposals/2026-06-17-macbook-setup-best-practices.md`
- Spec: `specs/macbook-setup-best-practices.md`
- Test spec: `specs/macbook-setup-best-practices.test.md`
- Architecture / ADRs: not required for the MacBook first slice because no Brewfiles, scripts, generated shell configuration, hidden dotfile bootstrap, or setup automation were added.
- Plan: `docs/plans/2026-06-17-macbook-setup-best-practices.md`
- Explanation: `docs/changes/2026-06-17-macbook-setup-best-practices/explain-change.md`
- Verification: `docs/changes/2026-06-17-macbook-setup-best-practices/verify-report.md`

## What changed

- Added `docs/workflows.md` guidance for workflow artifact locations.
- Moved/normalized existing review and plan artifacts under `docs/changes/` and `docs/plans/`.
- Added learning notes for review artifact and plan directory placement.
- Added the MacBook companion change pack under `docs/changes/2026-06-17-macbook-setup-best-practices/`.
- Added `specs/macbook-setup-best-practices.md` and `specs/macbook-setup-best-practices.test.md`.
- Added the MacBook plan under `docs/plans/`.
- Updated `docs/plan.md` so the MacBook change is branch-ready for PR handoff.

## Tests and verification

- [x] `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && bash tests/markdown/macbook-setup-best-practices.test.sh` - passed locally.
- [x] `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && git diff --check cdd8b2d..HEAD` - passed locally.
- [x] `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && git diff --check` - passed locally.
- [x] `cd /home/xiongxianfei/data/20260524-terminal-dev && git diff --check main...HEAD` - passed locally.
- [x] `cd /home/xiongxianfei/data/20260524-terminal-dev && git diff --check` - passed locally.
- [ ] Hosted CI - not configured or not observed.

## Requirement coverage

- R1-R3, R28 -> T-MAC-002/T-MAC-009 -> ownership context and managed-Mac routing in the companion guide/proof.
- R4-R6 -> T-MAC-003/T-MAC-010 -> Apple silicon target and Intel non-claim language.
- R7-R12 -> T-MAC-004/T-MAC-011 -> backup, Software Update, FileVault, Apple Account, admin, and Privacy & Security guidance.
- R13-R18 -> T-MAC-005/T-MAC-011 -> Apple developer tooling and Homebrew boundaries/source links.
- R19-R23, R27 -> T-MAC-006/T-MAC-009/T-MAC-012 -> shell, Git/SSH, editor, auditability, and follow-up routing.
- R24-R26, AC6 -> T-MAC-007/T-MAC-008/T-MAC-010 -> verification evidence and claim guards.
- R29, AC4 -> T-MAC-001/T-MAC-012 -> macOS content remains in the companion repo by default.

## Review resolution summary

- Accepted: 2
- Rejected: 0
- Deferred: 0
- Partially accepted: 0
- Needs decision: 0
- Review-resolution: `docs/changes/2026-06-17-macbook-setup-best-practices/review-resolution.md`

Closed findings:

- PR-001: companion-repo validation commands now name explicit workdirs.
- CR-M2-001: Apple/Homebrew source links and proof assertions were added.

## Risks and rollback

- Real Apple silicon walkthrough evidence is still required before verified command-success, setup-completion, or compatibility language can be published.
- Intel support remains unclaimed until separate Intel verification evidence exists.
- Managed/corporate Mac setup remains policy-dependent and outside the default first slice.
- Source URLs are statically asserted, not network-fetched, because no companion link-check command has been adopted.
- Rollback is documentation-only: revert this branch and the companion PR if the companion direction is not accepted.

## Reviewer notes

- Review this PR together with companion PR https://github.com/xiongxianfei/terminal-first-macos-dev/pull/1.
- This repository intentionally contains lifecycle artifacts for the MacBook work, not the reader-facing macOS setup guide.
- No hosted CI status is claimed.

## Follow-ups

- Complete a real Apple silicon MacBook walkthrough before publishing verified command-success or compatibility claims.
- Add Intel verification only if Intel support is intentionally claimed.
- Adopt a network link checker later if the companion repo standardizes one.
