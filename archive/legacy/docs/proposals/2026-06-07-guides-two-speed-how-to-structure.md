---
id: 2026-06-07-guides-two-speed-how-to-structure
title: Two-Speed How-To Guide Structure for Terminal-First Windows Dev
status: accepted
created: 2026-06-07
repo: xiongxianfei/terminal-first-windows-dev
proposal_path: docs/proposals/2026-06-07-guides-two-speed-how-to-structure.md
related:
  - docs/proposals/2026-05-24-bootstrap-terminal-first-windows-dev.md
---

# Two-Speed How-To Guide Structure for Terminal-First Windows Dev

## Status

accepted

## Problem

The project needs `docs/guides/` to help readers configure a terminal-first Windows development workstation quickly. The current setup scope includes Windows Terminal, PowerShell, WSL2 Ubuntu, proxy behavior, WSL storage and mounts, locale checks, Neovim, and tmux. These topics can easily turn into long tutorial-style documents that explain too much before the reader can act.

This is preemptive structure for guides that will be written next, not remediation of a current guide that has already failed readers. The trigger is the maintainer's stated direction for `docs/guides/`: make them how-to documentation optimized for "configure it quickly," while preserving separate troubleshooting. Because the first setup slice includes machine-sensitive topics, the project should settle the guide shape before those topics harden into inconsistent long-form pages.

The reader intent for a how-to guide is usually task completion: configure the thing, verify it worked, and leave. A guide that mixes commands, background, troubleshooting, rationale, and design history forces experienced readers to scroll through prose and makes new readers unsure which path is the happy path.

Troubleshooting should remain separate because problem-solving is a different reading mode. However, a separate troubleshooting directory only helps if guides link to the right troubleshooting anchor at the exact step where failure commonly occurs. A generic link at the end is too late.

This proposal records a documentation structure that preserves quick configuration, keeps deeper explanations out of the happy path, and creates a consistent guide shape that contributors can reuse.

## Goals

- Define `docs/guides/` as task-oriented how-to documentation rather than tutorial, reference, or design-rationale documentation.
- Adopt a two-speed guide structure: a short fast path near the top and an expanded walkthrough below it in the same file.
- Make each guide skimmable through consistent frontmatter-style metadata: prerequisites, estimated time, outcome, and verification command.
- Lead each guide title with the desired outcome, not the abstract topic.
- Use numbered steps so readers can report where a guide failed.
- Treat code blocks and commands as first-class content in how-to guides.
- Put verification near every meaningful step so users can detect failure early.
- Preserve a separate `docs/troubleshooting/` area for deeper recovery instructions.
- Link from guide steps to troubleshooting anchors inline at likely failure points.
- Add `docs/guides/README.md` as an intent router rather than a passive table of contents.
- Prefer small task-scoped guides over one large linear guide for the main documentation set.
- Keep design rationale in ADRs or architecture notes, with brief links from guides when needed.

## Non-goals

- Rewriting every setup guide in this proposal stage.
- Defining the exact PowerShell, WSL, Neovim, tmux, proxy, sudoers, or mount commands in this proposal.
- Replacing existing troubleshooting content with guide-local recovery sections.
- Creating a full tutorial series for beginners inside `docs/guides/`.
- Creating a generated documentation system or custom static-site toolchain in the first slice.
- Solving every corporate proxy, PAC, VPN, and certificate issue as part of the guide-structure change.
- Moving ADR or architecture rationale into how-to guides.
- Creating a one-command installer to compensate for guide complexity.

## Vision fit

fits the current vision

This proposal fits the terminal-first workstation vision because it makes the repository easier to use as a practical setup playbook without turning it into an opaque installer. It also supports the earlier documentation-first direction by defining how the documentation should be shaped before more setup content is added.

This proposal assumes the project-local vision and workflow artifacts from the active change set exist when the proposal is committed. If the repository branch receiving this proposal lacks `VISION.md`, the standing-artifact gate should be resolved before treating this as an accepted substantive proposal.

## Context

`terminal-first-windows-dev` is a public setup guide for a terminal-centered Windows development environment. Its first workstation slice already includes several machine-sensitive areas: WSL install location, Windows drive mount behavior, automatic proxy mirroring, passwordless sudo, locale checks, shared Neovim configuration, and tmux configuration.

Those topics need detailed specifications and rollback guidance, but most readers opening `docs/guides/` will not be looking for design history. They will be trying to complete one task:

- set up a fresh workstation;
- configure an existing WSL distro;
- make proxy/networking work;
- mount shared data;
- install Neovim;
- install tmux;
- verify that the setup is healthy;
- recover from a specific error.

The current proposal keeps the troubleshooting split intact. Guides route readers to troubleshooting only when the user hits a failure condition. This keeps the happy path short while still giving the project a place for deeper diagnostics and recovery.

## Options considered

### Option 0: Lightweight style guide and template only

Publish a short style guide and a reusable `_template.md`, then let guide authors apply the pattern informally without a proposal-backed spec, test specification, or structure checks.

Pros:

- Lowest ceremony and fastest to start writing guides.
- Keeps the project documentation-first and plain Markdown.
- Lets the template evolve through real guide authoring before enforcement.
- Avoids creating validation tooling before the guide pattern proves useful.

Cons:

- Easy for guides to drift because the policy is advisory only.
- Troubleshooting anchors and inline links may remain inconsistent.
- Reviewers lack a durable decision record when challenging explanation-heavy guide prose.
- The router README can regress into a table of contents without a documented intent-routing rule.

Rejected for the first guide-structure decision because the project is about to add several security-sensitive and machine-sensitive setup topics. A lightweight template may still be the simplest implementation slice, but the direction should be captured in a proposal and spec before guide conversion makes the pattern harder to revise.

### Option A: One large linear setup guide

Create one top-to-bottom setup playbook with sections for Windows host setup, WSL, Ubuntu baseline, proxy, data mount, Neovim, tmux, and verification.

Pros:

- Simple initial navigation.
- Good for a reader setting up a new machine from zero.
- Easy to see the intended sequence.

Cons:

- Poor fit for readers who only need one task.
- The file can become long enough that the fast path stops feeling fast.
- Troubleshooting links and verification can become buried.
- Contributors may keep adding explanation to the same file until it becomes a tutorial.

### Option B: Many task-scoped guides without a common structure

Split content into separate guide files such as proxy setup, Neovim setup, tmux setup, and mount setup, but let each guide choose its own format.

Pros:

- Better task targeting than one large guide.
- Easy for contributors to add new guide files.
- Good fit for search and direct links.

Cons:

- Reader experience becomes inconsistent.
- Some guides may become tutorials while others are command checklists.
- Troubleshooting links may be inconsistent or missing.
- The landing page becomes a simple list rather than a useful router.

### Option C: Many task-scoped guides with a two-speed template

Use small task-scoped guide files. Each guide follows a shared structure: outcome title, prerequisites/time/outcome/verification metadata, fast path, walkthrough, per-step verification, inline troubleshooting links, and short rollback notes where relevant.

Pros:

- Fast for experienced readers.
- Still supportive for newer readers.
- Keeps troubleshooting separate but discoverable at the failure point.
- Encourages consistent contribution quality.
- Works for both fresh setup and one-off configuration tasks.
- Keeps the repository aligned with documentation-first setup rather than hidden automation.

Cons:

- Requires discipline during review.
- Repeated commands in fast path and walkthrough can drift if not checked.
- The router README becomes load-bearing.
- Link anchors in troubleshooting docs need maintenance.

### Option D: Interactive or generated documentation

Create a generated guide, wizard, or script-driven documentation flow that asks questions and emits commands for the user.

Pros:

- Could produce a very short personalized path.
- Could reduce irrelevant instructions.
- Could later integrate with doctor checks.

Cons:

- Premature for a young documentation-first project.
- Adds tooling complexity before the content model is stable.
- Can hide the command contract from readers.
- Harder for contributors to review than plain Markdown.

## Recommended direction

Choose Option C: many task-scoped guides with a shared two-speed how-to template.

The simplest version that still works is a plain Markdown guide template plus a router README, with checks added only after the pilot proves the pattern. This proposal rejects a purely informal style guide as the durable direction because the guide/troubleshooting split and failure-point links need a stable contributor-visible contract.

The project should define `docs/guides/` as the place for actionable how-to documents. Each guide should place the fast path near the top and the walkthrough below it. The fast path is for experienced users who want to copy commands and verify quickly. The walkthrough repeats the same task flow with context, safety notes, and short explanations.

Troubleshooting should remain separate under `docs/troubleshooting/`. Guides should link to troubleshooting anchors inline at likely failure points, not only in a final "See also" section.

The guide landing page should route by reader intent. It should answer "what are you trying to do?" rather than merely listing files.

Recommended first guide set:

```text
docs/guides/
|-- README.md
|-- fresh-setup.md
|-- windows-terminal-setup.md
|-- powershell-setup.md
|-- wsl-ubuntu-setup.md
|-- ubuntu-baseline.md
|-- proxy-setup.md
|-- data-mount-setup.md
|-- neovim-setup.md
|-- tmux-setup.md
`-- verification.md

docs/templates/
`-- how-to-guide.md

docs/troubleshooting/
|-- README.md
|-- proxy.md
|-- wsl-storage.md
|-- data-mount.md
|-- locale.md
|-- sudo.md
|-- neovim.md
`-- tmux.md
```

The fresh setup guide can route through the task guides in sequence instead of duplicating every detail. For example, `fresh-setup.md` can say: complete Windows Terminal, PowerShell, WSL Ubuntu, Ubuntu baseline, Neovim, tmux, then verification. Each task file remains useful on its own.

The reusable guide template should live at `docs/templates/how-to-guide.md`. This keeps contributor-facing meta content separate from actual reader-facing guide content while preserving a copyable Markdown file that can be reviewed like other documentation.

Task-scoped guide filenames should stay stable and unnumbered. Sequence belongs in `fresh-setup.md` and `docs/guides/README.md`, because reading order depends on reader intent and should not be encoded into every filename.

Recommended guide skeleton:

````markdown
# Configure WSL automatic proxy

**Prerequisites:** WSL2 + Ubuntu installed; Windows proxy configured.
**Time:** ~5 minutes.
**Outcome:** Ubuntu uses the Windows proxy through WSL automatic proxy mirroring.
**Verify:** `curl -I https://github.com` succeeds from Ubuntu.

## Fast path

1. Enable WSL automatic proxy mirroring in `%UserProfile%\.wslconfig`.

   ```ini
   [wsl2]
   autoProxy=true
   ```

2. Restart WSL.

   ```powershell
   wsl --shutdown
   ```

3. Verify network access from Ubuntu.

   ```bash
   curl -I https://github.com
   ```

   Expected result: an HTTP response header is printed.

   If this fails with a certificate error, see [`docs/troubleshooting/proxy.md#certificate-not-trusted`](../troubleshooting/proxy.md#certificate-not-trusted).

## Walkthrough

### 1. Enable WSL automatic proxy mirroring

Add the following entry to `%UserProfile%\.wslconfig`:

```ini
[wsl2]
autoProxy=true
```

This lets WSL read the Windows HTTP proxy configuration instead of requiring a separate Linux-only proxy setup.

Safety note: this changes WSL networking behavior for the current Windows user after WSL restarts. It does not change Ubuntu package sources, certificate trust, or Windows system proxy settings.

Verify the file exists:

```powershell
Test-Path "$env:USERPROFILE\.wslconfig"
```

Expected result: `True`.

### 2. Restart WSL

Run:

```powershell
wsl --shutdown
```

Then open Ubuntu again from Windows Terminal.

This restart is required because `.wslconfig` is read when the WSL virtual machine starts. Existing Ubuntu shells will not see the new setting until WSL has shut down and started again.

### 3. Verify network access

Run:

```bash
curl -I https://github.com
```

Expected result: an HTTP response header is printed.

If this fails, use the targeted troubleshooting entry that matches the symptom. Start with the symptom rather than changing multiple proxy settings at once:

- Certificate error: [`docs/troubleshooting/proxy.md#certificate-not-trusted`](../troubleshooting/proxy.md#certificate-not-trusted)
- Timeout: [`docs/troubleshooting/proxy.md#proxy-timeout`](../troubleshooting/proxy.md#proxy-timeout)
- DNS failure: [`docs/troubleshooting/proxy.md#dns-failure`](../troubleshooting/proxy.md#dns-failure)
````

## Expected behavior changes

After this proposal is implemented through downstream specs and plans:

- `docs/guides/README.md` routes readers by intent instead of acting as a flat table of contents.
- Each how-to guide starts with prerequisites, time, outcome, and verification.
- Each how-to guide has a `Fast path` section near the top.
- Each how-to guide has a `Walkthrough` section with the same task flow and more context.
- Steps are numbered rather than presented as loose bullet lists.
- Verification appears close to the step it verifies.
- Troubleshooting links appear inline at likely failure points.
- Explanations that justify design decisions are brief and link to ADRs or architecture docs when deeper rationale is needed.
- The fresh setup path becomes a routed sequence through task guides rather than one large document that duplicates every section.

## Architecture impact

This proposal affects documentation architecture rather than runtime architecture.

Expected repository surfaces:

```text
docs/guides/README.md               # reader-intent router
docs/guides/*.md                    # task-scoped how-to guides
docs/templates/how-to-guide.md      # reusable contributor-facing guide template
docs/troubleshooting/README.md      # problem-oriented router
docs/troubleshooting/*.md           # deep recovery entries
docs/adr/*.md                       # design rationale linked from guides
docs/architecture/system/*.md       # architecture rationale linked from guides
specs/*                             # future guide-structure requirements and checks
tests/docs/*                        # future documentation structure and link checks
```

Boundary rules:

- Guides explain how to complete a task.
- Troubleshooting explains how to recover when a task fails.
- ADRs explain why a durable design choice was made.
- Architecture explains system boundaries and state-changing surfaces.
- Specs define detailed requirements for guide structure and validation.
- Plans define implementation milestones after proposal and spec review.

This split reduces explanation creep in guides while preserving traceability for contributors.

## Testing and verification strategy

The downstream spec should define documentation checks that make the guide shape reviewable without overbuilding a docs platform.

Likely validation layers:

- Static Markdown linting for headings, lists, and link formatting.
- Link checking for guide-to-troubleshooting anchors.
- A lightweight structure check that verifies each guide includes the expected sections: prerequisites/time/outcome/verification metadata, `Fast path`, and `Walkthrough`.
- Review checklist coverage for numbered steps, commands-first structure, and inline troubleshooting links.
- Sample reader-path checks for common intents: fresh setup, existing WSL proxy setup, Neovim setup, tmux setup, and broken proxy recovery.
- A concrete pilot benefit check: a maintainer should run a timed self-walkthrough of the pilot guide's fast path from a documented starting state, record whether the task can be completed without reading the walkthrough, and note any step where the fast path lacks enough safety or verification context.
- Advisory command review before code-block execution tests: authors should attest that command blocks were run or manually reviewed against expected output where practical, while CI initially enforces stable shape and links rather than command correctness.
- Optional script or CI checks for code blocks only after command specs, the test runner environment, and at least one advisory-missed regression justify the added infrastructure.

Manual review should check whether a reader can answer these questions within a few seconds of opening a guide:

1. Is this guide for my task?
2. What will be true when I finish?
3. What commands do I run first?
4. How do I know it worked?
5. Where do I go if this exact step fails?

## Rollout and rollback

Rollout:

- Add this proposal under `docs/proposals/`.
- After review, create a guide-structure spec for the how-to template, router behavior, and troubleshooting link policy.
- Add or update `docs/guides/README.md` as the router.
- Add `docs/templates/how-to-guide.md` as the reusable how-to template.
- Convert `proxy-setup.md` as the pilot guide because it exercises prerequisites, environmental variance, multi-step verification, and multiple inline troubleshooting links.
- Review the pilot for skimmability, troubleshooting-link placement, and whether the fast path can complete the task from the documented prerequisites without using the walkthrough.
- Apply the pattern to the remaining first-slice guides.
- Add lightweight documentation checks after the pattern is stable enough to enforce.

Rollback:

- Revert the guide-structure proposal and downstream guide changes if the pattern proves too heavy.
- Keep old guide paths redirected or linked during transition when readers may already have bookmarks.
- If the two-speed template causes duplication drift, keep the task-scoped guide split but revise the template before converting more guides.
- If the router README becomes too complex, reduce it to fewer intent categories while keeping task-scoped guides.

## Risks and mitigations

| Risk | Impact | Mitigation |
| --- | --- | --- |
| Fast path and walkthrough commands drift | Readers may run inconsistent instructions | Review for step parity; prefer the same numbered task flow in both sections; add documentation checks later if useful |
| The fast path becomes too long | Experienced readers lose the quick-configuration benefit | Keep fast path to the minimum commands and verification; move explanation to walkthrough |
| Walkthrough becomes a tutorial | Guides become slow to skim | Link deeper rationale to ADRs or architecture docs; keep guide prose task-focused |
| Troubleshooting links clutter the happy path | Guides become noisy | Use short parenthetical or sentence-level links only where failures commonly occur |
| Troubleshooting anchors break | Readers hit dead links when already blocked | Add link checking for relative links and anchors |
| Too many small guides fragment the fresh setup experience | New users may not know the sequence | Make `docs/guides/README.md` and `fresh-setup.md` explicit routers |
| The router README becomes a table of contents | Readers still have to interpret the file list themselves | Organize the router by intent statements such as "I want to..." |
| Contributors add explanation-heavy content to guides | Documentation style becomes inconsistent | Add a guide template and review checklist |
| The pattern delays content writing | Structure work slows useful setup docs | Convert one pilot guide first, then apply only where it improves usability |
| Some tasks are inherently long or risky | The fast path may understate safety concerns | Keep warnings short but visible before dangerous commands, especially sudoers, fstab, and WSL storage changes |

## Open questions

None blocking proposal review.

Resolved owner decisions to carry into the spec:

- The reusable how-to template lives at `docs/templates/how-to-guide.md`.
- Task-scoped guide filenames stay unnumbered; sequence is expressed by `fresh-setup.md` and the router README.
- Code-block validation starts as advisory review guidance; CI should enforce structural and link checks first, and command execution checks only after the command surface and runner environment stabilize.
- `proxy-setup.md` is the pilot conversion.

## Decision log

| Date | Decision | Reason | Alternatives rejected |
| --- | --- | --- | --- |
| 2026-06-07 | Define `docs/guides/` as how-to documentation | Readers use guides to complete tasks quickly | Treating guides as tutorials, reference pages, or ADR summaries |
| 2026-06-07 | Reject an informal style-guide-only approach as the durable direction | The project needs a contributor-visible contract before sensitive setup topics spread across guides | No documented policy; template without proposal or spec |
| 2026-06-07 | Use a two-speed structure in each guide | Experienced readers need a fast path; newer readers need context | Fast path only; walkthrough only; separate quickstart and deep-dive files for every task |
| 2026-06-07 | Accept limited command repetition between fast path and walkthrough | Parallel scanning is clearer for readers than forcing one section to depend on the other | Single-source command blocks only; walkthrough as references back to fast-path steps |
| 2026-06-07 | Keep troubleshooting separate but link inline at failure points | Troubleshooting is a distinct reader mode, but users need the link where failure occurs | Putting all troubleshooting at the bottom of each guide; only linking to troubleshooting from the README |
| 2026-06-07 | Add a guide router README organized by intent | Readers choose by situation, not by internal file taxonomy | Flat table of contents; relying on filename guessing |
| 2026-06-07 | Prefer many task-scoped guides over one large guide | The repo supports both fresh setup and targeted configuration tasks | One monolithic setup playbook |
| 2026-06-07 | Put the reusable template under `docs/templates/how-to-guide.md` | Templates are contributor-facing meta content, not reader-facing guides | `docs/guides/_template.md`; embedded template inside contributor docs |
| 2026-06-07 | Keep task-scoped guide filenames unnumbered | Filenames should remain stable identifiers; reader-specific order belongs in routers | Numbering every first-slice guide |
| 2026-06-07 | Start code-block validation as advisory review guidance | Command execution CI is premature until command specs and a Windows + WSL runner model stabilize | First-slice command execution CI |
| 2026-06-07 | Use `proxy-setup.md` as the pilot conversion | Proxy setup stress-tests prerequisites, verification, environmental variance, and inline troubleshooting links | `tmux-setup.md`; `neovim-setup.md` |
| 2026-06-07 | Keep design rationale out of how-to prose | Guides should stay actionable and skimmable | Embedding long "why" sections in guide steps |

## Initial intent preservation

| Initial user goal | Proposal treatment | Where recorded |
| --- | --- | --- |
| Make `docs/guides/` how-to documentation | in scope | Goals, Recommended direction, Decision log |
| Optimize for "configure it quickly" | in scope | Problem, Goals, Recommended direction |
| Preserve the troubleshooting split | in scope | Goals, Recommended direction, Architecture impact |
| Use a two-speed structure | in scope | Goals, Recommended direction, Expected behavior changes |
| Put a fast path at the top of each guide | in scope | Goals, Recommended direction, Expected behavior changes |
| Put a walkthrough below the fast path | in scope | Goals, Recommended direction, Expected behavior changes |
| Use frontmatter-style metadata for prerequisites, time, outcome, and verification | in scope | Goals, Recommended direction, Testing and verification strategy |
| Link troubleshooting inline at likely failure points | in scope | Goals, Recommended direction, Risks and mitigations |
| Lead with outcomes rather than topics | in scope | Goals, Expected behavior changes |
| Number every step | in scope | Goals, Expected behavior changes |
| Treat code blocks as first-class guide content | in scope | Goals, Expected behavior changes |
| Add verification for each meaningful step | in scope | Goals, Testing and verification strategy |
| Avoid explanation creep in how-to guides | in scope | Goals, Non-goals, Decision log |
| Add a router-style `docs/guides/README.md` | in scope | Goals, Recommended direction, Architecture impact |
| Decide between one large guide and many small guides | in scope | Options considered, Recommended direction, Decision log |
| Prefer many small task-scoped guides for this project | in scope | Recommended direction, Architecture impact, Decision log |
| Place the how-to template under `docs/templates/how-to-guide.md` | in scope | Recommended direction, Architecture impact, Decision log |
| Keep task guide filenames unnumbered except sequence-specific routing | in scope | Recommended direction, Open questions, Decision log |
| Start code-block validation as advisory review guidance | in scope | Testing and verification strategy, Scope budget, Decision log |
| Use proxy setup as the pilot conversion | in scope | Rollout and rollback, Decision log |

## Scope budget

| Work item | Treatment | Reason |
| --- | --- | --- |
| Guide information architecture policy | core to this proposal | The proposal primarily decides how `docs/guides/` and `docs/troubleshooting/` should relate |
| Two-speed how-to template | core to this proposal | The template is the main mechanism for quick configuration plus context |
| `docs/templates/how-to-guide.md` placement | core to this proposal | Template placement separates contributor-facing meta content from reader-facing guides |
| `docs/guides/README.md` intent router | core to this proposal | The router makes many task-scoped guides usable |
| Inline troubleshooting link policy | core to this proposal | It preserves the troubleshooting split while fixing failure-point navigation |
| Task-scoped guide split | core to this proposal | The proposal chooses small task guides over one large guide |
| Troubleshooting anchor taxonomy | same-slice dependency | Inline links need stable anchors to be useful |
| `proxy-setup.md` pilot guide conversion | first-slice candidate | Proxy setup stresses prerequisites, environmental variance, verification, and inline troubleshooting links |
| Conversion of all first-slice setup guides | separate implementation slice | Full migration is implementation work after the proposal and spec settle |
| Documentation structure checks | first-slice candidate | Checks help preserve the guide shape after adoption |
| Code-block execution tests | deferable follow-up | Useful later, but exact command validation belongs after command specs stabilize |
| Static-site generation or custom docs tooling | out of scope | The first slice should work with plain Markdown in GitHub |
| Tutorial-style background content | out of scope | Background belongs in tutorials, ADRs, architecture docs, or troubleshooting when relevant |

## Next artifacts

- `docs/changes/2026-06-07-guides-two-speed-how-to-structure/reviews/proposal-review.md` for proposal review.
- `specs/guides-two-speed-how-to-structure.md` for guide-structure requirements after proposal review.
- `specs/guides-two-speed-how-to-structure.test.md` for documentation structure, link, and review-check coverage.
- `docs/architecture/system/architecture.md` update if the canonical architecture needs to record documentation-boundary changes.
- `docs/adr/2026-06-07-guide-information-architecture.md` only if the project wants the guide/troubleshooting/ADR split recorded as a durable architecture decision.
- `docs/plans/2026-06-07-guides-two-speed-how-to-structure.md` after proposal review and spec work.

## Follow-on artifacts

None yet

## Readiness

Accepted after formal proposal review.

Ready for guide-structure spec authoring. Not ready for implementation planning until the spec and required downstream review are complete.
