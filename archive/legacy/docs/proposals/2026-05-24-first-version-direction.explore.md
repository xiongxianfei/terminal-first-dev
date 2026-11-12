# First-Version Direction Exploration

## Problem Restatement

The project needs a first-version direction for a concise, terminal-first Windows 11 development setup guide. The main tension is between staying short and auditable, giving users enough concrete value to act, and avoiding premature choices about PowerShell, WSL, package managers, editors, and automation. The first version should help a developer orient and make progress without turning into a broad Windows tweaking guide or an opaque bootstrap system.

## Stakeholders And User Journeys

- Primary reader: a developer setting up or cleaning up a Windows 11 machine for daily terminal-centered work.
- Maintainer: the person keeping recommendations current, concise, and safe.
- Contributor or agent: anyone proposing changes that affect setup behavior, commands, defaults, compatibility, or security posture.

Affected journeys:

- A reader lands on `README.md` and wants to know what this project helps them do.
- A reader chooses a terminal baseline and follows a short setup path.
- A contributor proposes a new command, tool recommendation, script, or setup section.
- A reviewer checks whether guidance is auditable, current, and aligned with the vision.

## Facts

- The project is documentation-first today.
- `CONSTITUTION.md` requires specs before setup behavior, scripts, command defaults, security posture, or compatibility assumptions change.
- `VISION.md` commits the project to concise, auditable terminal-first Windows 11 setup guidance.
- No source code, setup scripts, tests, CI, package metadata, or validation commands exist.
- The current README still contains generic repository-template content below the vision block.

## Assumptions

- The first useful product increment is likely documentation, not automation.
- The target user can run commands manually and wants to inspect them before use.
- Windows Terminal plus PowerShell is the lowest-friction Windows-native baseline, while WSL is important but not universally desired.
- Package manager and editor choices should be framed as defaults or options, not hidden prerequisites.

## Unknowns

- Whether the owner wants PowerShell-first, WSL-first, or side-by-side as the default narrative.
- Whether scripts are acceptable in the first version.
- Which package manager is preferred for baseline guidance.
- Which editor assumptions are acceptable.
- Whether this repository should keep `.agents/skills/` as committed project workflow assets.

## Options

| Option | Core Idea | User Value | Complexity | Architecture Impact | Testing Burden | Rollout / Rollback | Key Risk | Wrong If |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| O0: Defer | Keep governance docs only and delay product guidance. | Avoids premature direction. | Very low. | None. | File/link review only. | No rollback needed. | Project remains unusable for its stated audience. | The goal is to produce a simple first version now. |
| O1: README-only orientation | Replace template README content with project-specific overview, scope, and decision questions. | First-time readers understand the project immediately. | Low. | None beyond docs. | Markdown/link review. | Easy revert. | Still does not help someone set up a machine. | Users need actionable setup guidance in the first version. |
| O2: Concise manual setup guide | Add a short guide with a Windows-native baseline, likely Windows Terminal plus PowerShell, and explicit optional WSL notes. | Gives users a practical path while staying auditable. | Moderate. | Documentation-only; specs needed for command defaults. | Markdown, link, and command review; manual walkthrough when possible. | Sections can be edited or removed. | Recommendations can become stale or too opinionated. | The owner wants WSL-first or automation-first. |
| O3: Structured guide with profiles | Define separate profiles such as PowerShell-first, WSL-first, and side-by-side. | Serves more users without forcing one workflow. | Medium-high. | More durable information architecture; likely needs a spec. | More walkthrough combinations and compatibility checks. | Profiles can be narrowed later, but content churn may be high. | The project stops being concise. | The project should make one opinionated default obvious. |
| O4: Script-assisted setup | Introduce auditable scripts with dry-run output for selected setup steps. | Faster repeatable setup and stronger proof of command behavior. | High. | Adds executable surface, architecture boundaries, tests, and security review. | Script tests, dry-run fixtures, command safety review, possibly CI. | Rollback is harder because scripts affect user machines. | Violates the vision if automation becomes the main identity. | The first version should stay documentation-only. |

## Option Details

### O0: Defer

Core idea: stop after vision, constitution, and project map until the owner resolves the major direction questions.

User value: future work has stronger governance, but current users still lack setup guidance.

Implementation complexity: very low; no product artifact is added.

Architecture impact: none.

Testing burden: verify links and Markdown only if docs change.

Rollout and rollback: no meaningful rollout; easy to leave as-is.

Risks: the repository looks well-governed but does not deliver the promised simple guide.

What would make it wrong: the owner wants momentum toward a usable first version now.

### O1: README-Only Orientation

Core idea: replace template README content with a clear product landing README: what the guide is, what it covers, what it avoids, and what decisions remain open.

User value: readers stop seeing generic template language and understand the project immediately.

Implementation complexity: low; this is editorial documentation.

Architecture impact: none.

Testing burden: Markdown review and link checks when tooling exists.

Rollout and rollback: easy because only README content changes.

Risks: it improves presentation but not the actual setup outcome.

What would make it wrong: the first version is expected to help someone configure a machine, not only understand intent.

### O2: Concise Manual Setup Guide

Core idea: add a compact first guide that assumes Windows Terminal plus PowerShell as the baseline, treats WSL as an optional development layer, and keeps each command inspectable. The guide can cover prerequisites, terminal shell posture, Git, package manager choice, editor hookup, environment checks, and a short validation checklist.

User value: a developer can follow a practical path without running hidden automation.

Implementation complexity: moderate because tool choices and command defaults need careful wording.

Architecture impact: still documentation-first. A spec is appropriate because the guide chooses setup behavior, command defaults, and compatibility assumptions.

Testing burden: Markdown review, link review, command review, and ideally a manual walkthrough on a Windows 11 machine.

Rollout and rollback: sections can be edited independently; incorrect recommendations can be replaced without removing a platform.

Risks: a Windows-native baseline may disappoint WSL-first developers; package-manager recommendations can age; commands may vary by policy and Windows build.

What would make it wrong: the intended audience is mostly WSL-first, or the owner wants scripts as the primary value.

### O3: Structured Guide With Profiles

Core idea: create multiple first-class tracks: PowerShell-first, WSL-first, and side-by-side. Each profile has assumptions, steps, and checks.

User value: users choose the path that matches their workflow instead of fighting a single default.

Implementation complexity: medium-high because duplicated decisions need synchronization.

Architecture impact: introduces a stable documentation information architecture. It likely needs a spec for profile definitions and compatibility claims.

Testing burden: each profile needs command review and, eventually, walkthrough evidence.

Rollout and rollback: profiles can be added or removed, but user-facing churn may be visible.

Risks: the project may become too broad for its concise promise; maintaining parity across profiles creates overhead.

What would make it wrong: a concise first version is more important than serving every plausible terminal workflow.

### O4: Script-Assisted Setup

Core idea: create one or more scripts that inspect the machine, print planned changes, and optionally apply selected setup steps.

User value: repeatability and faster setup for experienced users.

Implementation complexity: high due to safety, idempotence, policy differences, and rollback concerns.

Architecture impact: significant. Scripts introduce executable boundaries, generated state, machine changes, test fixtures, and likely CI.

Testing burden: high. Dry-run fixtures, unit tests for command planning, manual Windows checks, and security review would be needed.

Rollout and rollback: harder because scripts can change local machine state; rollback guidance would be part of the product surface.

Risks: this can become the opaque bootstrapper the vision rejects; support burden rises quickly.

What would make it wrong: the project should stay short and auditable before automation exists.

## Decision Criteria

| Criterion | O0 | O1 | O2 | O3 | O4 |
| --- | --- | --- | --- | --- | --- |
| Delivers user setup value | Low | Low | High | High | High |
| Preserves concise scope | High | High | High | Medium | Low |
| Keeps commands auditable | High | High | High | Medium | Medium |
| Avoids premature architecture | High | High | High | Medium | Low |
| Handles WSL diversity | Low | Low | Medium | High | Medium |
| Maintenance burden | Low | Low | Medium | High | High |
| Security review burden | Low | Low | Medium | Medium | High |

## Recommendation

Use a staged sequence: O1 first, then O2.

O1 should remove the generic template feel and make the repository intelligible to first-time readers. O2 should then provide the first real setup value as a concise manual guide. The recommended O2 framing is Windows Terminal plus PowerShell as the baseline, with WSL presented as an optional layer rather than the default identity. That sequence fits the vision because it keeps the project auditable, short, and useful before introducing profiles or scripts.

Do not start with O3 unless the owner explicitly wants profile parity in the first version. Do not start with O4 unless the owner explicitly chooses automation as an early product surface and accepts the extra architecture, testing, and security burden.

## Skeptical Objections

- A skeptical engineer may object that Windows setup commands cannot be trusted without testing on real Windows 11 machines.
- A skeptical user may object that a PowerShell-first baseline underplays WSL-based development.
- A maintainer may object that package manager and editor recommendations age quickly.
- At larger scale, support burden grows if the guide tries to cover every Windows policy, shell, and package-manager variant.
- The convenient assumption is that one baseline is enough; the guide should make the tradeoff visible.
- Behavior that should remain unchanged: the project should not become a broad OS tweaking guide or opaque one-command bootstrapper.

## Research Questions Before Proposal Or Spec

- What is the current recommended installation and update path for Windows Terminal, PowerShell, Git for Windows, WSL, and the likely package manager?
- Which package manager should the first guide use as the default, if any?
- Which commands require administrator privileges or change machine-wide state?
- Which setup steps vary under common enterprise Windows policies?
- What minimum manual walkthrough can verify the first guide on a real or fresh Windows 11 environment?
- Should `.agents/skills/` stay committed as part of this repository's workflow, or be removed from the product repo?

## Readiness

This exploration is ready for owner discussion. The next best skill is `proposal` if the owner accepts the staged O1 then O2 direction, or `research` if current Windows tooling recommendations should be verified before choosing the first guide contents.
