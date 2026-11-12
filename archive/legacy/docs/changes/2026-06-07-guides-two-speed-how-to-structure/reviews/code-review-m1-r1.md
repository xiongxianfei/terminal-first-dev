# Code Review M1 R1: Two-Speed How-To Guide Structure

## Result

- Skill: code-review
- Status: completed
- Artifacts changed: `docs/changes/2026-06-07-guides-two-speed-how-to-structure/reviews/code-review-m1-r1.md`, `docs/changes/2026-06-07-guides-two-speed-how-to-structure/review-log.md`, `docs/plans/2026-06-07-guides-two-speed-how-to-structure.md`, `docs/changes/2026-06-07-guides-two-speed-how-to-structure/change.yaml`, `docs/plan.md`
- Open blockers: none
- Next stage: implement M2
- Review status: clean-with-notes
- Material findings: none
- Recording status: recorded
- Recording blocker: none
- Review record: `docs/changes/2026-06-07-guides-two-speed-how-to-structure/reviews/code-review-m1-r1.md`
- Review log: `docs/changes/2026-06-07-guides-two-speed-how-to-structure/review-log.md`
- Review resolution: not-required
- Reviewed milestone: M1
- Milestone closeout: closed
- Remaining implementation milestones: M2, M3
- Required review-resolution: no
- Finding IDs: none
- Verify readiness: not-claimed

## Review Inputs

- Diff/review surface: commit `b8f6118` (`M1: add guide router and how-to template`).
- Tracked governing branch state: commit `b8f6118` includes the proposal, proposal review, spec, spec review, test spec, plan, review log, M1 router, M1 template, and change metadata.
- Governing artifacts: `specs/guides-two-speed-how-to-structure.md`, `specs/guides-two-speed-how-to-structure.test.md`, `docs/plans/2026-06-07-guides-two-speed-how-to-structure.md`, `CONSTITUTION.md`, `VISION.md`, and `AGENTS.md`.
- Validation evidence: M1 implementation validation recorded in the plan, plus reviewer rerun of the M1 file, heading, discoverability, whitespace, and clean-status checks.

## Diff Summary

M1 adds `docs/guides/README.md` as a reader-intent router and `docs/templates/how-to-guide.md` as the contributor how-to template. The router preserves current numbered guide discoverability, names planned task-scoped guides, keeps troubleshooting separate, and links contributors to the template. The template encodes the required two-speed structure, top metadata, rollback, troubleshooting, and review checklist. The commit also records the upstream proposal/spec/test-spec/plan lifecycle artifacts needed for tracked review authority.

## Findings

No blocking or required-change findings.

## Checklist Coverage

| Check | Result | Evidence |
| --- | --- | --- |
| Spec alignment | pass | `docs/guides/README.md` satisfies R1-R8, R41-R42 by routing by reader intent, preserving existing numbered guide links, listing planned unnumbered task targets, and keeping troubleshooting as a separate mode. `docs/templates/how-to-guide.md` satisfies R9-R11 by living under `docs/templates/` and including metadata, `Fast path`, `Walkthrough`, rollback, and troubleshooting sections. |
| Test coverage | pass | Reviewer reran the M1 proof commands from the plan and test spec: file existence, required template terms/headings, numbered guide discoverability, and whitespace checks all passed. |
| Edge cases | pass | Existing numbered guide paths remain linked from the router, planned task-scoped names are unnumbered, optional `uv` handling is recorded, and no contributor template was placed under `docs/guides/`. |
| Error handling | pass | This documentation-only slice does not introduce runtime error paths. The router sends failures to troubleshooting docs, and the template requires step-local expected results and targeted troubleshooting links. |
| Architecture boundaries | pass | The slice stays within documentation information architecture; no setup command contracts, scripts, generated docs, or installer behavior changed. |
| Compatibility | pass | Current numbered guide files remain present and discoverable from `docs/guides/README.md`; the router explicitly describes the migration state. |
| Security/privacy | pass | No secrets, credentials, proxy hostnames, or machine-specific values were added. The template asks security-sensitive commands to call out impact near the command. |
| Derived artifact currency | pass | No generated artifacts are involved. Change metadata, plan index, plan, and review log are manually synchronized for M1 handoff. |
| Unrelated changes | pass | The reviewed commit surface is limited to this change's lifecycle artifacts plus the M1 router/template files and project plan index. |
| Validation evidence | pass | `test -f` checks, `rg` structure checks, `git diff HEAD^..HEAD --check`, and `git status --short` were run during review; all relevant commands exited cleanly. |

## No-Finding Rationale

The M1 contract is narrow: establish the router/template foundation, keep current numbered guide content discoverable, avoid template placement under `docs/guides/`, and avoid command-contract or automation changes. The actual diff implements those surfaces directly, and the reviewer reran targeted checks that prove the named M1 artifacts and required structure exist. The router is intent-oriented rather than only a flat file list, and the template is contributor-facing meta content outside the reader guide directory.

## Residual Risks

- The router and template still need to be tested against real guide conversion pressure in M2.
- Link and anchor automation is intentionally deferred to M3, so this review only checked the M1-introduced links needed for discoverability.

## Milestone Handoff State

- Reviewed milestone: M1
- Review status: clean-with-notes
- Milestone state after review: closed
- Required review-resolution: no
- Remaining in-scope implementation milestones: M2, M3
- Next stage: implement M2
- Final closeout readiness: not ready because M2 and M3 remain open, and final verify/PR handoff have not run.
