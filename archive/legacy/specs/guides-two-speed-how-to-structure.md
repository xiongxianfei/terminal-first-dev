# Two-Speed How-To Guide Structure Spec

## Status

approved

## Related proposal

- Proposal: `docs/proposals/2026-06-07-guides-two-speed-how-to-structure.md`
- Proposal review: `docs/changes/2026-06-07-guides-two-speed-how-to-structure/reviews/proposal-review.md`
- Change review log: `docs/changes/2026-06-07-guides-two-speed-how-to-structure/review-log.md`
- Related prior proposal: `docs/proposals/2026-05-24-bootstrap-terminal-first-windows-dev.md`

## Goal and context

This spec defines the observable documentation contract for `docs/guides/`, `docs/templates/how-to-guide.md`, and guide-to-troubleshooting links.

The repository already contains first-slice setup guides for a terminal-first Windows 11 development environment. This change reshapes the guide set from numbered, mostly linear setup pages into task-scoped how-to guides with a two-speed structure: a short fast path and a fuller walkthrough in the same file. The goal is to help readers configure one task quickly, verify early, and move to targeted troubleshooting when a step fails, while keeping deeper rationale in ADRs or architecture notes.

The first implementation slice should prove the pattern with `proxy-setup.md` before converting the whole guide set.

## Glossary

- Guide: a reader-facing task document under `docs/guides/`.
- Router: `docs/guides/README.md`, which sends readers to guide paths by intent.
- Task-scoped guide: a guide focused on one setup or verification task that can be reached independently from the router.
- Sequence guide: a guide, such as `fresh-setup.md`, that orders multiple task-scoped guides for a broader workflow.
- Fast path: the short, commands-first section near the top of each guide for experienced readers.
- Walkthrough: the expanded section below the fast path with the same task flow plus safety notes, context, and richer troubleshooting links.
- Troubleshooting entry: a recovery document under `docs/troubleshooting/`.
- Troubleshooting anchor: a stable heading anchor inside a troubleshooting entry.
- Guide template: the contributor-facing template at `docs/templates/how-to-guide.md`.
- Advisory command review: human review evidence that command blocks were run or manually checked where practical, without CI executing all setup commands.
- Structure check: a lightweight documentation check that verifies required sections, metadata, and links without proving command correctness.

## Examples first

Example E1: reader finds the proxy guide by intent
Given a reader already has Ubuntu on WSL and needs network access to work through a Windows proxy
When the reader opens `docs/guides/README.md`
Then the router points them to `docs/guides/proxy-setup.md` without requiring them to scan a numbered full setup sequence.

Example E2: experienced reader completes the fast path
Given a task-scoped guide has prerequisites that match the reader's machine state
When the reader follows only the `Fast path` section
Then the guide provides the minimum commands, expected results, and verification needed to know whether the task worked.

Example E3: newer reader uses the walkthrough
Given a reader wants more context before changing WSL proxy behavior
When the reader follows the `Walkthrough`
Then the guide repeats the same numbered task flow as the fast path and adds safety notes, why-this-step context, and symptom-specific troubleshooting links.

Example E4: failed verification routes to troubleshooting
Given a guide verification step fails with a certificate error
When the guide knows a likely troubleshooting anchor for that symptom
Then the step links inline to the relevant `docs/troubleshooting/*.md#anchor` entry at the failure point.

Example E5: contributor starts a new guide
Given a contributor wants to add a new task-scoped guide
When they look for the reusable template
Then `docs/templates/how-to-guide.md` provides a copyable structure rather than placing an empty skeleton in `docs/guides/`.

Example E6: pilot validates reader benefit
Given `docs/guides/proxy-setup.md` is converted as the pilot
When a maintainer runs a timed fast-path self-walkthrough from a documented starting state
Then the result records whether the task was completable without reading the walkthrough and notes any step that lacked enough safety or verification context.

## Requirements

R1. `docs/guides/` MUST be treated as reader-facing how-to documentation for completing setup, configuration, and verification tasks.

R2. `docs/guides/` MUST NOT contain contributor-only templates, empty skeleton files, ADR-style rationale, or troubleshooting deep dives as first-class guide content.

R3. `docs/guides/README.md` MUST act as an intent router that answers what the reader is trying to do, not merely as a flat filename list.

R4. The router MUST include a fresh-setup path for readers configuring a new workstation and targeted paths for readers who need one task, such as proxy, data mount, Neovim, tmux, or verification.

R5. The router MUST preserve troubleshooting as a separate reader mode by linking to `docs/troubleshooting/` for recovery tasks rather than embedding full recovery trees in guide summaries.

R6. Task-scoped guide filenames MUST be stable, descriptive, lowercase, hyphenated names without global numeric prefixes.

R7. Sequence MUST be expressed by `fresh-setup.md` and `docs/guides/README.md`, not by numbering every task-scoped guide filename.

R8. Existing numbered guide paths SHOULD keep a compatibility path during migration, either through retained redirect-style stubs, equivalent links from the router, or documented migration notes.

R9. `docs/templates/how-to-guide.md` MUST provide the reusable how-to guide template.

R10. The guide template MUST be contributor-facing meta documentation and MUST NOT be placed under `docs/guides/`.

R11. The guide template MUST include fields or sections for title, prerequisites, estimated time, outcome, top-level verification command or result, `Fast path`, `Walkthrough`, rollback notes where relevant, and troubleshooting links.

R12. Each task-scoped guide MUST lead with an outcome-oriented title, such as "Configure WSL automatic proxy", rather than only an abstract topic label, such as "Proxy".

R13. Each task-scoped guide MUST state prerequisites near the top before setup commands.

R14. Each task-scoped guide MUST state an estimated completion time near the top.

R15. Each task-scoped guide MUST state the expected outcome near the top.

R16. Each task-scoped guide MUST state a top-level verification command, check, or observable result near the top.

R17. Each task-scoped guide MUST include a `Fast path` section near the top.

R18. The `Fast path` section MUST be commands-first and limited to the minimum steps, expected results, and verification needed for the happy path.

R19. Each task-scoped guide MUST include a `Walkthrough` section after the fast path.

R20. The `Walkthrough` section MUST follow the same numbered task flow as the fast path unless the guide explicitly explains why a walkthrough-only branch is needed.

R21. The walkthrough SHOULD add context, safety notes, rollback awareness, or symptom-specific troubleshooting that is not present in the fast path.

R22. Steps in both `Fast path` and `Walkthrough` MUST be numbered so a reader can report where the guide failed.

R23. Each meaningful state-changing step MUST have nearby verification or an expected result.

R24. Commands and code blocks in guides MUST be treated as first-class content: they need clear shell or file-format fences where practical and should not be buried in prose-only paragraphs.

R25. Guides MUST link inline to troubleshooting anchors at likely failure points when a matching troubleshooting entry exists.

R26. Inline troubleshooting links MUST point to specific files and anchors, not only to `docs/troubleshooting/README.md`, when the failure symptom is known.

R27. Troubleshooting documents MUST own deep recovery instructions, repeated diagnostics, and environment-specific failure branches.

R28. Guides MUST keep design rationale brief and link to ADRs or architecture notes when deeper rationale is needed.

R29. `docs/guides/proxy-setup.md` MUST be the pilot conversion before broad guide migration.

R30. The proxy pilot MUST exercise prerequisites, environmental variance, multi-step verification, and at least two inline troubleshooting links when matching troubleshooting anchors exist.

R31. The proxy pilot MUST be reviewed for whether its fast path can complete the task from documented prerequisites without reading the walkthrough.

R32. The pilot review MUST record the documented starting state, whether the fast path was completable, approximate completion time, and any step that lacked enough safety or verification context.

R33. Documentation checks for this change MUST initially prioritize stable shape: required metadata, required sections, relative links, and troubleshooting anchors.

R34. Advisory command review MUST be used before command-execution CI exists. Authors SHOULD attest that command blocks were run or manually reviewed against expected output where practical.

R35. CI or automated command execution for setup code blocks MUST NOT be required in the first implementation slice.

R36. Command-execution CI MAY be proposed later only after command specs exist, a Windows + WSL runner environment is defined, and at least one advisory-missed regression shows the infrastructure would have value.

R37. Static-site generation, custom docs wizards, and generated personalized command flows MUST remain out of scope for this change.

R38. The guide structure MUST preserve the documentation-first project posture and MUST NOT introduce an opaque installer or hidden automation to compensate for guide complexity.

R39. The spec implementation MUST NOT redefine the PowerShell, WSL, Neovim, tmux, proxy, sudoers, mount, or package-source command contracts except where required to show guide structure examples.

R40. Any guide conversion that touches security-sensitive or machine-sensitive commands MUST keep the relevant safety impact near the command.

R41. The guide set SHOULD include task-scoped guide targets for fresh setup, Windows Terminal, PowerShell, WSL Ubuntu, Ubuntu baseline, proxy setup, data mount setup, Neovim setup, tmux setup, and verification.

R42. Optional or future task guides, such as `uv`, SHOULD follow the same two-speed structure when they remain under `docs/guides/`.

## Inputs and outputs

Inputs:

- Accepted proposal `docs/proposals/2026-06-07-guides-two-speed-how-to-structure.md`.
- Existing guides under `docs/guides/`.
- Existing troubleshooting entries under `docs/troubleshooting/`.
- Contributor decisions about whether a guide is task-scoped, sequence-oriented, or troubleshooting-oriented.
- Advisory command review notes or manual walkthrough evidence for the pilot guide.

Outputs:

- `docs/guides/README.md` as an intent router.
- `docs/templates/how-to-guide.md` as the reusable guide template.
- Task-scoped how-to guides under `docs/guides/`.
- `docs/guides/proxy-setup.md` as the pilot conversion.
- Inline links from guide steps to `docs/troubleshooting/*.md#anchor` where applicable.
- Documentation checks or review checklists for required shape and links.
- Pilot benefit evidence showing whether the fast path works from documented prerequisites.

## State and invariants

- `docs/guides/` remains reader-facing.
- `docs/templates/` remains contributor-facing.
- Troubleshooting remains separate from how-to guide happy paths.
- Fast path and walkthrough may repeat command blocks when parallel scanning is clearer for readers.
- Task guide filenames remain stable identifiers and do not encode global setup order.
- The router and `fresh-setup.md` own reader-specific sequencing.
- Command correctness is not proven merely because a guide passes structure or link checks.
- Security-sensitive commands remain visible, labeled, and near their safety notes.

## Error and boundary behavior

- If a task guide lacks known troubleshooting coverage for a failure point, the guide MUST NOT invent an anchor; it SHOULD include a short failure note and leave deeper recovery to a later troubleshooting entry.
- If a troubleshooting anchor is renamed or removed, link checks MUST fail or review MUST catch the broken reference before the guide is considered complete.
- If the fast path and walkthrough disagree on command order or expected result, review MUST treat that as a guide defect.
- If a fast path becomes too long to skim, review SHOULD move explanatory content to the walkthrough and keep only commands, expected results, and minimal warnings in the fast path.
- If a task is too risky for a short fast path, the guide MUST put the warning before the risky command and MAY keep more safety context in the fast path.
- If an existing numbered guide has external-link risk, migration SHOULD preserve a compatibility route instead of removing the old path without explanation.
- If a guide is primarily recovery-oriented, it belongs under `docs/troubleshooting/`, not `docs/guides/`.
- If a document is primarily rationale-oriented, it belongs under `docs/adr/` or `docs/architecture/`, not as a long section in a how-to guide.

## Compatibility and migration

- Existing numbered guides under `docs/guides/` are the pre-change format and may be migrated incrementally.
- The first migration slice MUST convert `proxy-setup.md` before converting all first-slice setup guides.
- During migration, `docs/guides/README.md` SHOULD help readers find the new task-scoped guides even if old numbered paths still exist.
- Existing troubleshooting paths SHOULD be reused where practical instead of creating duplicate recovery content.
- Existing setup behavior from `specs/terminal-first-workstation-setup.md` remains authoritative for command semantics until a later accepted spec changes it.
- Existing bookmarks to numbered setup guides SHOULD be considered when removing or renaming files.

## Observability

- Structure checks SHOULD report which guide is missing required metadata, `Fast path`, `Walkthrough`, numbered steps, or verification.
- Link checks SHOULD report the source guide, target file, and missing anchor for broken troubleshooting links.
- Pilot walkthrough evidence SHOULD record the guide path, starting state, completion result, approximate time, and noted defects.
- Review checklists SHOULD record whether the guide answers: "Is this for my task?", "What will be true when I finish?", "What commands do I run first?", "How do I know it worked?", and "Where do I go if this step fails?"

## Security and privacy

- This spec does not introduce new secret handling, authentication, credential storage, or telemetry.
- Guides MUST NOT ask users to paste secrets, proxy credentials, tokens, internal hostnames, or private certificate material into examples unless a later security-reviewed spec explicitly allows a safe pattern.
- Commands that affect proxy behavior, trust stores, sudoers, fstab, WSL global config, package sources, execution policy, or machine-wide state MUST call out the impact near the command.
- Pilot walkthrough evidence MUST NOT include private hostnames, usernames beyond generic examples, proxy credentials, tokens, or machine-specific secrets.

## Accessibility and UX

- Guide titles and router entries MUST use concrete task language that is understandable without knowing repository internals.
- Guides SHOULD keep top metadata short enough to scan before the first command.
- Fast path and walkthrough headings MUST be stable and easy to find by browser search or generated Markdown outline.
- Inline troubleshooting links SHOULD use descriptive link text or surrounding text that explains the failure symptom.
- The router SHOULD group entries by reader intent rather than by internal artifact category alone.

## Performance expectations

- Documentation structure checks SHOULD be lightweight enough to run locally during review without requiring a Windows + WSL environment.
- Link and structure checks SHOULD avoid executing setup commands.
- Reader-facing guides SHOULD keep the fast path short enough that an experienced reader can identify the first command and top-level verification within a few seconds of opening the guide.

## Edge cases

EC1. A guide has no state-changing commands, such as a verification-only guide; it still needs outcome, verification, fast path, and walkthrough, but rollback can be marked not applicable.

EC2. A guide has one meaningful step; it still uses numbered steps so failure reports have a stable reference.

EC3. A guide has multiple valid environment branches; the fast path should choose the documented default, while the walkthrough can explain branch selection.

EC4. A troubleshooting symptom has no stable anchor yet; the guide can link to the troubleshooting file or mark the anchor as a same-slice dependency, but broad conversion should wait for stable anchors.

EC5. A task is security-sensitive, such as sudoers or fstab; the fast path may include a short warning before the command even if that makes the fast path longer.

EC6. Existing numbered guide filenames conflict with the new stable unnumbered naming policy; migration should preserve discoverability rather than renaming every guide in one unreviewed sweep.

EC7. A contributor adds a guide for optional tooling; it should follow the same structure when placed under `docs/guides/`, even if the tool is optional.

EC8. A guide's fast path can complete the task but hides an important local policy assumption; review should require that assumption in prerequisites or before the affected command.

EC9. A command block is illustrative rather than meant to be copied; it should be labeled clearly so advisory command review and future command checks do not treat it as executable setup.

EC10. A guide links to ADR or architecture rationale; the guide should summarize only the task-relevant implication and leave the durable rationale in the linked artifact.

## Non-goals

- Rewriting every setup guide in this spec stage.
- Defining exact PowerShell, WSL, Neovim, tmux, proxy, sudoers, fstab, or mount commands beyond guide-structure examples.
- Replacing troubleshooting documents with guide-local recovery sections.
- Creating a beginner tutorial series under `docs/guides/`.
- Creating a generated documentation site, wizard, or custom static-site toolchain.
- Executing setup command blocks in CI for the first implementation slice.
- Solving all corporate proxy, PAC, VPN, and certificate issues.
- Moving ADR or architecture rationale into how-to guides.
- Creating a one-command installer or hidden automation layer.

## Acceptance criteria

AC1. The proposal status settlement is complete: `docs/proposals/2026-06-07-guides-two-speed-how-to-structure.md` has frontmatter and body status `accepted`.

AC2. `docs/templates/how-to-guide.md` exists and includes the required guide metadata and section structure from R11.

AC3. `docs/guides/README.md` routes by reader intent and includes fresh setup plus targeted task paths.

AC4. `docs/guides/proxy-setup.md` exists as the pilot guide and includes prerequisites, time, outcome, verification, `Fast path`, and `Walkthrough`.

AC5. The proxy pilot includes numbered steps in both fast path and walkthrough.

AC6. The proxy pilot includes inline troubleshooting links to at least two symptom-specific anchors when those anchors exist.

AC7. Pilot review evidence records whether the fast path can complete from documented prerequisites without using the walkthrough.

AC8. A lightweight structure check or documented manual checklist verifies required guide sections and metadata.

AC9. A link check or documented manual link review verifies guide-to-troubleshooting relative links and anchors.

AC10. The implementation does not require CI execution of setup command blocks.

AC11. Migration notes or router links preserve discoverability for existing numbered guide content during transition.

AC12. No new guide-local section duplicates deep troubleshooting content that belongs under `docs/troubleshooting/`.

## Open questions

None blocking spec review.

The implementation plan should decide the exact compatibility mechanism for existing numbered guide paths: redirect-style stubs, router-only migration notes, or retaining old files until all task-scoped replacements exist.

## Next artifacts

- `docs/changes/2026-06-07-guides-two-speed-how-to-structure/reviews/spec-review.md` for spec review.
- `specs/guides-two-speed-how-to-structure.test.md` for guide structure, link, and pilot walkthrough validation.
- `docs/architecture/system/architecture.md` update if the canonical architecture needs to record documentation-boundary changes.
- `docs/adr/2026-06-07-guide-information-architecture.md` only if the project wants the guide/troubleshooting/template split recorded as a durable ADR.
- `docs/changes/2026-06-07-guides-two-speed-how-to-structure/plan.md` after spec review and any required architecture work.

## Follow-on artifacts

None yet

## Readiness

Approved after formal spec review.

Ready for planning. Not ready for implementation until plan-review and test-spec are complete.
