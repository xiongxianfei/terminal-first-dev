# Project Constitution

## Project Purpose

This repository exists to produce a concise, auditable guide for setting up terminal-first Windows 11 development. It serves developers who want a practical command-line-centered workstation setup without adopting an opaque bootstrapper, enterprise device-management system, or broad Windows productivity guide.

## Source Of Truth Order

1. `CONSTITUTION.md` defines durable governance and outranks all other project artifacts.
2. `VISION.md` defines project identity, scope, fit, and falsifiability.
3. Accepted specs under `specs/` define behavior for specific changes.
4. Architecture docs under `docs/architecture/` define durable design boundaries when the project adds scripts, generated assets, data flow, or automation.
5. Execution plans under `docs/plans/` define implementation order for approved changes.
6. Tests, checks, and review evidence show whether implementation matches the governing artifacts.
7. Code, scripts, and documentation implement the approved behavior.
8. Chat context is useful background but is not a source of truth unless captured in a durable artifact.

When artifacts conflict, work MUST stop long enough to identify the conflict and either update the lower-priority artifact or ask the owner for a decision.

## Spec-Driven Rules

Specs are not required for small editorial fixes that do not change scope, setup behavior, command semantics, security posture, or compatibility. A spec MUST exist before implementation when a change adds or changes executable setup scripts, command sequences intended for users to run, installation defaults, platform assumptions, supported terminal stacks, package-manager choices, security-sensitive guidance, public interfaces, or generated artifacts.

Requirements in specs MUST use stable IDs so tests, implementation notes, and reviews can trace back to them. Specs MUST identify user-visible behavior, assumptions, non-goals, compatibility expectations, security and privacy impacts, and acceptance criteria.

## Test-Driven Rules

Changes that add or modify executable behavior MUST start with tests, examples, dry-run checks, or another reviewable proof that can fail before the implementation is changed. Bug fixes MUST include a regression test or a documented reason the bug cannot be reproduced automatically.

Documentation-only changes MUST be verified with the checks that match their risk: link checks, Markdown linting, command review, or manual walkthrough evidence when no automated check exists. Agents MUST NOT claim that commands, scripts, or setup flows work unless they ran a relevant check or clearly label the claim as unverified.

## Architecture Rules

The default architecture is documentation-first. Scripts, installers, generated configuration, and machine-changing automation are optional extensions, not the project identity.

Any automation that changes shell behavior, execution policy, credentials, networking, package sources, filesystem locations, or machine-wide state MUST have an architecture note before implementation. Architecture docs MUST define boundaries between guidance, executable scripts, generated files, user-local configuration, and machine-wide changes.

The project SHOULD prefer small, inspectable commands over hidden orchestration. If a helper script is introduced, it MUST expose what it will change before making the change and SHOULD support a dry-run or equivalent review path.

## Security And Privacy Rules

Secrets, tokens, private machine names, personal paths, and credential material MUST NOT be committed. Setup instructions MUST NOT ask users to paste secrets into shell history unless a secure alternative is explained.

Commands that affect execution policy, trust stores, SSH or GPG keys, credential managers, package sources, networking, firewall behavior, or administrator-level settings MUST call out the impact near the command. Dependency recommendations MUST prefer official sources and MUST describe trust assumptions when the source is not obvious.

Logs, examples, screenshots, and terminal transcripts MUST be scrubbed for personal data before publication.

## Compatibility Rules

Windows 11 is the primary compatibility target. Guidance MAY mention older Windows versions, Linux, macOS, or enterprise-managed environments only to clarify non-goals or known differences.

Changes that choose a default shell, terminal, package manager, editor, WSL posture, Git configuration, or path convention MUST document whether the choice is required, recommended, or optional. Breaking changes to documented setup flows MUST include migration notes or a clear replacement path.

## Verification Rules

Every completed change MUST report the exact checks performed and their results. If checks cannot be run, the completion note MUST say why and identify the remaining risk.

Before declaring a change complete, agents MUST inspect the diff, confirm that unrelated user changes were not reverted, and verify that README front-matter remains synchronized with `VISION.md` when the vision changes. CI MUST NOT be described as passing unless the relevant CI run or equivalent local command was actually observed.

## Review Rules

Proposal review SHOULD be used before committing to a new direction that changes project scope, target users, or major tradeoffs. Spec review MUST happen before implementation of behavior-changing specs. Architecture review MUST happen before hard-to-reverse automation, security-sensitive setup changes, or cross-boundary design decisions. Plan review SHOULD happen for multi-step or risky implementation work. Code review MUST focus on behavioral regressions, missing tests, security risks, and drift from source-of-truth artifacts.

## Documentation Rules

`README.md` should stay useful to first-time readers and must keep its vision front-matter generated from `VISION.md`. `VISION.md` changes are substantive when they alter scope, users, commitments, refusals, or falsifiability. Substantive vision changes MUST include supporting rationale in `docs/vision/strategic-positioning.md` or a change-local explanation.

Specs, architecture docs, plans, and learning notes MUST be updated when a change makes the current durable docs misleading. Temporary implementation notes belong in change-local artifacts, not in the constitution.

## Agent Behavior Rules

Agents MUST preserve unrelated user changes. Agents MUST NOT run destructive commands, rewrite history, delete files, or replace user-authored content unless the user explicitly asks for that operation.

Agents MUST state material assumptions, especially around Windows policy, administrator privileges, package sources, and security-sensitive commands. Agents MUST keep changes scoped to the request, avoid unrelated refactors, and prefer existing repository conventions. Agents MUST NOT invent validation evidence, fake CI results, or silently treat chat decisions as durable requirements.

## Standard Workflow And Manual Skill Use

The standard workflow is:

1. Check `CONSTITUTION.md`, `VISION.md`, and relevant existing artifacts.
2. Explore or research only when assumptions are uncertain or current facts matter.
3. Write or update a proposal, spec, architecture, and plan when the change risk requires them.
4. Implement with tests or proof first.
5. Review the diff against the governing artifacts.
6. Verify with local commands, CI evidence, or documented manual checks.
7. Record durable learnings when the work reveals a repeatable process or project rule.

Individual skills MAY be invoked directly for isolated work, but completion claims MUST include the same evidence the full workflow would require for that level of risk. Skipping a stage is acceptable only when the change is clearly low risk and the completion note makes that scope clear.

## Open Governance Questions

- What default terminal stack should future specs assume: PowerShell-first, WSL-first, or side-by-side?
- Should executable setup scripts be allowed in the first version, and if so, what dry-run behavior is required?
- Which validation tools should become mandatory once the project has real Markdown, link, or script checks?
