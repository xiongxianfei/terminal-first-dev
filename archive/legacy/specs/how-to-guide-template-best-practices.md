# How-To Guide Template Best Practices Spec

## Status

approved

## Related proposal

- Proposal: `docs/proposals/2026-06-15-how-to-guide-template-best-practices.md`
- Proposal review: `docs/changes/2026-06-15-how-to-guide-template-best-practices/reviews/proposal-review.md`
- Upstream structure spec: `specs/guides-two-speed-how-to-structure.md`
- Reference exemplar: `docs/guides/proxy-setup.md`
- Portability pilot: `docs/guides/03-ubuntu-baseline.md`
- Target template: `docs/templates/how-to-guide.md`

## Goal and context

This spec defines the observable authoring contract for the reusable how-to guide template at `docs/templates/how-to-guide.md`.

The accepted two-speed guide structure already establishes that `docs/guides/` contains task-scoped how-to guides with a `Fast path` followed by a `Walkthrough`, separate troubleshooting, and an intent router. This spec narrows that direction into the concrete template and review contract contributors use when creating or revising guides.

The template must help authors produce concise terminal-first Windows 11 and WSL setup guides that are quick to act on, explicit about command context, clear about expected results, and safe around persistent or security-sensitive machine changes. It must remain plain Markdown and must not introduce a generated documentation system, command-execution CI, or hidden setup automation.

## Glossary

- Guide: a reader-facing how-to document under `docs/guides/`.
- Template: the contributor-facing copyable Markdown artifact at `docs/templates/how-to-guide.md`.
- Reference exemplar: `docs/guides/proxy-setup.md`, the existing guide whose shape informs the template.
- Portability pilot: `docs/guides/03-ubuntu-baseline.md`, the separate guide used to check that the template works beyond the reference exemplar.
- Visible metadata block: reader-facing lines near the top of a guide for prerequisites, time, outcome, verification, and conditional scope or safety notes.
- Fast path: the short command-forward section near the top of a guide for experienced readers.
- Walkthrough: the expanded section after the fast path with the same high-level step order plus necessary context, safety, backup, rollback, and troubleshooting details.
- Command context: the explicit execution environment for a command or snippet, such as Windows PowerShell, Ubuntu, inside Neovim, inside tmux, or a configuration file.
- Meaningful command: a command or configuration snippet that changes state, verifies state, or is necessary to complete the guide outcome.
- State-changing guide: a guide that changes Windows, WSL, Ubuntu, shell, editor, tmux, storage, proxy, identity, package-source, or security-sensitive state.
- Troubleshooting anchor: a specific heading or anchor inside `docs/troubleshooting/*.md`.
- Structure check: a static documentation check that verifies stable sections, metadata, links, and anchors without executing setup commands.

### Backup guidance

Backup guidance is the reader-visible instruction that preserves the previous user or system state before a guide edits it.

For this spec, backup guidance is sufficient when it identifies:

- the target file, directory, or persistent state being changed;
- whether a backup is required or not applicable;
- the backup action to perform before the edit, or the reason no backup is needed;
- the rollback or restore path, either inline or by linking to the guide's rollback section.

A backup statement is not sufficient if it appears only after the command or step that performs the edit, unless an earlier statement explicitly says backup is not applicable.

User-owned files include files under the current user's profile or home directory, such as `%UserProfile%`, `$HOME`, `~`, shell profiles, editor configuration, tmux configuration, and user-local WSL configuration.

System-owned files include machine-wide or root-owned files such as `/etc/*`, sudoers drop-ins, fstab entries, machine-wide package configuration, and other files that require elevated privileges or affect more than one user.

## Examples first

Example E1: contributor copies the canonical template
Given a contributor is creating a new guide under `docs/guides/`
When they open `docs/templates/how-to-guide.md`
Then the template shows the required metadata block, `Fast path`, `Walkthrough`, expected result text, inline troubleshooting link shape, and conditional safety modules.

Example E2: experienced reader follows only the fast path
Given a guide's stated prerequisites match the reader's Windows 11 and WSL Ubuntu machine
When the reader follows only `Fast path`
Then the guide provides command context, commands or snippets, expected results, and verification sufficient to know whether the task succeeded.

Example E3: newer reader uses the walkthrough
Given a reader wants context before changing Ubuntu setup state
When the reader follows `Walkthrough`
Then the walkthrough uses the same high-level step order as the fast path and adds only task-relevant context, safety notes, backup, rollback, verification, and failure-point troubleshooting links.

Example E4: state-changing guide exposes recovery
Given a guide changes persistent WSL, Ubuntu, shell, editor, tmux, storage, proxy, sudoers, fstab, or package-source state
When the guide is rendered on GitHub
Then the reader can see scope, safety when relevant, backup guidance before risky edits, and a dedicated `Rollback` section before they rely on the guide.

Example E5: troubleshooting stays separate
Given a command can fail with a known certificate, proxy, mount, sudo, locale, Neovim, or tmux symptom
When the guide reaches the likely failure point
Then the guide links inline to the matching `docs/troubleshooting/*.md#anchor` entry and does not embed deep recovery branches in the guide.

Example E6: portability pilot avoids circular validation
Given `proxy-setup.md` is the reference exemplar for the template shape
When the template is checked against a second guide
Then `docs/guides/03-ubuntu-baseline.md` is reviewed as the portability pilot so the validation does not rely only on the guide that shaped the template.

## Requirements

R1. `docs/templates/how-to-guide.md` MUST be the canonical reusable template for new how-to guides under `docs/guides/`.

R2. The template MUST be plain Markdown that can be copied without a generator, scaffolder, or custom documentation build step.

R3. The template MUST distinguish contributor guidance from publishable guide content by using removable HTML comments or clearly labeled contributor notes.

R4. Contributor notes in the template MUST identify which sections are required for every guide and which sections are conditional.

R5. The template MUST include an outcome-led H1 placeholder that starts with a task verb or equivalent task outcome.

R6. The template MUST include a visible metadata block before the first setup command.

R7. The visible metadata block MUST include `Prerequisites`, `Time`, `Outcome`, and `Verify`.

R8. The visible metadata block MUST include `Scope` as a conditional line for state-changing or environment-sensitive guides.

R9. The visible metadata block MUST include `Safety` as a conditional line for destructive, security-sensitive, persistent, or hard-to-undo changes.

R10. The template MUST include a `## Fast path` section before `## Walkthrough`.

R11. The template MUST include a `## Walkthrough` section after `## Fast path`.

R12. The template MUST include a `## Rollback` section and state that it is required for persistent machine-changing guides.

R13. The template MUST include a `## Troubleshooting` section that acts as a symptom router rather than a deep recovery section.

R14. The template MUST show numbered ordered steps for procedural content.

R15. The template MUST show explicit command context before each command block that could be run in the wrong environment.

R16. The template MUST show expected result text after each meaningful command or verification command.

R17. The template MUST show inline troubleshooting links at likely failure points using relative links to `../troubleshooting/<topic>.md#<anchor>`.

R18. The reusable how-to template MUST include a conditional state-changing step module that shows `Scope`, `Backup`, and `Rollback` fields. The `Backup` field MUST be placed before the command, editor instruction, or configuration snippet that changes user-owned or system-owned files. The template notes MUST tell authors that published guides either provide backup guidance before the edit or change, or explicitly state why backup is not applicable.

R19. The template MUST state that fast path and walkthrough should use the same high-level step order unless an alternative path is explicitly labeled.

R20. The template MUST state that deep troubleshooting belongs under `docs/troubleshooting/`, not inside the guide happy path.

R21. The template MUST state that durable design rationale belongs in ADRs or architecture notes and should be linked only when task-relevant.

R22. The command-block conventions MUST use `powershell` for Windows PowerShell or PowerShell 7 commands.

R23. The command-block conventions MUST use `bash` for Ubuntu shell commands.

R24. The command-block conventions SHOULD use `ini`, `toml`, `lua`, or `tmux` for configuration snippets when the snippet type matches those languages.

R25. The command-block conventions MUST state that Windows and Ubuntu commands are not mixed in one code block.

R26. The command-block conventions MUST require placeholders, such as `<UbuntuUser>`, to be defined before use.

R27. The command-block conventions MUST prohibit examples that expose secrets, proxy credentials, tokens, private hostnames, or private certificate material.

R28. The command-block conventions SHOULD prefer commands that can be re-run safely.

R29. The command-block conventions MUST require commands that are not safe to re-run to be labeled with the relevant caution before the command.

R30. A published guide created from the template MUST remove unneeded contributor-only comments and placeholders before being considered conformant.

R31. A published guide conforming to this template MUST keep the visible metadata block near the top and before the first setup command.

R32. A published guide conforming to this template MUST include `Fast path` and `Walkthrough` sections in that order.

R33. A published guide conforming to this template MUST provide explicit command context for each meaningful command or configuration snippet.

R34. A published guide conforming to this template MUST provide expected result text near each meaningful command or verification command.

R35. A state-changing published guide conforming to this template MUST include scope and rollback guidance.

R35a. A published guide that edits user-owned or system-owned files, or describes a hard-to-undo persistent state change, MUST include backup guidance before the edit or change in every path that instructs the reader to perform it, or explicitly state why backup is not applicable.

Notes:

- "Every path" includes both `Fast path` and `Walkthrough` when both sections show the edit or change.
- Backup guidance may be short in the fast path, but it must be visible before the edit or change.
- A not-applicable statement is acceptable only when it is specific, such as creating a new disposable project-owned file with no prior user state, or changing only an ephemeral shell session.
- A generic "use rollback if needed" sentence is not a substitute for backup guidance before a file edit.

R36. A published guide that touches security, persistence, storage, identity, proxy, sudoers, fstab, WSL global configuration, package sources, execution policy, trust stores, or editor runtime state MUST include safety guidance near the affected command or metadata block.

R37. A published guide conforming to this template MUST place inline troubleshooting links at likely failure points when matching troubleshooting anchors exist.

R38. A published guide conforming to this template MUST NOT replace separate troubleshooting content with long guide-local recovery branches.

R39. A published guide conforming to this template MUST keep walkthrough explanation task-relevant and avoid tutorial-style background that is not needed to complete the task safely.

R40. `docs/guides/proxy-setup.md` MUST be treated as the reference exemplar for demanding template behavior, not as the only validation pilot.

R41. `docs/guides/03-ubuntu-baseline.md` MUST be used as the first portability pilot for this template unless a later reviewed proposal or spec selects a different non-exemplar guide.

R42. Portability pilot review MUST check whether the guide can be used through its fast path without reading the walkthrough from the stated prerequisites.

R43. Portability pilot review MUST be performed by a reviewer who did not author the template, or the review record MUST state why that separation was not possible.

R44. Portability pilot review MUST use either a Windows 11 + WSL Ubuntu test machine or a documented dry-run review when that environment is unavailable.

R45. Portability pilot review MUST count fast-path validation as successful only when the guide's expected verification signal is reachable without reading the walkthrough.

R46. Static structure checks MUST verify that reader-facing guides include required visible metadata and `Fast path` and `Walkthrough` sections.

R47. Static link checks MUST verify that guide links to `docs/troubleshooting/` resolve to existing files.

R48. Static anchor checks MUST verify that troubleshooting anchors referenced by guides exist when the link includes an anchor.

R49. First-slice validation MUST NOT execute setup commands from guide code blocks.

R50. First-slice validation MUST NOT require a Windows + WSL CI runner.

R51. Command-execution validation MAY be proposed later only after command contracts and runner assumptions are specified in a later accepted artifact.

R52. The spec implementation MUST NOT change PowerShell, WSL, Ubuntu, Neovim, tmux, proxy, sudoers, fstab, mount, or package-source command semantics except where a later accepted spec authorizes that behavior change.

R53. The template implementation MUST remain compatible with the existing two-speed guide structure spec unless that earlier spec is explicitly amended through the workflow.

R54. This spec MUST NOT require renaming `docs/guides/03-ubuntu-baseline.md`; the existing path is used as a portability pilot until broader guide migration chooses final task-scoped filenames.

## Inputs and outputs

Inputs:

- Accepted proposal `docs/proposals/2026-06-15-how-to-guide-template-best-practices.md`.
- Approved proposal review `docs/changes/2026-06-15-how-to-guide-template-best-practices/reviews/proposal-review.md`.
- Existing two-speed guide structure spec `specs/guides-two-speed-how-to-structure.md`.
- Existing template `docs/templates/how-to-guide.md`.
- Existing guide exemplar `docs/guides/proxy-setup.md`.
- Existing portability pilot guide `docs/guides/03-ubuntu-baseline.md`.
- Existing troubleshooting documents under `docs/troubleshooting/`.

Outputs:

- Updated `docs/templates/how-to-guide.md` that satisfies this spec.
- Review or conformance evidence for `docs/guides/proxy-setup.md` as the reference exemplar.
- Review or conformance evidence for `docs/guides/03-ubuntu-baseline.md` as the portability pilot.
- Static checks or documented review checklist coverage for required structure, links, and anchors after the test spec is approved.
- No generated documentation system, command-execution CI, or setup-command semantic change in the first slice.

## State and invariants

- `docs/templates/how-to-guide.md` remains contributor-facing.
- `docs/guides/` remains reader-facing.
- `docs/troubleshooting/` remains the owner of deep recovery content.
- The template is a contract for shape and authoring practice, not a substitute for topic-specific command specs.
- The fast path and walkthrough remain two presentations of the same high-level task flow.
- The visible metadata block remains reader-facing and is not replaced by YAML frontmatter.
- State-changing guides expose recovery information before readers rely on the change.
- Static structure and link checks do not prove command correctness.
- The first slice keeps command execution out of CI.

## Error and boundary behavior

- If a guide has no state-changing behavior, omitted `Scope`, `Safety`, backup, or rollback content is valid only when omission does not hide a real recovery need.
- If a state-changing guide lacks rollback guidance, review MUST treat the guide as non-conformant.
- If a guide edits user-owned or system-owned files without backup guidance before the edit, and without an explicit not-applicable statement, review MUST treat the guide as non-conformant.
- If a guide shows the same file edit in both `Fast path` and `Walkthrough`, backup guidance MUST appear before the edit in both sections, or the guide MUST route the fast path to the walkthrough before the edit.
- If backup is marked not applicable, the guide MUST state the concrete reason. A bare "backup not applicable" label is not enough for hard-to-undo changes.
- If backup guidance appears only after the edit or change, review MUST treat it as missing unless earlier text explicitly made backup not applicable.
- If a guide includes contributor placeholders or template comments in published content, review MUST treat the guide as non-conformant.
- If command context is ambiguous between Windows PowerShell and Ubuntu, review MUST treat the command block as non-conformant.
- If a troubleshooting anchor does not exist, link or anchor validation MUST fail unless the same slice creates the missing anchor before completion.
- If no matching troubleshooting anchor exists for a failure point, the guide MUST NOT invent a fake anchor; it MAY use a short local failure note or defer deeper recovery to a later troubleshooting update.
- If the fast path and walkthrough diverge in high-level step order, review MUST require either realignment or an explicitly labeled alternative path.
- If a command uses or implies secrets, credentials, tokens, private hostnames, or private certificate material, review MUST reject the example unless a later security-reviewed spec defines a safe pattern.
- If `docs/guides/03-ubuntu-baseline.md` cannot serve as the portability pilot, the replacement pilot MUST be a non-exemplar guide and the reason for replacement MUST be recorded.

## Compatibility and migration

- This spec extends `specs/guides-two-speed-how-to-structure.md`; it does not supersede that spec.
- Existing accepted setup behavior remains governed by `specs/terminal-first-workstation-setup.md` and any later accepted command-specific specs.
- Existing numbered guide paths may remain during migration; this spec does not require a broad rename.
- The portability pilot uses `docs/guides/03-ubuntu-baseline.md` because that is the current repository path.
- New validation should begin with static structure, link, and anchor checks.
- Command execution checks, generated scaffolders, and broader guide conversion remain follow-up work unless later approved.

## Observability

- Structure checks SHOULD report the guide path and missing required section or metadata line.
- Link checks SHOULD report the source file, target file, and missing anchor when applicable.
- Exemplar and portability pilot reviews SHOULD record the guide path, reviewer, review mode, starting prerequisites, fast-path result, verification signal, and defects found.
- Review checklists SHOULD record whether command context, expected results, safety notes, rollback, and troubleshooting links are present where required.
- Completion notes for this change MUST report whether checks were run or why no standard check existed.

## Security and privacy

- This spec does not introduce new credentials, telemetry, authentication, authorization, or network calls.
- Template and guide examples MUST NOT include real secrets, tokens, proxy credentials, private hostnames, personal paths, private certificate material, or user-specific machine names.
- Security-sensitive commands MUST call out impact near the command or visible metadata block.
- Portability pilot and exemplar evidence MUST avoid capturing private machine data, credentials, private hostnames, tokens, or personal paths.
- The template MUST discourage pasting secrets into shell history.

## Accessibility and UX

- The template and conforming guides MUST use stable Markdown headings that are visible in GitHub's rendered outline.
- Visible metadata labels MUST use plain task language: `Prerequisites`, `Time`, `Outcome`, `Verify`, and conditional `Scope` or `Safety`.
- Inline troubleshooting links SHOULD make the failure symptom understandable from nearby text.
- Fast path content SHOULD stay command-forward and scan-friendly; explanatory paragraphs belong in the walkthrough unless a short safety warning is needed before a risky command.
- Walkthrough prose SHOULD be short enough that commands, verification, and rollback remain easy to locate.

## Performance expectations

- Static structure and link checks SHOULD run locally without requiring Windows, WSL, network access, administrator privileges, or command execution from guide code blocks.
- The template SHOULD keep the required core small enough that simple guides do not need filler sections.
- A conforming guide SHOULD let an experienced reader identify prerequisites, first action, and top-level verification from the top metadata and fast path without reading the walkthrough.

## Edge cases

EC1. A verification-only guide has no persistent state change; it still needs prerequisites, time, outcome, verification, fast path, and walkthrough, but rollback can be omitted or marked not applicable.

EC2. A one-step guide still uses a numbered step so readers can report the failure point.

EC3. A guide has separate Windows PowerShell and Ubuntu commands; the commands are split into separate code blocks with explicit context before each block.

EC4. A guide includes a configuration snippet rather than a command; the snippet uses an appropriate file-format fence and names the file or environment where it belongs.

EC5. A state-changing step is safe to re-run; the guide can say so near the command or expected result.

EC6. A state-changing step is not idempotent; the guide labels the risk before the command and provides rollback or recovery guidance.

EC7. A failure symptom has no troubleshooting anchor yet; the guide uses a short local note or same-slice troubleshooting dependency instead of linking to a fake anchor.

EC8. The portability pilot cannot be executed on a real Windows 11 + WSL Ubuntu machine; the review may use a documented dry-run review, but it must not claim command execution passed.

EC9. A contributor copies template comments into a published guide; conformance review fails until the comments are removed or converted into reader-facing content.

EC10. The reference exemplar passes but the portability pilot feels heavy or unclear; the template is revised before broad guide conversion.

EC11. A guide needs long rationale to explain a decision; the guide keeps only the task-relevant implication and links to an ADR or architecture note.

EC12. A guide touches a locally managed enterprise policy; the guide states the policy assumption in prerequisites, scope, safety, or before the affected command.

## Non-goals

- Rewriting all guides as part of this spec.
- Renaming every numbered guide path as part of this spec.
- Defining exact setup command contracts for PowerShell, WSL, Ubuntu, Neovim, tmux, proxy, sudoers, fstab, mounts, package sources, or editor runtime behavior.
- Moving deep troubleshooting into guide pages.
- Creating a generated documentation site, scaffolder, wizard, or template engine.
- Creating a one-command installer or hidden setup automation.
- Executing guide command blocks in CI during the first slice.
- Replacing ADRs, architecture notes, or specs with long guide explanations.
- Creating beginner tutorials inside `docs/guides/`.

## Acceptance criteria

AC1. `docs/templates/how-to-guide.md` exists and includes the required visible metadata block placeholders, `Fast path`, `Walkthrough`, `Rollback`, and `Troubleshooting`.

AC2. `docs/templates/how-to-guide.md` includes the required core sections and the conditional state-changing module, including `Scope`, `Backup`, and `Rollback` fields. The template places `Backup` before any example command, editor instruction, or configuration snippet that edits user-owned or system-owned files.

AC3. The template demonstrates explicit command context before command blocks that could be run in the wrong environment.

AC4. The template demonstrates expected result text near meaningful commands and verification commands.

AC5. The template demonstrates inline troubleshooting links to exact `../troubleshooting/*.md#anchor` targets.

AC6. The template documents the command-block conventions for `powershell`, `bash`, configuration fences, placeholder definition, secret avoidance, and non-idempotent command labeling.

AC7. `docs/guides/proxy-setup.md` is reviewed or checked as the reference exemplar without being treated as the only pilot.

AC8. `docs/guides/03-ubuntu-baseline.md` is reviewed or checked as the portability pilot, or a non-exemplar replacement pilot is recorded with rationale.

AC9. The pilot guide evidence shows backup coverage for any user-owned or system-owned file edits. If the pilot edits `%UserProfile%\.wslconfig`, backup guidance appears before the edit in every section that tells the reader to make that change.

AC10. The documented review checklist or proof script records conditional safety-module coverage, including whether backup guidance is present, not applicable with a reason, or missing for each file-editing or hard-to-undo persistent-change guide.

AC11. First-slice validation does not execute setup commands from guide code blocks and does not require a Windows + WSL CI runner.

AC12. No changed artifact introduces generated documentation tooling, a one-command installer, hidden automation, or new setup command semantics.

AC13. Security-sensitive examples avoid secrets, credentials, tokens, private hostnames, and private certificate material.

AC14. The proposal status is settled to `accepted` before downstream implementation planning relies on this spec.

## Open questions

None blocking spec review.

## Next artifacts

The test spec should cover backup guidance through layered checks:

- static checks that `docs/templates/how-to-guide.md` contains `Scope`, `Backup`, and `Rollback` in the conditional state-changing module;
- static checks that the pilot guide includes a backup cue before the first file-editing command or editor instruction in the fast path and walkthrough;
- review-check evidence for published guides that edit user-owned or system-owned files;
- no command execution requirement in the first slice.

- `docs/changes/2026-06-15-how-to-guide-template-best-practices/reviews/spec-review.md` for spec review.
- `specs/how-to-guide-template-best-practices.test.md` for traceable structure, link, anchor, exemplar, and portability-pilot checks after spec review.
- `docs/templates/how-to-guide.md` update after spec and test-spec approval.
- `tests/markdown/how-to-guide-template-best-practices.test.sh` after the test spec defines the validation contract.
- `docs/guides/proxy-setup.md` reference exemplar conformance review.
- `docs/guides/03-ubuntu-baseline.md` portability pilot conformance review.

## Follow-on artifacts

None yet

## Readiness

Ready for spec-review.
