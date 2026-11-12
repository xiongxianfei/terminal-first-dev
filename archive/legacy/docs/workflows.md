# Project Workflow Guide

## Purpose

This guide maps the standard workflow to this repository's artifact locations. It does not replace the owning stage skills; it tells contributors and agents where durable workflow artifacts belong and how to route work safely.

## Source Of Truth

Follow this order when artifacts disagree:

1. `CONSTITUTION.md`
2. `VISION.md`
3. Accepted specs under `specs/`
4. Architecture docs under `docs/architecture/`
5. Change plans under `docs/plans/`
6. Tests, checks, review evidence, and verification evidence
7. Code, scripts, and documentation
8. Chat context

Stop and resolve conflicts before moving downstream.

## Standard Lifecycle

Use the standard workflow for non-trivial product changes:

```text
explore when needed
research when current external evidence is needed
proposal
proposal-review
spec
spec-review
architecture when triggered
architecture-review when triggered
plan
plan-review
test-spec
implement
code-review
review-resolution when triggered
ci-maintenance when triggered
explain-change
verify
pr
learn when triggered
```

Manual single-skill invocation is allowed, but it stays isolated unless the owner explicitly asks to continue through the full workflow.

## Artifact Locations

| Stage or artifact | Default path |
| --- | --- |
| Agent guide | `AGENTS.md` |
| Constitution | `CONSTITUTION.md` |
| Vision | `VISION.md` |
| Project map | `docs/project-map.md` |
| Workflow guide | `docs/workflows.md` |
| Exploration | `docs/proposals/YYYY-MM-DD-slug.explore.md` |
| Proposal | `docs/proposals/YYYY-MM-DD-slug.md` |
| Proposal review | `docs/changes/<change-id>/reviews/proposal-review.md` |
| Proposal review resolution | `docs/changes/<change-id>/reviews/proposal-review-resolution.md` |
| Spec | `specs/slug.md` |
| Spec review | `docs/changes/<change-id>/reviews/spec-review.md` |
| Spec review resolution | `docs/changes/<change-id>/reviews/spec-review-resolution.md` |
| Test spec | `specs/slug.test.md` |
| Canonical architecture package | `docs/architecture/system/architecture.md` |
| Architecture diagrams | `docs/architecture/system/diagrams/` |
| Architecture review record | `docs/changes/<change-id>/reviews/architecture-review.md` |
| Architecture review resolution | `docs/changes/<change-id>/reviews/architecture-review-resolution.md` |
| ADR | `docs/adr/YYYY-MM-DD-slug.md` |
| Change plan | `docs/plans/<change-id>.md` |
| Change metadata | `docs/changes/<change-id>/change.yaml` |
| Plan review | `docs/changes/<change-id>/reviews/plan-review.md` |
| Plan review resolution | `docs/changes/<change-id>/reviews/plan-review-resolution.md` |
| Code review | `docs/changes/<change-id>/review-log.md` |
| Review resolution | `docs/changes/<change-id>/review-resolution.md` |
| Explanation | `docs/changes/<change-id>/explain-change.md` |
| Verification | `docs/changes/<change-id>/verify-report.md` |
| PR handoff | `docs/changes/<change-id>/pr.md` |
| Learnings | `docs/learnings/YYYY-MM-DD-slug.md` |
| Follow-ups | `docs/follow-ups.md` |

Plan bodies live under `docs/plans/`; change-local reviews, metadata, resolutions, explanations, verification reports, and PR handoffs live under `docs/changes/<change-id>/`.

All review records live under `docs/changes/<change-id>/`. For early lifecycle stages such as proposal review or spec review, create the change pack as soon as the review record is needed, even if the implementation plan does not exist yet. The early change pack records lifecycle evidence; it does not imply implementation is allowed.

## Current Workflow State

The repository is at project genesis.

Completed standing and reference artifacts:

- `VISION.md`
- `docs/vision/strategic-positioning.md`
- `CONSTITUTION.md`
- `AGENTS.md`
- `docs/project-map.md`
- `docs/proposals/2026-05-24-first-version-direction.explore.md`

Current stage:

- Exploration has produced options for first-version direction.

Next valid stage:

- `proposal`, if the owner accepts the recommended staged direction of README orientation followed by a concise manual setup guide.
- `research`, if current Windows 11 tooling recommendations must be verified before selecting proposal details.

Implementation is not allowed yet for setup behavior, command defaults, scripts, or compatibility assumptions because no proposal, spec, plan, or test specification exists for that work.

## Routing Rules

- Use `explore` when the problem or product direction is unsettled.
- Use `research` when current external facts, platform behavior, dependency recommendations, pricing, laws, or safety guidance matter.
- Use `proposal` after the direction is selected but before requirements are frozen.
- Use `spec` before changing externally observable setup behavior, command sequences, package-manager defaults, terminal-stack assumptions, scripts, security posture, or compatibility claims.
- Use `architecture` before introducing scripts, generated configuration, data flow, machine-changing automation, or hard-to-reverse boundaries.
- Use `plan` for multi-file, risky, migration-heavy, or milestone-based implementation.
- Use `test-spec` before production implementation when requirements need traceable validation.
- Use `implement` only after the required upstream artifacts exist for the change risk.
- Generate review records under `docs/changes/<change-id>/`, including proposal, spec, architecture, plan, and code reviews.
- Use `code-review`, `explain-change`, `verify`, and `pr` only when there is an implementation diff and stage-owned evidence.
- Use `learn` when work reveals durable process lessons, recurring mistakes, or project rules that should guide future agents.

## Evidence Expectations

Every completion report should state:

- artifacts changed;
- checks or validation performed;
- checks that could not be run and why;
- remaining risks;
- next valid stage.

Do not claim implementation completion, review pass, verification pass, CI pass, branch readiness, or PR readiness without concrete evidence from the owning stage.

## Open Workflow Questions

- Should `.agents/skills/` remain committed as project workflow assets?
- What validation commands should become standard once Markdown, link, script, or CI tooling exists?
- What naming convention should be used for change IDs under `docs/changes/`?
