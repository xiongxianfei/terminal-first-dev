# Learn Session: Proposal Review Location

## Result

- Skill: learn
- Status: recorded; superseded by later workflow update
- Artifacts changed:
  - `docs/learn/sessions/2026-06-17-proposal-review-location.md`
- Open blockers: none
- Next stage: none by default
- Session path: `docs/learn/sessions/2026-06-17-proposal-review-location.md`
- Lessons captured: none; owner changed workflow routing after this observation
- Follow-ups: workflow artifact-location map updated in `docs/workflows.md`

## Frame

- Trigger: Maintainer question after recording `docs/changes/2026-06-17-macbook-setup-best-practices/reviews/proposal-review.md`: "why don't we generate the review file under docs/changes?"
- Trigger type: explicit maintainer/contributor observation.
- Scope: placement of proposal review records versus change-pack review records.
- Evidence in scope:
  - `docs/workflows.md`
  - `CONSTITUTION.md`
  - `docs/proposals/2026-06-17-macbook-setup-best-practices.md`
  - `docs/changes/2026-06-17-macbook-setup-best-practices/reviews/proposal-review.md`
  - `docs/learn/sessions/2026-05-24-review-record-location-ambiguity.md`
  - `docs/learn/sessions/2026-05-24-change-plan-placement-strategy.md`
- Explicit exclusions:
  - No workflow policy change in this learn session; a later workflow update changed the artifact-location map.
  - No skill behavior change.
  - No relocation of existing proposal review artifacts.
  - No claim of implementation, verification, branch, or PR readiness.
- Prior learnings reviewed:
  - `docs/learn/sessions/2026-05-24-review-record-location-ambiguity.md`
  - `docs/learn/sessions/2026-05-24-change-plan-placement-strategy.md`
- Session record path: `docs/learn/sessions/2026-06-17-proposal-review-location.md`

## Observe

O1. At the time of this learn observation, the workflow artifact map placed proposal reviews beside proposals.

Evidence:

- `docs/workflows.md` mapped proposal review to a proposal-side review artifact.
- The MacBook proposal review originally followed that map before relocation. It now lives at `docs/changes/2026-06-17-macbook-setup-best-practices/reviews/proposal-review.md`.

O2. `docs/changes/<change-id>/` is the per-change execution pack, not the default home for proposal-stage reviews.

Evidence:

- `docs/workflows.md` maps change plan, change metadata, code review, review resolution, explanation, verification, and PR handoff under `docs/changes/<change-id>/`.
- `docs/workflows.md` specifically maps code review to `docs/changes/<change-id>/review-log.md`.
- `CONSTITUTION.md` describes execution plans under `docs/changes/<change-id>/` as implementation-order artifacts for approved changes.

O3. The MacBook work is still proposal-stage and has no implementation change pack.

Evidence:

- The proposal readiness says it is ready for a macOS companion spec if the owner accepts a separate companion repository, and not ready for implementation planning.
- No `docs/changes/<change-id>/` pack exists for this MacBook proposal in the current worktree.

O4. This ambiguity was already captured in a prior learn session.

Evidence:

- `docs/learn/sessions/2026-05-24-review-record-location-ambiguity.md` recorded the same question class: why early lifecycle review findings are not recorded under `docs/changes/`.
- That session concluded that current behavior follows the project-local workflow guide, and changing it would be workflow policy work.

## Classify

| Observation ID | Proposed primary classification | Final primary classification | Secondary routes | Confirmed by | Rationale |
|---|---|---|---|---|---|
| O1 | observation | observation | none | evidence only | The proposal review file followed the artifact map that existed at the time. |
| O2 | observation | observation | none | evidence only | The change-pack directory is reserved for execution-stage artifacts and code-review logs. |
| O3 | observation | observation | none | evidence only | There is no implementation change pack to attach this proposal review to. |
| O4 | no-durable-lesson | no-durable-lesson | none | existing prior session | The same ambiguity was already captured, and the workflow rule is already explicit. |

## Route

- O1-O3 are recorded in this session only.
- O4 is recorded as `no-durable-lesson`.
- No topic file was created because this does not add new contributor-confirmed durable guidance.
- No workflow artifact was changed during the learn session because `docs/workflows.md` already mapped proposal review records to proposal-side review artifacts at that time.

## Original Answer Superseded

The original answer was: do not generate this review file under `docs/changes/` because it is a proposal review, not a code review or implementation change-pack review.

The project workflow map separates early lifecycle artifacts from implementation change-pack artifacts:

- Proposal: `docs/proposals/YYYY-MM-DD-slug.md`
- Proposal review: proposal-side review artifact before the later workflow update
- Change plan and implementation evidence: `docs/changes/<change-id>/...`
- Code review: `docs/changes/<change-id>/review-log.md`

That separation matters because a proposal review can happen before there is an approved implementation change, before a change ID exists, and before there is any `docs/changes/<change-id>/` directory. In this MacBook case, the proposal is accepted as direction but explicitly says the next useful artifact is a macOS companion spec, not implementation planning. Creating a `docs/changes/` pack now would imply an execution slice exists when it does not.

This answer is superseded. The project later decided that all review files should be generated under `docs/changes/`, and that policy now lives in `docs/workflows.md`.

## Subsequent Workflow Update

After this learn session, the owner directed that all review files should be generated under `docs/changes/`. The workflow artifact-location map was updated in `docs/workflows.md`, and the MacBook proposal review was relocated to `docs/changes/2026-06-17-macbook-setup-best-practices/reviews/proposal-review.md`.

This session remains useful as the evidence record for the ambiguity that led to the workflow update, but it is no longer the current routing answer.

## No-Learn Rationale

No durable lesson was captured by this learn session itself. The later path change is workflow-policy work owned by `docs/workflows.md`, not durable guidance owned by `docs/learn/topics/`.

## Follow-ups

- Completed follow-up: `docs/workflows.md` now routes review records under `docs/changes/<change-id>/`.

## Validation

- Reviewed artifact placement with `rg` against `docs/workflows.md`, `CONSTITUTION.md`, the MacBook proposal, and the MacBook proposal review.
- Reviewed prior learn sessions for existing coverage.
