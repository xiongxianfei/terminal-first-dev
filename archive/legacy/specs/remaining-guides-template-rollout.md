# Remaining Guides Template Rollout Spec

## Status

approved

## Related proposal

- Proposal: `docs/proposals/2026-06-16-remaining-guides-template-rollout.md`
- Proposal review: `docs/changes/2026-06-16-remaining-guides-template-rollout/reviews/proposal-review.md`
- Upstream guide structure spec: `specs/guides-two-speed-how-to-structure.md`
- Upstream guide template spec: `specs/how-to-guide-template-best-practices.md`
- Setup command contract spec: `specs/terminal-first-workstation-setup.md`

## Goal and context

This spec defines the observable contract for applying the accepted how-to guide template to the remaining first-slice guides.

The project already has a two-speed guide structure, a reusable how-to guide template, a reference exemplar in `docs/guides/proxy-setup.md`, and a portability pilot in `docs/guides/03-ubuntu-baseline.md`. The remaining first-slice guides still mostly use the older `Purpose`, `Command environment`, `Safety notes`, `Validation`, and `Rollback` structure.

This rollout converts those remaining guides toward the accepted visible metadata, `Fast path`, `Walkthrough`, expected-result, backup, rollback, and troubleshooting-link contract. It also preserves current command semantics, keeps existing numbered paths usable during body conformance, and treats the WSL guide split as a safety exception rather than a broad filename-migration precedent.

The first conversion target set is:

```text
docs/guides/05-tmux.md
docs/guides/04-neovim.md
docs/guides/06-uv.md
```

Later conversion targets are:

```text
docs/guides/01-windows-host.md
docs/guides/wsl-ubuntu-install.md
docs/guides/wsl-ubuntu-migration.md
docs/guides/02-wsl2-ubuntu.md
docs/guides/99-verification.md
docs/guides/README.md
```

The accepted template exemplar and pilot remain:

```text
docs/guides/proxy-setup.md
docs/guides/03-ubuntu-baseline.md
```

## Glossary

- Body conformance: revising a guide's reader-facing structure to satisfy the accepted template contract while preserving the guide's approved command semantics.
- Converted guide: a guide that this rollout has brought into the accepted visible metadata, `Fast path`, and `Walkthrough` shape.
- Compatibility stub: a short document kept at an old numbered path that routes readers to canonical task-scoped guides without duplicating setup commands.
- First smaller-guide slice: the initial body-conformance target set for `05-tmux.md`, `04-neovim.md`, and `06-uv.md`.
- Final filename migration: a later compatibility slice that can create final unnumbered task-scoped guide paths and replace old numbered files with redirect-style stubs.
- Router: `docs/guides/README.md`, the reader-facing guide index that routes by intent.
- Setup command contract: approved setup behavior governed by `specs/terminal-first-workstation-setup.md`.
- WSL split: the safety-driven split of `02-wsl2-ubuntu.md` into separate fresh-install and migration guides during body conformance.
- Active verification reference: a link, matrix entry, command grouping, or router pointer in `docs/guides/99-verification.md` that tells the reader to verify a setup guide, setup path, or published guide target as part of the current verification flow.
- Unresolved verification follow-up: a clearly labeled pending target that is not presented as an active verification step because its converted guide path does not exist yet or its owning guide has not yet been converted.
- Verification target inventory: review evidence listing each setup-guide path referenced by `99-verification.md`, whether that path exists after the slice, whether it is converted or a compatibility path, and whether any missing target is recorded as a follow-up.

## Examples first

Example E1: first smaller-guide slice preserves command semantics
Given `docs/guides/05-tmux.md`, `docs/guides/04-neovim.md`, and `docs/guides/06-uv.md` contain approved setup guidance
When they are converted in the first rollout slice
Then each guide gains visible metadata, a fast path, a walkthrough, command context, expected results, backup guidance where applicable, and rollback without changing the approved setup commands.

Example E2: uv remains optional
Given a reader does not need optional Python tooling
When they open the guide router or `docs/guides/06-uv.md`
Then uv is labeled as optional and is not presented as required for the core terminal-first workstation setup.

Example E3: WSL install and migration split
Given fresh WSL install and existing-distro migration have different starting states and destructive-risk profiles
When the WSL guide is converted
Then fresh install content moves to `docs/guides/wsl-ubuntu-install.md`, migration content moves to `docs/guides/wsl-ubuntu-migration.md`, and `docs/guides/02-wsl2-ubuntu.md` becomes a short compatibility stub.

Example E4: compatibility stub avoids command drift
Given a reader follows an existing link to `docs/guides/02-wsl2-ubuntu.md`
When the compatibility stub is rendered
Then it routes the reader to install or migration task guides and does not duplicate WSL setup commands.

Example E5: Windows host stays unified
Given `docs/guides/01-windows-host.md` covers Windows Terminal, PowerShell, WinGet, WSL availability, and optional PowerShell profile behavior
When it is converted during body conformance
Then it remains one guide and does not split Windows Terminal and PowerShell into separate files during this rollout.

Example E6: verification becomes a guide-shaped proof surface
Given `docs/guides/99-verification.md` consolidates proof commands and publication gates
When it is converted
Then it includes a fast path for the minimum useful verification route and a walkthrough for the detailed matrix, result vocabulary, static checks, and rollback coverage.

## Requirements

R1. This rollout MUST preserve the approved setup command semantics governed by `specs/terminal-first-workstation-setup.md`.

R2. This rollout MUST NOT introduce or require command-execution CI for guide code blocks.

R3. This rollout MUST NOT introduce generated documentation, custom docs tooling, scaffolder commands, installers, hidden automation, or one-command setup orchestration.

R4. Converted guides MUST conform to `specs/how-to-guide-template-best-practices.md` for visible metadata, fast path, walkthrough, command context, expected results, backup guidance, rollback, and troubleshooting-link placement.

R5. Converted guides MUST keep the visible metadata block near the top and before the first setup command.

R6. Converted guides MUST include reader-visible `Prerequisites`, `Time`, `Outcome`, and `Verify` metadata.

R7. Converted state-changing guides MUST include reader-visible `Scope` metadata or equivalent early scope text.

R8. Converted guides that touch destructive, security-sensitive, persistent, or hard-to-undo state MUST include `Safety` metadata or equivalent early safety text.

R9. Converted guides MUST include `## Fast path` before `## Walkthrough`.

R10. Converted guides MUST include `## Walkthrough` after `## Fast path`.

R11. Converted guide fast paths MUST be command-forward and limited to the minimum steps, warnings, expected results, and verification needed for the happy path.

R12. Converted guide walkthroughs MUST follow the same high-level step order as the fast path unless an alternative path is explicitly labeled.

R13. Converted procedural steps MUST use numbered steps when sequence matters.

R14. Converted guides MUST provide explicit command context before each meaningful command or configuration snippet that could be run in the wrong environment.

R15. Converted guides MUST NOT mix Windows PowerShell and Ubuntu commands in one code block.

R16. Converted guides MUST use `powershell` fences for Windows PowerShell commands and `bash` fences for Ubuntu shell commands where Markdown fencing applies.

R17. Converted guides SHOULD use specific configuration fences such as `ini`, `toml`, `lua`, or `tmux` when those snippets match the file format.

R18. Converted guides MUST provide expected-result text near each meaningful command or verification command.

R19. A converted guide that edits user-owned or system-owned files, or describes a hard-to-undo persistent state change, MUST include backup guidance before the edit or change in every path that instructs the reader to perform it, or explicitly state why backup is not applicable.

R20. Backup guidance in converted guides MUST identify the target file, directory, or persistent state and either the backup action or the concrete reason backup is not applicable.

R21. Converted state-changing guides MUST include rollback guidance.

R22. Converted guides MUST use inline troubleshooting links at likely failure points when stable troubleshooting files or anchors exist.

R23. Converted guides MUST NOT replace separate troubleshooting content with long guide-local recovery branches.

R24. Converted guides MUST NOT contain contributor-only template comments, unresolved placeholders, or empty template sections.

R25. Converted guides MUST NOT include secrets, tokens, proxy credentials, private hostnames, private certificate material, or user-specific machine names in examples.

R26. Converted guides MUST keep design rationale brief and route durable rationale to ADRs or architecture notes when deeper explanation is needed.

R27. The first smaller-guide slice MUST convert `docs/guides/05-tmux.md`, `docs/guides/04-neovim.md`, and `docs/guides/06-uv.md` before broader guide conversion is treated as complete.

R28. The first smaller-guide slice MUST preserve the existing file paths `docs/guides/05-tmux.md`, `docs/guides/04-neovim.md`, and `docs/guides/06-uv.md`.

R29. `docs/guides/05-tmux.md` MUST remain scoped to Ubuntu tmux and MUST NOT claim native Windows tmux support.

R30. `docs/guides/05-tmux.md` MUST include backup guidance before replacing or editing `~/.tmux.conf`, or explicitly route the edit through a walkthrough step that includes that guidance before the edit.

R31. `docs/guides/05-tmux.md` MUST include verification for `tmux -V` and loading the tmux configuration in a clean disposable session.

R32. `docs/guides/04-neovim.md` MUST continue to cover Neovim for both Windows PowerShell and Ubuntu.

R33. `docs/guides/04-neovim.md` MUST keep plugin and runtime state separate per environment and MUST NOT instruct readers to share plugin or runtime state through a Windows-mounted path.

R34. `docs/guides/04-neovim.md` MUST include backup guidance before replacing or editing `%LocalAppData%\nvim` or `~/.config/nvim`.

R35. `docs/guides/04-neovim.md` MUST include verification for `nvim --version`, startup without config errors, plugin manager status when applicable, and `:checkhealth`.

R36. `docs/guides/06-uv.md` MUST remain under `docs/guides/` for this rollout and MUST be labeled optional in the guide metadata, body, or router entry.

R37. `docs/guides/06-uv.md` MUST NOT make Python runtime setup mandatory for the core workstation setup.

R38. `docs/guides/06-uv.md` MUST keep package-index examples credential-free and MUST NOT use private hostnames, tokens, credentials, or internal package names.

R39. `docs/guides/06-uv.md` MUST distinguish project-level package-index configuration from user-level workstation defaults.

R40. `docs/guides/01-windows-host.md` MUST remain one guide during body conformance.

R41. `docs/guides/01-windows-host.md` MUST NOT split Windows Terminal and PowerShell setup into separate guide files during this rollout.

R42. `docs/guides/01-windows-host.md` MUST preserve policy-aware guidance for WinGet, Microsoft Store/App Installer, WSL availability, Windows Terminal, and PowerShell.

R43. `docs/guides/01-windows-host.md` MUST identify commands that may require administrator elevation, prompt for elevation, or depend on enterprise policy.

R44. The WSL conversion MUST split fresh install and migration into separate task-scoped guides.

R45. The WSL fresh-install guide MUST be `docs/guides/wsl-ubuntu-install.md`.

R46. The WSL migration guide MUST be `docs/guides/wsl-ubuntu-migration.md`.

R47. The WSL compatibility path MUST remain at `docs/guides/02-wsl2-ubuntu.md`.

R48. `docs/guides/02-wsl2-ubuntu.md` MUST become a short compatibility router or stub after the WSL split.

R49. The WSL compatibility stub MUST route readers to `wsl-ubuntu-install.md` and `wsl-ubuntu-migration.md` based on starting state.

R50. The WSL compatibility stub MUST NOT duplicate WSL setup, migration, unregister, import, or install commands.

R51. The WSL split MUST NOT authorize broad filename migration for unrelated numbered guides during body conformance.

R52. `docs/guides/wsl-ubuntu-install.md` MUST preserve the accepted fresh-install custom-location command contract from `specs/terminal-first-workstation-setup.md`.

R53. `docs/guides/wsl-ubuntu-install.md` MUST include command-context, expected-result, and verification coverage for WSL version, supported options, distro selection, install location, and distro launch checks.

R54. `docs/guides/wsl-ubuntu-migration.md` MUST preserve the accepted migration/import command contract from `specs/terminal-first-workstation-setup.md`.

R55. `docs/guides/wsl-ubuntu-migration.md` MUST include backup or export guidance before any `wsl --unregister` instruction.

R56. `docs/guides/wsl-ubuntu-migration.md` MUST label `wsl --unregister` as destructive before the command appears.

R57. `docs/guides/wsl-ubuntu-migration.md` MUST include verification after import-in-place, distro launch, and default distro reset where applicable.

R58. `docs/guides/99-verification.md` MUST NOT be converted in the first smaller-guide conversion slice. It MUST be converted only when every active setup-guide path referenced by its fast path, walkthrough, verification matrix, or router links exists after the same change. If a verification target refers to a guide path that is not yet converted or not yet created, the same slice MUST either update that path or record the target as an unresolved verification follow-up instead of presenting it as an active verification reference.

R59. `docs/guides/99-verification.md` MUST include a fast path for the minimum useful verification route and a walkthrough for the detailed verification matrix, result vocabulary, publication gate, static checks, and rollback coverage.

R60. `docs/guides/99-verification.md` MUST preserve the result vocabulary `pass`, `fail`, `skipped`, and `needs manual action`.

R61. `docs/guides/README.md` MUST remain the router while numbered compatibility paths and task-scoped guides coexist.

R62. `docs/guides/README.md` MUST label optional uv setup as optional.

R63. `docs/guides/README.md` MUST route WSL readers to the compatibility path before the WSL split and to the install or migration task guides after the WSL split.

R64. The final filename migration MUST remain a later compatibility slice unless a later approved proposal or spec changes that boundary.

R65. Final filename migration, when performed, MUST use short redirect-style stubs for old numbered paths plus router updates.

R66. Redirect-style stubs MUST contain links and brief explanation only, and MUST NOT duplicate setup commands except harmless navigation or verification commands.

R67. Static checks for this rollout MUST verify converted-guide structure without executing guide setup commands.

R68. Static checks MUST be scoped so guides not yet converted do not fail solely because they still use the old structure.

R69. Static checks MUST validate troubleshooting links and anchors referenced by converted guides when the link includes an anchor.

R70. Review evidence for converted guides MUST record fast-path/walkthrough parity, backup-before-edit coverage, command-context coverage, expected-result coverage, and any missing troubleshooting anchors.

R71. High-risk guide conversion review, including WSL migration and package-source guidance, MUST include manual or dry-run command review evidence.

R72. Missing troubleshooting anchors MUST be recorded as same-slice dependencies when the converted guide links to them, or as follow-ups when the guide uses a short local failure note instead.

R73. This rollout MUST NOT modify `docs/guides/proxy-setup.md` or `docs/guides/03-ubuntu-baseline.md` except for narrow router or link maintenance unless a later accepted artifact expands the scope.

R74. Completion evidence for this rollout MUST state which guides are converted, which guides remain compatibility paths, which checks ran, and which checks were intentionally not run.

R75. The verification conversion slice MUST include a verification target inventory.

## Inputs and outputs

Inputs:

- Accepted proposal `docs/proposals/2026-06-16-remaining-guides-template-rollout.md`.
- Approved proposal review `docs/changes/2026-06-16-remaining-guides-template-rollout/reviews/proposal-review.md`.
- Approved guide structure spec `specs/guides-two-speed-how-to-structure.md`.
- Approved guide template spec `specs/how-to-guide-template-best-practices.md`.
- Approved setup command contract spec `specs/terminal-first-workstation-setup.md`.
- Existing guides under `docs/guides/`.
- Existing troubleshooting entries under `docs/troubleshooting/`.
- Existing static Markdown checks under `tests/markdown/`.

Outputs:

- Converted guide bodies for the first smaller-guide slice.
- Later converted guide bodies for Windows host, WSL install, WSL migration, and verification.
- A WSL compatibility stub at `docs/guides/02-wsl2-ubuntu.md` after the WSL split.
- Router updates in `docs/guides/README.md`.
- Static checks or documented review evidence for converted-guide structure, troubleshooting links, backup-before-edit coverage, and parity.
- No command-execution CI, generated docs system, or hidden setup automation.

## State and invariants

- The project remains documentation-first.
- `docs/guides/` remains reader-facing how-to documentation.
- `docs/templates/how-to-guide.md` remains contributor-facing.
- `docs/troubleshooting/` remains the owner of deep recovery content.
- `specs/terminal-first-workstation-setup.md` remains authoritative for setup command semantics.
- Body conformance changes guide structure and presentation; it does not approve new setup behavior.
- Existing numbered paths remain usable until a compatibility path is in place.
- The WSL split is a safety exception for fresh-install and migration separation, not a general rename policy.
- Static checks prove structure and links, not machine setup correctness.
- `proxy-setup.md` remains the reference exemplar and `03-ubuntu-baseline.md` remains the existing portability pilot for the guide template.

## Error and boundary behavior

- If a converted guide changes setup command semantics beyond structure, review MUST treat the change as out of scope unless a later accepted spec authorizes it.
- If a converted guide lacks visible metadata, review or static checks MUST treat it as non-conformant.
- If a converted guide lacks `Fast path` or `Walkthrough`, review or static checks MUST treat it as non-conformant.
- If a converted guide's fast path and walkthrough conflict in high-level task order, review MUST require realignment or an explicitly labeled alternative path.
- If a converted guide shows a user-owned or system-owned file edit without backup guidance before the edit, review MUST treat backup guidance as missing.
- If backup is marked not applicable without a concrete reason, review MUST treat backup guidance as missing for hard-to-undo changes.
- If a converted guide contains unresolved placeholders or contributor-only comments, review or static checks MUST treat it as non-conformant.
- If a converted guide links to a missing troubleshooting file or anchor, link or anchor validation MUST fail unless the same slice creates the missing target.
- If no stable troubleshooting anchor exists for a known failure point, the converted guide MUST NOT invent a fake anchor.
- If `02-wsl2-ubuntu.md` duplicates WSL commands after the WSL split, review MUST treat the compatibility stub as non-conformant.
- If final filename migration begins before body conformance stabilizes, review MUST require a later accepted artifact that explicitly changes this spec's boundary.
- If a guide conversion needs a real command correction, that correction MUST be routed to a separate spec or bugfix unless it is a narrow editorial correction that does not change setup behavior.

## Compatibility and migration

- Existing numbered guide paths remain valid during body conformance.
- `05-tmux.md`, `04-neovim.md`, and `06-uv.md` keep their numbered filenames during the first smaller-guide slice.
- `01-windows-host.md` keeps its numbered filename and remains one guide during body conformance.
- `02-wsl2-ubuntu.md` changes role from full guide to compatibility stub only after `wsl-ubuntu-install.md` and `wsl-ubuntu-migration.md` exist.
- `99-verification.md` keeps its numbered filename during body conformance.
- Final task-scoped filename migration is deferred until a later compatibility slice.
- Short redirect-style stubs are the preferred final compatibility mechanism for old numbered paths.
- Router-only compatibility is insufficient for final filename migration because direct links and bookmarks to numbered files must remain useful.
- Fully duplicated retained numbered guides are not allowed as final compatibility because duplicated commands can drift.

## Observability

- Static checks SHOULD report the converted guide path and the missing or invalid structure item.
- Static checks SHOULD distinguish converted guides from not-yet-converted compatibility guides.
- Link checks SHOULD report the source guide, target file, and target anchor when a troubleshooting link fails.
- Review evidence SHOULD record guide path, reviewer, review mode, fast-path/walkthrough parity result, backup-before-edit result, command-context result, expected-result result, and unresolved follow-ups.
- High-risk review evidence SHOULD state whether command blocks were manually reviewed, dry-run reviewed, or not run, and why.
- Completion notes SHOULD list guides converted in the slice and guides intentionally left in old structure.
- Verification guide sequencing evidence SHOULD record that `docs/guides/99-verification.md` is absent from the first smaller-guide conversion slice, that every active path referenced by `docs/guides/99-verification.md` exists after the verification slice, that missing converted guide paths are recorded as unresolved verification follow-ups instead of active verification links, and that static link checks pass for active verification references.

## Security and privacy

- This spec does not introduce authentication, authorization, telemetry, network calls, or credential storage.
- Converted guides MUST NOT include real credentials, tokens, private hostnames, private package indexes, private certificate material, personal paths, or private machine names.
- uv package-index examples MUST use credential-free placeholder-safe values and MUST avoid examples that persist secrets into shell history or committed files.
- Commands that affect execution policy, administrator settings, package sources, WSL global configuration, sudoers, fstab, proxy behavior, trust stores, or editor runtime state MUST call out impact near the affected command or in visible metadata.
- Review evidence and dry-run notes MUST NOT capture private machine data, private hostnames, tokens, proxy credentials, or personal paths beyond documented generic examples.

## Accessibility and UX

- Converted guide titles and router labels MUST use concrete task language that is understandable without knowing repository internals.
- Converted guide metadata SHOULD be short enough to scan before the first setup command.
- `Fast path` and `Walkthrough` headings MUST remain stable and searchable.
- Inline troubleshooting links SHOULD use surrounding text that names the failure symptom.
- Compatibility stubs MUST state where the reader should go next and why the old path no longer contains the full commands.
- The router SHOULD group entries by reader intent while migration is in progress.

## Performance expectations

- Static structure and link checks SHOULD run locally without requiring Windows, WSL, Neovim, tmux, uv, or network access.
- Static checks MUST NOT execute setup commands from guide code blocks.
- Static checks SHOULD finish quickly enough for normal documentation review; if a check becomes slow because of repository size, the test spec should define scoped path checks for converted guides.
- Converted fast paths SHOULD keep the first actionable command and the top-level verification visible near the top of the guide.

## Edge cases

EC1. A converted guide has one meaningful step; it still uses a numbered step so failure reports have a stable reference.

EC2. A converted guide has multiple valid environment branches; the fast path uses the documented default or routes to clearly labeled choices, while the walkthrough explains branch selection.

EC3. A converted guide is mostly verification-only; rollback can be marked not applicable when it does not hide a recovery need.

EC4. A converted guide creates a new disposable project-owned file with no prior user state; backup can be marked not applicable with that concrete reason.

EC5. A converted guide includes a package-source example; the example must be credential-free and must not look like a real private host.

EC6. A converted guide needs a troubleshooting anchor that does not exist; the same slice can add the anchor, or the guide can use a short local failure note and record a troubleshooting follow-up.

EC7. A numbered guide has incoming links; final filename migration uses a compatibility stub rather than deleting the numbered file.

EC8. A WSL migration reader starts in the wrong guide; the WSL install and migration guides should route between each other by starting state.

EC9. A compatibility stub needs to prove it is the old path; it may include a short explanation and links, but it must not duplicate setup commands.

EC10. A static check cannot reliably infer backup-before-edit for all guide prose; the test spec may combine static checks for obvious structure with required review evidence for judgment-heavy coverage.

## Non-goals

- Changing approved PowerShell, WSL, Ubuntu, Neovim, tmux, uv, proxy, sudoers, fstab, package-source, or mount command semantics.
- Executing guide command blocks in CI.
- Creating generated documentation, a custom static-site pipeline, a guide scaffolder, a wizard, or an installer.
- Completing broad unnumbered filename migration in the same slice as body conformance.
- Removing numbered guide paths without redirect-style compatibility.
- Creating deep troubleshooting content inside guide pages.
- Creating tutorial-style beginner documentation under `docs/guides/`.
- Moving optional uv guidance out of `docs/guides/` during this rollout.
- Replacing `proxy-setup.md` or `03-ubuntu-baseline.md` as the settled template exemplar and portability pilot.

## Acceptance criteria

AC1. `specs/remaining-guides-template-rollout.md` includes requirements for converted-guide visible metadata, `Fast path`, `Walkthrough`, command context, expected results, backup-before-edit, rollback, and troubleshooting-link behavior.

AC2. The spec names the first smaller-guide slice as `docs/guides/05-tmux.md`, `docs/guides/04-neovim.md`, and `docs/guides/06-uv.md`.

AC3. The spec requires the first smaller-guide slice to preserve the current numbered file paths during body conformance.

AC4. The spec requires `docs/guides/06-uv.md` to remain under `docs/guides/` for this rollout and be labeled optional.

AC5. The spec requires `docs/guides/01-windows-host.md` to remain one guide during body conformance.

AC6. The spec requires WSL fresh install and migration to split into `docs/guides/wsl-ubuntu-install.md` and `docs/guides/wsl-ubuntu-migration.md`.

AC7. The spec requires `docs/guides/02-wsl2-ubuntu.md` to become a short compatibility stub after the WSL split.

AC8. The spec prohibits the WSL compatibility stub from duplicating WSL setup, migration, unregister, import, or install commands.

AC9. The spec records that the WSL split is a safety exception and does not authorize broad filename migration.

AC10. The spec defers final unnumbered filename migration to a later compatibility slice.

AC11. The spec requires final filename migration to use redirect-style stubs plus router updates when that later slice occurs.

AC12. The spec preserves existing setup command semantics by referencing `specs/terminal-first-workstation-setup.md`.

AC13. The spec prohibits command-execution CI for this rollout.

AC14. The spec requires static checks to be scoped to converted guides so unconverted compatibility guides do not fail solely for old structure.

AC15. The spec requires troubleshooting link and anchor validation for converted guides where anchors are referenced.

AC16. The spec requires review evidence for fast-path/walkthrough parity, backup-before-edit coverage, command context, expected results, and missing troubleshooting anchors.

AC17. The spec includes error and boundary behavior for missing backup guidance, stale placeholders, missing troubleshooting anchors, command-semantics drift, and command duplication in compatibility stubs.

AC18. The spec includes security and privacy requirements for uv package-index examples and private credential avoidance.

AC19. The spec includes accessibility and UX expectations for router labels, guide titles, stable headings, inline troubleshooting link text, and compatibility stubs.

AC20. The spec identifies `specs/remaining-guides-template-rollout.test.md` as the next test-spec artifact before implementation.

AC21. The spec defines an observable sequencing rule for `docs/guides/99-verification.md` conversion. Acceptance evidence includes a verification target inventory showing that each active setup-guide path referenced by `99-verification.md` exists after the same change, or that the target is recorded as an unresolved verification follow-up instead of an active verification reference.

## Open questions

None blocking spec review.

The later final filename-migration slice may decide exact canonical filenames for Windows host, Neovim, tmux, uv, verification, and fresh setup, but that decision is outside this spec's body-conformance scope except for the WSL split paths defined here.

## Next artifacts

- `docs/changes/2026-06-16-remaining-guides-template-rollout/plan.md` for implementation order after approved spec review.
- `specs/remaining-guides-template-rollout.test.md` for traceable structure, link, backup, parity, and review-evidence checks after plan review.
- Static check updates under `tests/markdown/` after the test spec is approved.

## Follow-on artifacts

- `docs/changes/2026-06-16-remaining-guides-template-rollout/plan.md`
- `specs/remaining-guides-template-rollout.test.md`

## Readiness

Approved by second-pass spec review.

Ready for plan review after the execution plan is drafted.

Not ready for test-spec or implementation until plan review is complete.
