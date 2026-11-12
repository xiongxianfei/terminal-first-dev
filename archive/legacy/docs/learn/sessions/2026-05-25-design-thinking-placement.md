# Learn Session: Design Thinking Placement

## Frame

- Trigger: Maintainer question: "what're the best practices to record the design thinking in our project. For example, for exporting certificates in win11, we only record how to use it. For the design principle we don't record it."
- Trigger type: explicit maintainer/contributor observation.
- Scope: where this repository should record design thinking, rationale, principles, and operational how-to for setup behavior.
- Evidence in scope:
  - `CONSTITUTION.md`
  - `docs/workflows.md`
  - `docs/adr/2026-05-24-proxy-strategy.md`
  - `docs/troubleshooting/proxy.md`
  - `docs/changes/2026-05-24-terminal-first-workstation-setup/explain-change.md`
  - prior learn sessions under `docs/learn/sessions/`
- Explicit exclusions: no workflow-policy update, ADR update, spec update, or topic-file guidance is made by this learn session.
- Prior learnings reviewed:
  - `docs/learn/sessions/2026-05-24-review-record-location-ambiguity.md`
  - `docs/learn/sessions/2026-05-24-change-plan-placement-strategy.md`
- Session record path: `docs/learn/sessions/2026-05-25-design-thinking-placement.md`

## Observe

O1. The project already separates artifact purposes, but contributors can still confuse how-to documentation with design rationale.

Evidence:

- `docs/workflows.md` maps proposals, specs, architecture, ADRs, change plans, explanation artifacts, and troubleshooting-adjacent change artifacts to different locations.
- `CONSTITUTION.md` says architecture docs define durable design boundaries and agents must not silently treat chat decisions as durable requirements.
- `docs/troubleshooting/proxy.md` now documents how to export Windows certificates and install them in WSL, but the deeper design criteria were mostly discussed in chat.

O2. The certificate export example has design principles worth preserving separately from the commands.

Evidence:

- The final documented script uses a dedicated current-folder export directory, recursively scans `Cert:\`, filters `X509Certificate2`, uses safe filenames, deduplicates by thumbprint, exports public cert data only, and keeps rollback explicit.
- These are not just command details; they encode safety and maintainability principles: avoid private-key export, avoid duplicate trust material, keep certificate material out of the repo, keep trust-store changes reversible, and prefer selected enterprise roots when known.

O3. Different kinds of design thinking belong in different artifacts.

Evidence:

- ADRs under `docs/adr/` record durable decisions such as proxy strategy, version/package policy, WSL storage/data mount policy, and Neovim baseline.
- `docs/changes/<change-id>/explain-change.md` explains why the implemented diff changed.
- Troubleshooting docs under `docs/troubleshooting/` contain recovery steps and symptoms.

## Classify

| Observation ID | Proposed primary classification | Final primary classification | Secondary routes | Confirmed by | Rationale |
| --- | --- | --- | --- | --- | --- |
| O1 | observation | observation | none | evidence only | The existing workflow map already separates artifact types; this session clarifies their use. |
| O2 | direction | routed direction | ADR update | maintainer confirmed by requesting an ADR | Capturing certificate-export design principles changes authoritative design docs, so it was routed to an ADR after owner confirmation. |
| O3 | observation | observation | none | evidence only | The project already has proposal, ADR, spec, guide, troubleshooting, and explain-change surfaces with different purposes. |

## Route

- O1 and O3 are recorded in this session only.
- O2 was routed after owner confirmation to `docs/adr/2026-05-25-wsl-certificate-trust-policy.md`.
- No topic file was created because this is a single maintainer observation plus an example, not an accumulated durable lesson or accepted policy update.

## Answer

Best practice is to record design thinking at the artifact level that owns the decision:

| Design content | Best artifact | Use when |
| --- | --- | --- |
| Product direction, options, tradeoffs, recommendation | `docs/proposals/YYYY-MM-DD-slug.md` | The project is choosing what to build or what scope to accept. |
| Durable technical decision or principle | `docs/adr/YYYY-MM-DD-slug.md` | The decision should guide future contributors across multiple docs or changes. |
| Observable behavior contract | `specs/<feature>.md` | The behavior must be testable as a requirement. |
| Cross-component structure, boundaries, data flow, security model | `docs/architecture/system/architecture.md` | The design affects long-lived structure or hard-to-reverse boundaries. |
| Step-by-step setup or happy path | `docs/guides/*.md` | The reader needs to perform the setup. |
| Symptoms, diagnosis, recovery, rollback | `docs/troubleshooting/*.md` | The reader is fixing an environment-specific failure. |
| Why the actual diff changed | `docs/changes/<change-id>/explain-change.md` | Reviewers need the diff linked back to requirements and decisions. |
| Observation that might become policy later | `docs/learn/sessions/*.md` | The project noticed a pattern but has not accepted a rule yet. |

For the Windows certificate export example:

- The commands belong in `docs/troubleshooting/proxy.md`.
- The durable principles likely belong in `docs/adr/2026-05-24-proxy-strategy.md` if the owner wants them to guide future proxy/certificate work.
- A short local "Why this shape" or "Design notes" subsection could also live beside the troubleshooting commands when the rationale is specific to that recovery path.

The useful principles to preserve are:

- export public certificate data only, never private keys;
- prefer the smallest required trust change, such as a known enterprise root, before importing every Windows certificate;
- use a dedicated export directory outside the repo;
- deduplicate by thumbprint;
- use safe filenames;
- install into a dedicated Ubuntu CA subdirectory;
- make verification and rollback explicit;
- never commit exported certificate material.

## No-Learn Rationale

This session captured a valid design-documentation gap, but it does not by itself create new policy. The repository already has appropriate owning artifacts. A follow-up ADR or troubleshooting update should happen only after the owner confirms the desired route.

## Follow-ups

Completed follow-up: `docs/adr/2026-05-25-wsl-certificate-trust-policy.md` records the certificate-export design principles, and `docs/adr/2026-05-24-proxy-strategy.md` links to it.
