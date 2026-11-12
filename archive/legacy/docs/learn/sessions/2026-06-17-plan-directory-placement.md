# Learn Session: Plan Directory Placement

## Result

- Skill: learn
- Status: recorded; superseded by later workflow update
- Artifacts changed:
  - `docs/learn/sessions/2026-06-17-plan-directory-placement.md`
- Open blockers: none
- Next stage: none by default
- Session path: `docs/learn/sessions/2026-06-17-plan-directory-placement.md`
- Lessons captured: none; owner changed workflow routing after this observation
- Follow-ups: workflow artifact-location map updated in `docs/workflows.md`

## Frame

- Trigger: Maintainer question after creating `docs/plans/2026-06-17-macbook-setup-best-practices.md`: "why don't we generate plan.md under docs/plan/"
- Trigger type: explicit maintainer/contributor observation.
- Scope: whether detailed change plans belong under `docs/plan/`, `docs/plan.md`, or `docs/changes/<change-id>/plan.md`.
- Evidence in scope:
  - `CONSTITUTION.md`
  - `docs/workflows.md`
  - `docs/plan.md`
  - `docs/plans/2026-06-17-macbook-setup-best-practices.md`
  - `docs/changes/2026-06-17-macbook-setup-best-practices/change.yaml`
  - `docs/learn/sessions/2026-05-24-change-plan-placement-strategy.md`
  - `docs/learn/sessions/2026-06-17-proposal-review-location.md`
- Explicit exclusions:
  - No workflow policy change.
  - No relocation of existing plan artifacts.
  - No plan-review, verification, branch-readiness, or PR-readiness claim.
- Prior learnings reviewed:
  - `docs/learn/sessions/2026-05-24-change-plan-placement-strategy.md`
  - `docs/learn/sessions/2026-06-17-proposal-review-location.md`
- Session record path: `docs/learn/sessions/2026-06-17-plan-directory-placement.md`

## Observe

O1. The current workflow artifact map explicitly places change plans at `docs/changes/<change-id>/plan.md`.

Evidence:

- `docs/workflows.md` maps `Change plan` to `docs/changes/<change-id>/plan.md`.
- `docs/workflows.md` maps `Change metadata` to the same change pack at `docs/changes/<change-id>/change.yaml`.
- `docs/changes/2026-06-17-macbook-setup-best-practices/change.yaml` points to `plan: plan.md`, meaning the plan is local to the change pack.

O2. `docs/plan.md` is the global plan index, not a directory for detailed plan bodies.

Evidence:

- `docs/plan.md` contains compact rows with change ID, plan path, state, next stage, and active context.
- The MacBook setup row points to `docs/plans/2026-06-17-macbook-setup-best-practices.md`.

O3. The prior learn session already explains the strategy.

Evidence:

- `docs/learn/sessions/2026-05-24-change-plan-placement-strategy.md` records that `docs/workflows.md` is the stable workflow map, `docs/plan.md` is the active-plan index, and `docs/changes/<change-id>/plan.md` is the detailed execution plan for one change.

O4. A `docs/plan/` directory would be a workflow-policy change, not a learn-session output.

Evidence:

- `CONSTITUTION.md` ranks execution plans under `docs/changes/<change-id>/` as source-of-truth artifacts.
- `docs/workflows.md` is the artifact-location owner for workflow paths.
- The learn skill says maintainer-driven rule adoption without accumulated evidence should be routed to proposal or another authoritative artifact, not encoded as durable topic guidance.

## Classify

| Observation ID | Proposed primary classification | Final primary classification | Secondary routes | Confirmed by | Rationale |
| --- | --- | --- | --- | --- | --- |
| O1 | observation | observation | none | evidence only | The current workflow map already defines the location. |
| O2 | observation | observation | none | evidence only | The index role of `docs/plan.md` is demonstrated by the active plan index. |
| O3 | no-durable-lesson | no-durable-lesson | none | prior learn session | The same placement rationale was already recorded on 2026-05-24. |
| O4 | process-follow-up | no-durable-lesson | none | evidence only | No owner decision requested a path change; if desired later, it belongs in workflow/proposal work. |

## Route

- O1 and O2 are recorded in this session only.
- O3 and O4 are recorded as no new durable lesson.
- No topic file was created because the placement rule already lives in `docs/workflows.md` and the rationale already lives in the prior learn session.
- No workflow artifact was changed because the current behavior matches `docs/workflows.md`.

## Answer

This answer is superseded. The project owner later directed that detailed plans should be generated under `docs/plans/`, and that current policy now lives in `docs/workflows.md`.

## Original Answer

We do not generate detailed plans under `docs/plan/` because this repository uses:

- `docs/plan.md` as the small global index of active and recent plans.
- `docs/changes/<change-id>/plan.md` as the detailed execution plan for one change.
- `docs/changes/<change-id>/change.yaml` as the compact metadata pointer for that same change pack.

Keeping the detailed plan inside `docs/changes/<change-id>/` keeps the mutable plan, reviews, resolutions, verification evidence, explanation, and PR handoff together. A separate `docs/plan/` directory would split a change's lifecycle evidence across two locations while duplicating the role already assigned to `docs/changes/<change-id>/`.

If the owner wants to move detailed plans to `docs/plan/` or `docs/plans/`, that should be handled as workflow artifact-location work by updating `docs/workflows.md`, `CONSTITUTION.md` if needed, migration rules, and affected skill behavior. This learn session does not make that policy change.

## Subsequent Workflow Update

After this learn session, the owner directed that plans should be generated at `docs/plans/`. The workflow artifact-location map and source-of-truth references were updated, and existing plan bodies were migrated to `docs/plans/<change-id>.md`.

## No-Learn Rationale

No new durable lesson was captured. The current plan placement is already explicit in `docs/workflows.md` and previously explained in `docs/learn/sessions/2026-05-24-change-plan-placement-strategy.md`.

This rationale is now historical because the workflow policy changed after the session.

## Follow-ups

None.

## Validation

- Reviewed current artifact-location mapping with `rg` against `docs/workflows.md`, `docs/plan.md`, and the MacBook change metadata.
- Reviewed prior learn sessions for existing placement rationale.
