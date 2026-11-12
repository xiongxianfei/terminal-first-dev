# Learn Session: Change Plan Placement Strategy

## Current Status

Superseded by the 2026-06-17 workflow routing update that moved detailed plan bodies to `docs/plans/<change-id>.md`.

This session remains historical evidence for the earlier placement rationale. The current authoritative rule lives in `docs/workflows.md`.

## Frame

- Trigger: Maintainer question after PR handoff: "Our project has already created workflows.md. But we generate plan.md under docs/changes. Why do we use this strategy?"
- Trigger type: explicit maintainer/contributor observation.
- Scope: relationship between `docs/workflows.md`, `docs/plan.md`, and per-change plans under `docs/changes/<change-id>/plan.md`.
- Evidence in scope:
  - `docs/workflows.md`
  - `docs/plan.md`
  - `docs/plans/2026-05-24-terminal-first-workstation-setup.md`
  - `docs/changes/2026-05-24-terminal-first-workstation-setup/change.yaml`
  - prior learn session `docs/learn/sessions/2026-05-24-review-record-location-ambiguity.md`
- Explicit exclusions: no workflow-policy update, skill update, ADR, or PR-readiness claim is made by this learn session.
- Prior learnings reviewed: `docs/learn/sessions/2026-05-24-review-record-location-ambiguity.md`.
- Session record path: `docs/learn/sessions/2026-05-24-change-plan-placement-strategy.md`

## Observe

O1. `docs/workflows.md` is the repository-wide workflow map, not the execution plan for a specific change.

Evidence:

- `docs/workflows.md` says it maps standard workflow stages to artifact locations and does not replace owning stage skills.
- The artifact map identifies `docs/workflows.md` as the workflow guide.
- The same map identifies the change plan path as `docs/changes/<change-id>/plan.md`.

O2. `docs/plan.md` is a small active-plan index, not the detailed plan body.

Evidence:

- `docs/plan.md` lists the active change, its plan path, state, next stage, and active context.
- It points to `docs/plans/2026-05-24-terminal-first-workstation-setup.md` for the concrete plan.

O3. The per-change plan under the then-current `docs/changes/<change-id>/plan.md` location contained mutable execution state that would not belong in the global workflow guide.

Evidence:

- The change plan includes the current handoff summary, milestone states, validation plan, progress log, decision log, discoveries, validation notes, outcome, and readiness.
- The plan decision log recorded: "Put the active execution plan under `docs/changes/2026-05-24-terminal-first-workstation-setup/plan.md`" because it matched the workflow guide's change-plan location at the time.

O4. At the time, keeping detailed plans under `docs/changes/<change-id>/` kept all change-specific lifecycle evidence together.

Evidence:

- The same change directory contains `change.yaml`, `plan.md`, `review-log.md`, `review-resolution.md`, and `explain-change.md`.
- This matches the workflow map entries for change metadata, code review, review resolution, explanation, verification, and PR handoff.

## Classify

| Observation ID | Proposed primary classification | Final primary classification | Secondary routes | Confirmed by | Rationale |
| --- | --- | --- | --- | --- | --- |
| O1 | observation | observation | none | evidence only | The workflow guide already defines itself as a routing map and points change plans elsewhere. |
| O2 | observation | observation | none | evidence only | The plan index exists to locate active work, not to store detailed milestone state. |
| O3 | observation | observation | none | evidence only | The concrete change plan contains volatile per-change execution details that should not be mixed into the stable workflow guide. |
| O4 | observation | observation | none | evidence only | The current change pack demonstrates the intended locality of plan, review, resolution, explanation, and metadata. |

## Route

- O1-O4 are recorded in this session only.
- No topic file was created because this session explains existing workflow structure rather than capturing a new contributor-confirmed durable lesson.
- No workflow artifact was changed because the current artifact placement already matches `docs/workflows.md`.

## Answer

We use three separate surfaces because they have different stability and scope:

- `docs/workflows.md` is the stable workflow contract and artifact map. It tells contributors where artifacts belong and how stages connect.
- `docs/plan.md` is a small index of active work. It lets contributors find the current change without scanning every change directory.
- `docs/changes/<change-id>/plan.md` is the detailed execution plan for one change. It records milestone sequencing, validation commands, progress, review handoffs, decisions, risks, discoveries, and readiness.

Putting the detailed plan under `docs/changes/<change-id>/` keeps volatile, change-specific execution evidence close to the rest of that change's lifecycle artifacts. Putting that detail into `docs/workflows.md` would make the global workflow guide noisy and unstable; putting every detail into `docs/plan.md` would turn the active index into a large mutable plan body.

## No-Learn Rationale

This session captured a useful clarification, but not a new durable lesson. The current strategy is already encoded in `docs/workflows.md` and demonstrated by the active change pack.

This rationale is now historical. The workflow later changed the current strategy to store plan bodies under `docs/plans/`.

## Follow-ups

No follow-up artifact is required.
