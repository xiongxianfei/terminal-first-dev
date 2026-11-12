# Learn Session: ADR and Architecture Cooperation

## Frame

- Trigger: Maintainer question: "How should adr and architecture cooperate? What're the best practices?"
- Trigger type: explicit maintainer/contributor observation.
- Scope: relationship between ADRs and the canonical architecture package in this repository.
- Evidence in scope:
  - `CONSTITUTION.md`
  - `docs/workflows.md`
  - `docs/architecture/system/architecture.md`
  - `docs/adr/`
  - `docs/learn/sessions/2026-05-25-design-thinking-placement.md`
- Explicit exclusions: no workflow-policy update, architecture rewrite, ADR rewrite, or topic-file guidance is made by this learn session.
- Prior learnings reviewed:
  - `docs/learn/sessions/2026-05-25-design-thinking-placement.md`
  - `docs/learn/sessions/2026-05-24-change-plan-placement-strategy.md`
- Session record path: `docs/learn/sessions/2026-05-25-adr-architecture-cooperation.md`

## Observe

O1. The repository already treats architecture and ADRs as separate but linked design artifacts.

Evidence:

- `docs/workflows.md` maps the canonical architecture package to `docs/architecture/system/architecture.md`.
- `docs/workflows.md` maps ADRs to `docs/adr/YYYY-MM-DD-slug.md`.
- `docs/architecture/system/architecture.md` lists accepted ADRs in section 4 and section 9.

O2. Architecture carries the current system shape and boundaries; ADRs carry decision rationale.

Evidence:

- `CONSTITUTION.md` says architecture docs define durable design boundaries when the project adds scripts, generated assets, data flow, or automation.
- `docs/architecture/system/architecture.md` describes goals, constraints, building blocks, runtime flow, deployment view, risks, and links to ADRs.
- ADRs under `docs/adr/` each record context, decision, alternatives, consequences, and follow-up.

O3. Copying full ADR rationale into architecture would make architecture noisy and harder to keep current.

Evidence:

- The architecture package currently uses links to ADRs instead of duplicating their detailed decision text.
- The WSL certificate trust decision was captured in `docs/adr/2026-05-25-wsl-certificate-trust-policy.md` and linked from architecture.

## Classify

| Observation ID | Proposed primary classification | Final primary classification | Secondary routes | Confirmed by | Rationale |
| --- | --- | --- | --- | --- | --- |
| O1 | observation | observation | none | evidence only | The current artifact map already separates architecture and ADR locations. |
| O2 | observation | observation | none | evidence only | Existing constitution, architecture, and ADR content show different responsibilities. |
| O3 | observation | observation | none | evidence only | The current link-not-copy pattern is already used by the architecture package. |

## Route

- O1-O3 are recorded in this session only.
- No topic file was created because this is a single explicit clarification and the current repository already demonstrates the pattern.
- No architecture or workflow artifact was changed.

## Answer

Best practice: architecture shows the system; ADRs explain important decisions that shaped it.

Use architecture for:

- current system boundaries;
- major building blocks;
- runtime and deployment flow;
- cross-cutting constraints;
- risk overview;
- links to accepted ADRs.

Use ADRs for:

- one durable decision;
- context and problem;
- selected option;
- rejected alternatives;
- consequences;
- follow-up work;
- supersession history when the decision changes.

Cooperation rules:

1. Architecture should link accepted ADRs that materially shape the system.
2. Architecture should summarize only the effect of a decision, not copy the full ADR rationale.
3. ADRs should not describe the whole system; they should stay focused on one decision.
4. If an ADR changes a boundary, update architecture to reflect the new current shape.
5. If architecture exposes an unresolved design choice, create or update an ADR.
6. If an ADR becomes obsolete, mark it superseded and update architecture links.
7. Troubleshooting and guides should link to the ADR only when readers need to understand why a sensitive command path has that shape.

Example from this project:

- `docs/architecture/system/architecture.md` says WSL/certificate trust is a manual troubleshooting boundary and links the ADR.
- `docs/adr/2026-05-25-wsl-certificate-trust-policy.md` explains why certificate import is manual, public-cert-only, deduplicated, rollbackable, and not automatic.
- `docs/troubleshooting/proxy.md` contains the commands.

## No-Learn Rationale

This session records a useful clarification, but not a new durable policy. Existing artifacts already follow the architecture-links-ADR pattern.

## Follow-ups

No follow-up artifact is required.
