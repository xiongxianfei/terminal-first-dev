---
id: 2026-06-16-remaining-guides-template-rollout-proposal-review
proposal: docs/proposals/2026-06-16-remaining-guides-template-rollout.md
review_status: approved
created: 2026-06-16
repo: xiongxianfei/terminal-first-windows-dev
recording_status: recorded
---

# Proposal Review: Remaining Guides Template Rollout

## Result

- Skill: proposal-review
- Review status: approved
- Material findings: none
- Recording status: recorded
- Recording blocker: none
- Review record: `docs/changes/2026-06-16-remaining-guides-template-rollout/reviews/proposal-review.md`
- Review log: `docs/changes/2026-06-16-remaining-guides-template-rollout/reviews/proposal-review.md`
- Review resolution: not required
- Open blockers: none
- Immediate next stage: `specs/remaining-guides-template-rollout.md`

## Summary

The proposal direction is sound: use a risk-tiered rollout with compatibility paths, preserve command semantics, convert guide bodies in small reviewed slices, and defer broad filename migration until the converted guide bodies are stable.

The proposal already identifies the right problem: structural drift across remaining first-slice guides, not missing content. It also correctly treats `02-wsl2-ubuntu.md` as the highest-risk guide because it includes fresh install, custom-location behavior, migration/import, export verification, unregister warnings, and import-in-place recovery.

The earlier review approval was conditional on the following items being recorded before spec authoring:

1. Resolve the four open questions as decisions, not downstream ambiguity.
2. Treat WSL install and migration splitting as a safety exception inside the WSL conversion slice, not as a general filename-migration precedent.
3. Keep final filename migration separate from body conformance.
4. Carry the backup-before-edit rule into the rollout spec and test spec.

Second-pass result: the proposal now records these decisions, the how-to template spec is approved, and the backup-before-edit requirement is available through `R18`, `R35a`, and the resolved `HGT-SR-001` review disposition. No proposal edits are required before spec authoring.

## Review dimensions

| Dimension | Verdict | Notes |
| --- | --- | --- |
| Problem clarity | pass | The proposal frames structural drift and review risk, not just a preferred file layout. |
| User value | pass | Reader benefit is concrete: faster skimming, safer edits, clearer rollback, and failure-point troubleshooting. |
| Option diversity | pass | The proposal compares broad rewrite, simplest-first, highest-risk-first, risk-tiered rollout, and rename-first options. |
| Decision rationale | pass | Option D follows from the need to reduce review risk without ignoring high-risk WSL content. |
| Scope control | pass | Non-goals protect command contracts, command-execution CI, generated tooling, tutorial creep, and broad filename churn. |
| Architecture awareness | pass | The proposal keeps guides, troubleshooting, specs, tests, and filename migration as separate documentation surfaces. |
| Testability | pass | Static structure checks, link checks, parity review, backup review, and high-risk command review are enough for proposal stage. |
| Risk honesty | pass | The proposal names command drift, safety regression, fast-path bloat, WSL complexity, missing troubleshooting anchors, and uv credential risk. |
| Rollout realism | pass | Small slices with rollback to previous guide bodies are realistic. |
| Readiness for spec | pass | The proposal is accepted, the open-question decisions are recorded, and the backup-before-edit prerequisite is resolved by the approved how-to template spec. |

## Scope-preservation result

Pass.

The proposal preserves the user's intent to continue the guide-template rollout after the template work, stay in the proposal workflow stage, apply the accepted template to the remaining first-slice guides, preserve quick configuration and safety, and avoid broad behavior changes while restructuring documentation.

## Answers to open questions

### 1. Should `02-wsl2-ubuntu.md` remain one guide or split?

Decision: split during the WSL conversion slice.

Recommended target shape:

```text
docs/guides/wsl-ubuntu-install.md      # fresh install, distro selection, custom location, first-run checks
docs/guides/wsl-ubuntu-migration.md    # export/import, unregister warnings, import-in-place recovery
docs/guides/02-wsl2-ubuntu.md          # short compatibility router/stub
```

Rationale:

- Fresh install and migration have different starting states.
- Migration includes destructive operations and recovery paths that can overwhelm a single fast path.
- A single guide would likely need multiple competing fast paths, making it harder to skim and easier to misuse.
- Splitting this one guide is a safety and reader-intent decision, not general permission to rename all numbered paths during body conformance.

Guardrail:

- The compatibility `02-wsl2-ubuntu.md` file should not duplicate commands. It should route readers to the correct task guide and preserve old links.

### 2. Should `01-windows-host.md` remain one guide or split?

Decision: keep it as one guide during body conformance.

Rationale:

- Windows Terminal, PowerShell, WinGet, WSL availability, and optional PowerShell profile behavior form one coherent host-baseline setup task.
- Splitting it now would combine body conversion with information-architecture migration.
- The first conversion pass should prove the two-speed structure without introducing extra link churn.

Deferred option:

- During the later filename-migration slice, the project may split this into task-scoped files such as `windows-terminal-setup.md` and `powershell-setup.md` if the converted guide remains too long or the router benefits from narrower entry points.

### 3. Should `06-uv.md` remain under `docs/guides/`?

Decision: keep `06-uv.md` under `docs/guides/` for the first rollout and label it optional.

Rationale:

- `uv` is optional, but it is still a setup how-to.
- Moving it before there is a broader optional-tool taxonomy adds structure without enough payoff.
- The guide is useful in the first rollout because it exercises package-source safety and credential-free examples.

Guardrails:

- The guide should make optionality obvious in the metadata and router.
- Examples should avoid private hostnames, tokens, credentials, and commands that persist secrets into shell history or committed files.
- If optional tool guides grow, move them later as a taxonomy decision, for example `docs/guides/optional/uv.md` or `docs/guides/tools/uv.md`.

### 4. What compatibility mechanism should final filename migration use?

Decision: use short redirect-style stubs plus router updates.

Preferred final mechanism:

```text
Old numbered files: short compatibility stubs with links to canonical task-scoped guides
Router README: canonical entry point that labels current task guides and compatibility paths
Canonical guides: unnumbered, task-scoped files with the real commands and walkthroughs
```

Rationale:

- Router-only compatibility is too weak because direct links and bookmarks to numbered files break.
- Fully retained numbered files are too risky because duplicated commands drift.
- Short stubs preserve direct links without creating a second source of truth.

Stub rule:

- A stub may include a brief explanation and links.
- A stub should not contain setup commands except harmless verification or navigation commands.
- A stub should say whether the old path is retained temporarily or indefinitely.

## Proposal edit disposition

The required edits were recorded in the proposal:

- replace `Open Questions` with resolved decisions;
- add decision-log rows for WSL split, unified Windows host guide, optional uv guide placement, and redirect-style stubs;
- amend `Recommended Direction` to identify WSL splitting as a safety exception;
- amend `Readiness` for spec handoff after decisions are recorded.

No further proposal edits are requested.

## Spec guidance

The downstream spec should define:

- converted-guide conformance rules;
- exact conversion order;
- the WSL split rule and compatibility-stub rule;
- router behavior while old and new guide paths coexist;
- backup-before-edit coverage for user-owned and system-owned file edits;
- static checks for structure and links;
- review evidence for fast-path/walkthrough parity;
- a no-command-execution-CI boundary for this rollout.

## Evidence check

The proposal says the how-to guide template spec is approved. Current local evidence supports that claim:

- `specs/how-to-guide-template-best-practices.md` status is `approved`.
- `specs/how-to-guide-template-best-practices.md` includes `R18` and `R35a` backup-before-edit coverage.
- `docs/changes/2026-06-15-how-to-guide-template-best-practices/reviews/spec-review-resolution.md` records `HGT-SR-001` as `addressed`.
- `docs/changes/2026-06-15-how-to-guide-template-best-practices/reviews/spec-review.md` records second-pass approval.

## Recommendation

Approve the proposal direction.

No automatic downstream handoff occurs from this review. The next authored artifact should be `specs/remaining-guides-template-rollout.md`.
