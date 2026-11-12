---
id: 2026-06-07-guides-two-speed-how-to-structure-review
proposal: docs/proposals/2026-06-07-guides-two-speed-how-to-structure.md
review_status: approved
created: 2026-06-07
repo: xiongxianfei/terminal-first-windows-dev
---

# Proposal Review: Two-Speed How-To Guide Structure

## Result

- Skill: proposal-review
- Review status: approved
- Material findings: none
- Recording status: recorded
- Recording blocker: none
- Review record: `docs/changes/2026-06-07-guides-two-speed-how-to-structure/reviews/proposal-review.md`
- Review log: `docs/changes/2026-06-07-guides-two-speed-how-to-structure/review-log.md`
- Review resolution: not-required
- Open blockers: none
- Immediate next stage: isolated stop

## Material Findings

None.

## Review Dimensions

| Dimension | Result | Notes |
| --- | --- | --- |
| Problem clarity | pass | The proposal now states the problem as preemptive structure for guide content about machine-sensitive setup topics, not as remediation of an already-failed guide. |
| User value | pass | The value is concrete: readers should configure quickly, verify early, and reach troubleshooting at likely failure points. |
| Option diversity | pass | The proposal compares a lightweight style-guide-only option, one large guide, unstructured task guides, two-speed task guides, and generated documentation. |
| Decision rationale | pass | The chosen direction follows the stated need for stable contributor-visible boundaries without jumping to generated docs or premature command-execution CI. |
| Scope control | pass | Non-goals and scope budget keep guide conversion, command definitions, broad proxy support, static-site tooling, and command execution tests from expanding the proposal. |
| Architecture awareness | pass | Documentation boundaries are explicit across guides, templates, troubleshooting, ADRs, architecture, specs, plans, and tests. |
| Testability | pass | The strategy covers structure checks, link checks, manual review questions, advisory command review, and a concrete pilot fast-path benefit check. |
| Risk honesty | pass | The proposal names drift, overlong fast paths, walkthrough tutorial creep, broken anchors, fragmentation, and risky task under-warning. |
| Rollout realism | pass | Rollout starts with the proposal, spec, router, template, and `proxy-setup.md` pilot before broader conversion and enforcement. |
| Readiness for spec | pass | Open questions have been resolved as owner decisions and are specific enough to carry into a guide-structure spec. |

## Scope Preservation Review

- Scope-preservation result: pass

Every visible initial goal is classified in the `Initial intent preservation` table with an allowed treatment value. The later owner decisions are also preserved: template location, unnumbered task filenames, advisory code-block validation, and proxy setup as the pilot conversion are all recorded in the proposal.

## Vision Fit Review

- Vision fit result: pass

The proposal uses the exact value `fits the current vision` as the first non-empty line of `Vision fit`. That is consistent with `VISION.md`, which favors concise, auditable, terminal-first Windows 11 setup guidance and refuses opaque automation.

## Scope Budget Review

- Scope-budget result: pass

The proposal is broad enough to warrant a scope budget, and the table is present. The classifications are coherent: guide policy, template placement, router, troubleshooting link policy, and task guide split are core; troubleshooting anchors are a same-slice dependency; `proxy-setup.md` conversion and documentation checks are first-slice candidates; full conversion and code-block execution tests are correctly deferred or split.

## Recommended Proposal Edits

- Normalize proposal front matter and `## Status` from `draft` to `accepted` if the owner accepts this approved review result.
- When authoring the spec, preserve the proposal's decision that command-execution CI is deferred until command specs, a Windows + WSL runner environment, and at least one advisory-missed regression justify the infrastructure.
- In the pilot, keep the scope focused on proving guide shape and cross-doc links; do not stall the pilot by trying to perfect the entire proxy troubleshooting taxonomy at the same time.

## Recommendation

- Recommendation: approved for spec authoring after owner acceptance/status normalization.

The proposal is ready to become the source for `specs/guides-two-speed-how-to-structure.md`. No automatic handoff to `spec` occurs from this review-only invocation.
