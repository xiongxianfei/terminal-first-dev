---
id: 2026-06-15-how-to-guide-template-best-practices
title: Best-Practice How-To Guide Template for Terminal-First Windows Dev
status: accepted
created: 2026-06-15
repo: xiongxianfei/terminal-first-windows-dev
proposal_path: docs/proposals/2026-06-15-how-to-guide-template-best-practices.md
related:
  - docs/proposals/2026-06-07-guides-two-speed-how-to-structure.md
  - docs/templates/how-to-guide.md
  - docs/guides/proxy-setup.md
  - docs/guides/03-ubuntu-baseline.md
---

# Best-Practice How-To Guide Template for Terminal-First Windows Dev

## Status

accepted

## Problem

The accepted two-speed guide proposal defines the direction for `docs/guides/`: task-scoped how-to documents with a fast path, a walkthrough, inline troubleshooting links, and a router-style guide index. The next decision is narrower: the repository needs a concrete reusable template that turns that direction into consistent guide authoring practice.

Without a strong template, contributors can agree with the two-speed pattern in principle while still producing guide pages that drift in small but costly ways:

- inconsistent prerequisite, outcome, and verification blocks;
- missing shell context for commands that switch between Windows PowerShell and Ubuntu;
- fast paths that are too verbose to skim;
- walkthroughs that become tutorials;
- state-changing steps without visible backup, scope, or rollback notes;
- troubleshooting links that exist only at the end instead of at the failure point;
- command blocks whose expected result is unclear;
- repeated fast-path and walkthrough commands that silently diverge.

This project is especially sensitive to those failures because its guides can change WSL global configuration, Ubuntu files, sudoers behavior, mounted paths, shell profiles, Neovim runtime state, and tmux configuration. The template should make safe, quick configuration the default authoring shape instead of relying on reviewer memory.

The current `proxy-setup.md` reference exemplar already demonstrates much of the desired pattern: visible prerequisites, time, outcome, verification, a fast path, a walkthrough, rollback, and targeted troubleshooting links. The template proposal should standardize that shape, tighten the best-practice rules around it, and keep future guide authors from turning how-to guides into tutorials or hidden automation.

## Goals

- Define the reusable how-to guide template as the contributor-facing contract for `docs/guides/`.
- Preserve the accepted two-speed guide model: fast path first, walkthrough second.
- Optimize each guide for quick configuration without removing safety, verification, or rollback information.
- Make the template work for both Windows host tasks and Ubuntu-on-WSL tasks.
- Standardize visible guide metadata: prerequisites, time, outcome, verification, and safety or scope notes when relevant.
- Standardize step shape: action, command, expected result, verification, and failure-point troubleshooting link.
- Make shell context explicit for every command block that could be run in the wrong environment.
- Require rollback guidance for machine-changing guides.
- Keep deep troubleshooting outside guides while linking to exact troubleshooting anchors inline.
- Keep design rationale out of how-to prose unless a short link to an ADR or architecture note is needed.
- Provide a template that can be copied into new guide files with minimal editing.
- Support lightweight documentation checks without requiring command-execution CI in the first slice.

## Non-goals

- Rewriting all guides as part of this proposal.
- Changing the accepted decision to use task-scoped two-speed guides.
- Moving troubleshooting content back into guide pages.
- Creating a generated documentation site or template engine.
- Creating a one-command installer or hiding commands behind scripts.
- Defining exact PowerShell, WSL, Neovim, tmux, proxy, sudoers, or mount command contracts.
- Executing guide command blocks in CI during the first slice.
- Replacing ADRs, architecture notes, or specs with longer guide explanations.
- Making every guide identical in length; the template standardizes structure, not topic size.
- Creating beginner tutorials inside `docs/guides/`.

## Vision fit

fits the current vision

This proposal fits the current terminal-first workstation direction because it strengthens the repository as a concise, auditable, documentation-first setup guide. It keeps the project practical for users who want to configure a Windows and WSL development workstation quickly, while preserving explicit command contracts and reviewable safety boundaries.

The proposal does not change the product scope. It refines the contributor-facing guide template that implements the already accepted two-speed how-to direction.

## Context

The accepted guide-structure proposal records these upstream decisions:

- `docs/guides/` is for how-to documentation, not tutorials or design rationale.
- Guides use a two-speed structure: `Fast path` near the top and `Walkthrough` below it.
- Troubleshooting remains separate under `docs/troubleshooting/`.
- Guides link to troubleshooting anchors inline at likely failure points.
- `docs/guides/README.md` routes readers by intent.
- Small task-scoped guides are preferred over one large linear setup guide.
- The reusable template lives at `docs/templates/how-to-guide.md`.
- `proxy-setup.md` is the reference exemplar for the proposed template shape.

The current `proxy-setup.md` reference exemplar is a useful evidence source because proxy setup has the qualities that make the template important: it is environment-dependent, it changes user-local WSL behavior, it requires restart semantics, it has several likely failure modes, and it needs rollback guidance.

Using only `proxy-setup.md` to validate the template would be circular because the proposed template is partly derived from that guide's current shape. The portability pilot should therefore use a different guide, with `docs/guides/03-ubuntu-baseline.md` as the first candidate because it exercises Ubuntu-on-WSL setup behavior without being the template's source exemplar.

The template should therefore be shaped around the most demanding first-slice guide types rather than the easiest guide type. A template that works for WSL proxy configuration, data mounts, sudoers changes, and shared Neovim configuration will also work for simpler guides such as installing tmux.

External documentation practice supports this direction. Diataxis frames how-to guides as goal-oriented directions that help users get work done correctly and safely, while distinguishing them from tutorial-style learning content. Modern procedure-writing guidance also supports consistent scanning structure and numbered sequential steps for multi-step procedures.

## Options considered

### Option A: Keep the accepted proposal and rely on reviewer judgment

Use the accepted guide-structure proposal as the only policy. Do not create a separate best-practice template proposal; reviewers enforce the pattern informally while new guides are written.

Pros:

- Lowest process overhead.
- No extra proposal or spec work.
- Lets contributors start writing guides immediately.

Cons:

- The guide structure remains too dependent on individual reviewers.
- Subtle failures such as missing expected output, missing shell context, and misplaced troubleshooting links will recur.
- Contributors have no copyable artifact that demonstrates the expected shape.
- The accepted proposal remains a direction record rather than an authoring tool.

### Option B: Create a minimal template with headings only

Create `docs/templates/how-to-guide.md` with only the major headings: metadata, fast path, walkthrough, rollback, and troubleshooting.

Pros:

- Simple and easy to copy.
- Avoids over-prescribing prose and step shape.
- Useful as a starting point for contributors.

Cons:

- Too weak for machine-changing guides.
- Does not prevent commands without shell context or expected results.
- Does not define when rollback or safety notes are needed.
- Does not solve fast-path and walkthrough drift.

### Option C: Create a strict full-template with many required sections for every guide

Create a comprehensive template where every guide includes all possible sections: environment, assumptions, prerequisites, safety, backup, side effects, fast path, walkthrough, verification, rollback, troubleshooting, FAQ, related ADRs, and references.

Pros:

- Strong consistency.
- Easy to validate mechanically.
- Reduces the chance of omitting safety context.

Cons:

- Too heavy for simple tasks.
- Encourages empty or low-value sections.
- Makes quick guides feel bureaucratic.
- Can push authors to write tutorial-style filler to satisfy the template.

### Option D: Best-practice template with a small required core and conditional safety modules

Create a template with a required core for every how-to guide and conditional modules for state-changing, risky, or environment-sensitive guides.

The required core covers title, visible metadata, fast path, walkthrough, per-step expected results, and inline failure-point troubleshooting links. Conditional modules cover safety, scope, backup, rollback, and compatibility notes when the guide changes machine state or depends on environment-specific behavior.

Pros:

- Strong enough for WSL, sudoers, mount, proxy, Neovim, and tmux guides.
- Light enough for simple setup guides.
- Keeps fast-path skimmability while preserving safety.
- Provides a copyable template and reviewable contract.
- Supports static checks without premature command-execution CI.

Cons:

- Requires reviewer discipline to decide when conditional modules apply.
- Adds some authoring overhead.
- Still allows command drift between fast path and walkthrough unless checks or review catch it.

### Option E: Generated guide scaffolder and linter first

Create a script or generator that creates new guide files from structured input, then add CI checks for every required section and anchor.

Pros:

- High consistency.
- Easier future automation.
- Could reduce copy/paste mistakes.

Cons:

- Premature for the current repository stage.
- Adds tooling before the content model has been tested across several guides.
- Makes guide creation less transparent for casual contributors.
- Does not solve command quality by itself.

### Option F: Exemplar-only guidance without a reusable template file

Treat `docs/guides/proxy-setup.md` as the example contributors should imitate, but do not create or maintain `docs/templates/how-to-guide.md` as a separate copyable artifact.

Pros:

- Lowest maintenance burden after the exemplar guide is settled.
- Shows the pattern in real content instead of abstract placeholders.
- Avoids contributors copying template notes into published guides.

Cons:

- Keeps the authoring contract implicit and harder to review.
- Makes simple guides copy irrelevant proxy-specific details by accident.
- Does not give reviewers a neutral template for checking guide shape.
- Leaves future static checks without a canonical template source.

## Recommended direction

Choose Option D: a best-practice template with a small required core and conditional safety modules.

The template should be plain Markdown and live at:

```text
docs/templates/how-to-guide.md
```

The template should produce guide files that are easy to skim in GitHub, easy to review in diffs, and safe enough for setup topics that change user-machine state.

Recommended template contract:

````markdown
# <Verb> <task outcome>

**Prerequisites:** <what must already be true before the reader starts>.
**Time:** <realistic estimate or range>.
**Outcome:** <observable result after the guide succeeds>.
**Verify:** `<single best verification command>` succeeds in <environment>.
**Scope:** <optional; required when the guide changes machine, user, WSL, shell, editor, or tmux state>.
**Safety:** <optional; required before destructive, security-sensitive, or hard-to-undo changes>.

## Fast path

1. <Action-oriented step title>.

   Run from <Windows PowerShell | Ubuntu | inside Neovim | inside tmux>:

   ```<language>
   <command>
   ```

   Expected result: <what the reader should see or what state should be true>.

   If <common failure symptom>, use [<targeted troubleshooting entry>](../troubleshooting/<topic>.md#<anchor>).

2. <Next action-oriented step title>.

   ```<language>
   <command>
   ```

   Expected result: <success signal>.

## Walkthrough

### 1. <Same action-oriented step title>

<Brief context: one or two short paragraphs at most. Explain only what the reader needs to complete this task safely. Link to an ADR or architecture note for durable rationale.>

Run from <environment>:

```<language>
<command>
```

Expected result: <success signal>.

Verify:

```<language>
<verification command>
```

Expected result: <verification signal>.

<Optional state-changing module:>

- Scope: <what this changes>.
- Backup: <what is backed up or how to back it up>.
- Rollback: <how to undo this step>.

If <common failure symptom>, use [<targeted troubleshooting entry>](../troubleshooting/<topic>.md#<anchor>).

## Rollback

<Required for machine-changing guides. Keep it short and executable. Link to troubleshooting for deep recovery.>

## Troubleshooting

Use the targeted entry that matches the symptom:

- <Symptom>: [<troubleshooting title>](../troubleshooting/<topic>.md#<anchor>)
- <Symptom>: [<troubleshooting title>](../troubleshooting/<topic>.md#<anchor>)
````

The template should include short author notes inside HTML comments or clearly labeled contributor comments that are removed before publishing a guide. Those notes should explain which sections are required, which are conditional, and how to handle guides that have no state-changing behavior.

### Required core for every guide

Every guide should include:

- an outcome-led title using an action verb;
- a visible metadata block with prerequisites, time, outcome, and verification;
- a `Fast path` section near the top;
- a `Walkthrough` section below the fast path;
- numbered steps for ordered procedures;
- explicit shell or execution context for commands;
- expected result text after each meaningful command or verification;
- inline troubleshooting links at likely failure points;
- short prose that supports the command path rather than replacing it.

### Conditional modules

State-changing or environment-sensitive guides should include:

- `Scope` in the metadata block;
- `Safety` in the metadata block when the guide touches security, persistence, storage, identity, proxy, sudoers, fstab, WSL global configuration, or editor runtime state;
- backup guidance before editing user-owned or system-owned files;
- rollback guidance at the step level when useful and in a dedicated `Rollback` section when the guide makes persistent changes;
- compatibility notes only where they change user action.

Simple read-only or verification-only guides can omit safety, backup, and rollback sections if omission does not hide a real recovery need.

### Command-block conventions

The template should make command context unambiguous:

- Use `powershell` for Windows PowerShell or PowerShell 7 commands.
- Use `bash` for Ubuntu shell commands.
- Use `ini`, `toml`, `lua`, or `tmux` for configuration snippets where supported by Markdown tooling.
- Introduce each command block with where to run it.
- Do not mix Windows and Ubuntu commands in one code block.
- Use placeholders like `<UbuntuUser>` only when necessary, and define them before the command.
- Avoid putting secrets, proxy credentials, tokens, or private hostnames in commands.
- Prefer commands that can be re-run safely, or label commands that are not idempotent.

### Fast path versus walkthrough parity

The fast path and walkthrough should use the same high-level step order. The walkthrough can include additional context, safety notes, backup details, and verification commands, but it should not introduce a different task flow unless the guide explicitly labels an alternative path.

Reviewers should check for drift between the two sections before accepting a guide change.

### Troubleshooting relationship

The guide should stay on the happy path. It should not contain deep recovery procedures unless the recovery is a small local correction that belongs in the same step.

Inline troubleshooting links should be placed where the failure occurs. The final `Troubleshooting` section should act as a symptom router, not a replacement for inline links.

## Expected behavior changes

After this proposal is implemented through downstream specs and plans:

- `docs/templates/how-to-guide.md` becomes the canonical starting point for new how-to guides.
- New guides have a consistent visible metadata block.
- New guides state where each command runs.
- State-changing guides expose scope, safety, backup, and rollback information early.
- Fast paths remain short and command-forward.
- Walkthroughs add context without becoming tutorials.
- Troubleshooting links appear inline at likely failure points.
- `proxy-setup.md` can be maintained as the reference exemplar for the template shape.
- `docs/guides/03-ubuntu-baseline.md` can validate whether the template ports to a different guide type.
- Reviewers have a concrete checklist for accepting or requesting guide changes.
- Static documentation checks can validate structure and links without executing setup commands.

## Architecture impact

This proposal affects documentation architecture and contribution workflow, not runtime architecture.

Expected repository surfaces:

```text
docs/templates/how-to-guide.md        # canonical reusable template
docs/guides/*.md                     # reader-facing how-to guides
docs/guides/proxy-setup.md           # reference exemplar for template fit
docs/guides/03-ubuntu-baseline.md    # portability pilot for a different guide type
docs/troubleshooting/*.md            # deep recovery targets linked from guides
docs/guides/README.md                # reader-intent router
tests/markdown/*.sh                  # optional static structure/link checks after spec
specs/*                              # downstream template requirements and checks
```

Boundary rules:

- The template defines guide shape and authoring expectations.
- Guides tell the reader how to complete a task.
- Troubleshooting explains recovery from specific symptoms.
- ADRs and architecture notes explain durable rationale.
- Specs define testable requirements for structure, links, and validation.
- Tests check the stable parts of the documentation contract.

This proposal does not introduce a new runtime component. It does, however, improve the safety boundary around machine-changing documentation by requiring explicit context, scope, expected results, and rollback where appropriate.

## Testing and verification strategy

The downstream spec should define checks in layers.

Static structure checks:

- Verify that reader-facing guides include `Fast path` and `Walkthrough` sections.
- Verify that guides include visible prerequisites, time, outcome, and verification metadata.
- Verify that ordered procedure sections use numbered steps where the sequence matters.
- Verify that guide links to `docs/troubleshooting/` resolve.
- Verify that troubleshooting anchors referenced by guides exist.

Review checklist checks:

- Confirm the title is outcome-led.
- Confirm the fast path is short enough to skim and act on.
- Confirm the walkthrough follows the same high-level step order as the fast path.
- Confirm shell context is explicit before commands.
- Confirm state-changing guides include scope, safety, backup, and rollback where relevant.
- Confirm expected results appear near meaningful commands.
- Confirm rationale-heavy prose links to ADRs or architecture notes instead of expanding inside the guide.

Pilot validation:

- Check `proxy-setup.md` against the template as the reference exemplar because it exercises WSL global configuration, restart behavior, verification, rollback, and multiple troubleshooting routes.
- Check `docs/guides/03-ubuntu-baseline.md` as the portability pilot so validation is not circular.
- A reviewer who did not author the template should start from the guide's stated prerequisites, use only the fast path on a Windows 11 + WSL Ubuntu test machine or documented dry-run review, and count the test as successful only if the expected verification signal is reachable without reading the walkthrough.
- Record any template element that feels heavy, ambiguous, or insufficient during pilot review.

Deferred validation:

- Command-block execution checks should remain a follow-up until the repository has stable command specs and a realistic Windows and WSL runner model.
- Generated docs tooling should remain a follow-up unless plain Markdown structure checks prove insufficient.

## Rollout and rollback

Rollout:

- Add this proposal under `docs/proposals/`.
- Review the proposal before using it as the basis for a spec or template change.
- Author or revise the guide-template spec to include the template contract, conditional modules, command-block conventions, and validation approach.
- Create or update `docs/templates/how-to-guide.md` as the canonical reusable template.
- Re-check `docs/guides/proxy-setup.md` as the reference exemplar against the template.
- Check `docs/guides/03-ubuntu-baseline.md` as the portability pilot before applying the template broadly.
- Apply the template to future guide conversions only after the portability pilot confirms the shape is useful beyond the exemplar.
- Add lightweight structure and link checks after the template stabilizes.

Rollback:

- If the template is too heavy, keep the accepted two-speed guide direction and reduce the template to the smaller required core.
- If conditional modules cause reviewer disagreement, convert them into an explicit checklist in the spec.
- If the portability pilot becomes less readable, keep the prior guide structure and revise the template before applying it to more guides.
- If structure checks produce too many false positives, keep them advisory until the template language is simpler to validate.

## Risks and mitigations

| Risk | Impact | Mitigation |
| --- | --- | --- |
| Template becomes too heavy | Contributors may write filler or avoid updating guides | Use a small required core and conditional modules only when the guide needs them |
| Fast path becomes a second full guide | Experienced readers lose the quick-configuration benefit | Keep the fast path command-forward and move context into the walkthrough |
| Walkthrough becomes a tutorial | Guides become slow to skim and hard to maintain | Keep rationale short and link to ADRs or architecture docs for deeper explanation |
| Fast path and walkthrough drift | Readers may see conflicting commands | Keep the same high-level step order and review for parity |
| Shell context remains ambiguous | Readers may run Windows commands in Ubuntu or Ubuntu commands in PowerShell | Require a short "Run from ..." line before command blocks |
| Expected results are vague | Readers may continue after a failed or partial setup | Put expected result text after meaningful commands and verification commands |
| Troubleshooting links break | Readers hit dead links while already blocked | Add link and anchor checks before broad guide conversion |
| Safety language overwhelms simple guides | Simple tasks become noisy | Make safety, scope, backup, and rollback conditional, not universal |
| Security-sensitive examples leak bad practice | Users may paste secrets into shell history or config files | Avoid credential examples and route secret-handling cases to troubleshooting cautions |
| Template discourages topic-specific judgment | Authors may follow the shape mechanically while missing real user risk | Keep review checklist judgment-based for state-changing and environment-sensitive guides |
| Command execution CI is added too early | CI becomes brittle or misleading for Windows and WSL setup | Start with structure and link checks; defer command execution until runner assumptions are settled |

## Open questions

None blocking proposal review.

Resolved decisions to carry into the downstream spec:

- The template remains a plain Markdown file at `docs/templates/how-to-guide.md`.
- The metadata block is visible in the rendered guide body; YAML frontmatter can exist for repository metadata but is not the reader-facing substitute for prerequisites, time, outcome, and verification.
- `Scope` and `Safety` are conditional metadata lines for state-changing, security-sensitive, persistent, or environment-dependent guides.
- A dedicated `Rollback` section is expected for persistent machine-changing guides and can be omitted for read-only or verification-only guides.
- The final `Troubleshooting` section is a short symptom router; deep recovery stays in `docs/troubleshooting/`.
- `proxy-setup.md` remains the reference exemplar for validating the template shape.
- `docs/guides/03-ubuntu-baseline.md` is the portability pilot used to avoid circular validation.
- CI begins with structural and link checks, not command execution.

## Decision log

| Date | Decision | Reason | Alternatives rejected |
| --- | --- | --- | --- |
| 2026-06-15 | Create a follow-on template proposal instead of superseding the accepted guide-structure proposal | The previous proposal already settled the two-speed guide architecture; this change narrows the authoring contract | Rewriting or replacing the accepted proposal |
| 2026-06-15 | Use a small required core plus conditional safety modules | Keeps simple guides light while protecting risky setup tasks | Headings-only template; strict all-sections-required template |
| 2026-06-15 | Keep the template in plain Markdown at `docs/templates/how-to-guide.md` | It is easy to copy, review, and render on GitHub | Generated scaffolder first; template inside `docs/guides/` |
| 2026-06-15 | Use visible guide metadata in the rendered body | Readers need prerequisites, outcome, and verification without inspecting source frontmatter | YAML-only metadata |
| 2026-06-15 | Require explicit command execution context | Windows and WSL guides often switch shells and paths | Inferring context from code fence language alone |
| 2026-06-15 | Use expected result text near meaningful commands | Readers need immediate feedback before later steps fail | Verification only at the end of the guide |
| 2026-06-15 | Make rollback required for persistent machine-changing guides | WSL, sudoers, mounts, profiles, and editor runtime changes need recovery paths | Optional rollback everywhere; no rollback section |
| 2026-06-15 | Keep troubleshooting links inline and keep deep recovery separate | Readers need failure-point routing without turning guides into troubleshooting pages | Bottom-only troubleshooting links; guide-local deep recovery |
| 2026-06-15 | Start validation with structure and link checks | These checks are useful without needing a Windows and WSL execution runner | First-slice command execution CI |
| 2026-06-15 | Use `proxy-setup.md` as the reference exemplar and `docs/guides/03-ubuntu-baseline.md` as the portability pilot | `proxy-setup.md` shaped the template, so using it alone would be circular; `03-ubuntu-baseline.md` tests whether the template transfers to a different guide type | Using only `proxy-setup.md`; starting with a generated scaffolder |

## Initial intent preservation

| Initial user goal | Proposal treatment | Where recorded |
| --- | --- | --- |
| Continue work from `2026-06-07-guides-two-speed-how-to-structure.md` | in scope | Problem, Context, Decision log |
| Account for the fact that one document from that proposal changed | in scope | Problem, Context, Rollout and rollback |
| Make the reusable template follow best practices | in scope | Goals, Recommended direction, Testing and verification strategy |
| Create a proposal instead of jumping directly to implementation | in scope | Status, Options considered, Next artifacts, Readiness |
| Preserve the two-speed guide direction | in scope | Goals, Recommended direction, Decision log |
| Use the current `proxy-setup.md` reference exemplar shape as evidence | in scope | Problem, Context, Testing and verification strategy |
| Avoid circular pilot validation | in scope | Context, Testing and verification strategy, Decision log |
| Keep troubleshooting separate but connected at failure points | in scope | Goals, Recommended direction, Risks and mitigations |
| Keep guides optimized for quick configuration | in scope | Goals, Recommended direction, Expected behavior changes |
| Avoid turning how-to guides into tutorials | in scope | Non-goals, Recommended direction, Risks and mitigations |
| Prepare for later validation without overbuilding CI | in scope | Testing and verification strategy, Scope budget |

## Scope budget

| Work item | Treatment | Reason |
| --- | --- | --- |
| Best-practice guide template policy | core to this proposal | The proposal exists to define the authoring contract for how-to guides |
| Required core template sections | core to this proposal | Fast path, walkthrough, metadata, expected results, and inline troubleshooting are the stable shape |
| Conditional safety modules | core to this proposal | Machine-changing setup guides need scope, safety, backup, and rollback without burdening simple guides |
| Command-block conventions | core to this proposal | Windows and WSL instructions need unambiguous shell and path context |
| Fast-path and walkthrough parity | core to this proposal | The two-speed model fails if the two sections drift or tell different stories |
| Troubleshooting link policy | core to this proposal | The accepted guide proposal depends on failure-point links into separate troubleshooting docs |
| `proxy-setup.md` reference exemplar review | first-slice candidate | The exemplar is the best current guide for testing the demanding parts of the template shape |
| `docs/guides/03-ubuntu-baseline.md` portability pilot validation | first-slice candidate | A second guide checks that the template works beyond the source exemplar |
| `docs/templates/how-to-guide.md` creation or revision | first-slice candidate | The proposal should lead to a concrete reusable template after review and spec |
| Documentation structure checks | first-slice candidate | Static checks can enforce stable headings and link targets once the template is settled |
| Command execution checks | deferable follow-up | They need stable command specs and a Windows and WSL runner model |
| Generated guide scaffolder | deferable follow-up | It may help later but is premature before several manual guides use the template |
| Full conversion of all first-slice guides | separate implementation slice | Broad conversion should wait until the template works on the pilot |
| Tutorial content for beginners | out of scope | `docs/guides/` remains how-to documentation, not tutorial documentation |
| Design rationale migration into guides | out of scope | Rationale belongs in ADRs and architecture notes with short links from guides |

## Next artifacts

- `docs/changes/2026-06-15-how-to-guide-template-best-practices/reviews/proposal-review.md` for proposal review.
- `specs/how-to-guide-template-best-practices.md` for the guide-template requirements after proposal review.
- `specs/how-to-guide-template-best-practices.test.md` for structure, link, and review-check coverage.
- `docs/templates/how-to-guide.md` for the reusable template after proposal and spec work.
- `tests/markdown/how-to-guide-template-best-practices.test.sh` for lightweight structure and link checks after the test spec is approved.
- `docs/guides/proxy-setup.md` revision or conformance review as the reference exemplar after template settlement.
- `docs/guides/03-ubuntu-baseline.md` conformance review as the portability pilot after template settlement.

## Follow-on artifacts

- `docs/changes/2026-06-15-how-to-guide-template-best-practices/reviews/proposal-review.md`
- `specs/how-to-guide-template-best-practices.md`

## Readiness

Accepted after proposal review.

Ready for downstream spec authoring. The downstream spec should define the exact template sections, conditional-module rules, command-block conventions, and validation checks before guide-template implementation begins.
