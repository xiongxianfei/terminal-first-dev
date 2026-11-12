## Result

- Skill: proposal-review
- Review status: blocked
- Material findings: PRR-001
- Recording status: recorded
- Recording blocker: none
- Review record: `docs/changes/2026-06-17-review-artifact-routing/reviews/proposal-review-r1.md`
- Review log: `docs/changes/2026-06-17-review-artifact-routing/review-log.md`
- Review resolution: `docs/changes/2026-06-17-review-artifact-routing/reviews/proposal-review-resolution.md`
- Open blockers: no proposal artifact exists for the workflow artifact-location change
- Immediate next stage: isolated stop; create a proposal for the review-artifact routing policy before relying on this direction downstream

## Material Findings

## Finding PRR-001

- Finding ID: PRR-001
- Severity: blocking
- Location: `docs/workflows.md:61`
- Evidence: `docs/workflows.md` now changes proposal, spec, architecture, and plan review locations to `docs/changes/<change-id>/reviews/...`, and adds the policy that all review records live under `docs/changes/<change-id>/`. No matching proposal artifact exists under `docs/proposals/` for the review-artifact routing policy change.
- Required outcome: Create or identify a proposal that records the problem, options, recommendation, scope, rollout, migration impact, and risks for moving all review records under `docs/changes/<change-id>/` before this proposal-review gate can approve the direction.
- Safe resolution path: Author a proposal such as `docs/proposals/2026-06-17-review-artifact-routing.md`, then re-run proposal-review against that proposal. The proposal should cover early lifecycle change-pack creation, legacy review migration, naming conventions, review-log expectations, and whether historical learn records should remain as prior-state evidence or be revised.
- needs-decision rationale: none

## Review Dimensions

- Problem clarity: block. The workflow edit implies a problem with scattered review artifacts, but no proposal states the problem or why the new policy is the right fix.
- User value: concern. Centralizing reviews under change packs may improve traceability, but the proposal-stage value and migration cost are not captured in a proposal.
- Option diversity: block. No proposal compares alternatives such as keeping early reviews beside source artifacts, mirroring into change packs after planning, or making change packs mandatory from proposal review onward.
- Decision rationale: block. The decision came from owner direction in chat and a workflow edit, not a durable proposal rationale.
- Scope control: concern. The change affected proposal, spec, architecture, plan, legacy references, and migrated records; no proposal non-goals constrain future behavior.
- Architecture awareness: concern. The change alters workflow artifact topology and lifecycle evidence boundaries, but no proposal records those boundaries.
- Testability: concern. Some path scans were run, but a proposal should define the expected validation checks for artifact placement and stale references.
- Risk honesty: block. Risks such as premature change-pack creation, historical artifact churn, broken links, old skill guidance drift, and review-log semantics are not recorded in a proposal.
- Rollout realism: concern. Existing review files were migrated, but a proposal should define rollout and rollback expectations for legacy artifacts.
- Readiness for spec: block. Not ready for downstream spec or implementation reliance until a proposal exists and is reviewed.

## Scope Preservation Review

- Scope-preservation result: blocked. The initial user goal, "all the review file should be generate under docs/changes," is visible in the workflow edit, but there is no proposal with `Initial intent preservation` to classify it and record rejected/deferred alternatives.

## Recommended Proposal Edits

- Recommended edits:
  - Create a proposal for review-artifact routing before relying on the workflow policy change.
  - Include `Vision fit`; this is workflow-governance behavior, not Windows setup guidance, so the proposal should explain why it fits repository governance.
  - Include options covering at least: keep current source-adjacent reviews, move all reviews to `docs/changes`, and hybrid/mirroring behavior.
  - Include a scope budget for migrating existing proposal, spec, architecture, plan, and code review records.
  - Include rollout and rollback for path rewrites and legacy links.
  - Include a testing strategy that checks no review records remain under old source-adjacent paths and no stale links point to them.

## Recommendation

- Recommendation: blocked. The review-artifact routing direction may be valid, but `proposal-review` cannot approve it because the required proposal artifact is missing. No automatic downstream handoff. The smallest next step is to author `docs/proposals/2026-06-17-review-artifact-routing.md` and then re-run proposal-review.
