# Remaining Guides Template Rollout Test Spec

## Status

active

## Related spec and plan

- Spec: `specs/remaining-guides-template-rollout.md`
- Spec review: `docs/changes/2026-06-16-remaining-guides-template-rollout/reviews/spec-review.md`
- Spec review resolution: `docs/changes/2026-06-16-remaining-guides-template-rollout/reviews/spec-review-resolution.md`
- Plan: `docs/changes/2026-06-16-remaining-guides-template-rollout/plan.md`
- Plan review: `docs/changes/2026-06-16-remaining-guides-template-rollout/reviews/plan-review-r1.md`
- Architecture/ADRs: not applicable; the approved spec and plan keep the change to Markdown guide structure, router updates, compatibility stubs, static checks, and review evidence.

## Testing strategy

The proof surface is documentation-first and static.

- Unit strategy: not applicable; this rollout introduces no runtime units or functions.
- Integration strategy: add one repository-level Bash proof script that checks converted guide structure, router links, compatibility stubs, troubleshooting anchors, verification-reference inventory, and guardrails across the converted documentation set.
- End-to-end strategy: not applicable for workstation setup execution. The closest end-to-end proof is review evidence that a reader can follow each converted fast path to its stated verification signal without command execution claims unless commands were actually run outside CI.
- Smoke strategy: file-existence, required-heading, required-label, route, and stub checks prove the expected artifacts exist after each milestone.
- Manual strategy: review evidence covers judgment-heavy requirements that static text checks cannot prove reliably, including command-semantics preservation, fast-path/walkthrough parity, backup-before-edit adequacy, high-risk WSL command review, uv package-source review, and missing troubleshooting-anchor disposition.
- Contract strategy: static checks map to requirement IDs and acceptance criteria, especially the converted-guide template contract, no-command-execution boundary, WSL split rule, compatibility-stub rule, verification sequencing rule, and final filename-migration boundary.
- Migration strategy: check that numbered paths remain usable during body conformance, `02-wsl2-ubuntu.md` becomes a command-free compatibility stub only after the new WSL task guides exist, and final unnumbered filename migration remains out of scope.

Primary implementation proof script:

```bash
bash tests/markdown/remaining-guides-template-rollout.test.sh
```

Regression and upstream-contract checks:

```bash
bash tests/markdown/how-to-guide-template-best-practices.test.sh
bash tests/markdown/guides-two-speed-how-to-structure.test.sh
bash tests/markdown/m1-project-entrypoint.test.sh
bash tests/markdown/m2-windows-wsl-storage.test.sh
bash tests/markdown/m3-ubuntu-baseline.test.sh
bash tests/markdown/m4-neovim-tmux.test.sh
bash tests/markdown/m5-release-readiness.test.sh
git diff --cached --check
```

The proof script must not execute setup commands from guide code blocks and must not require Windows, WSL, Neovim, tmux, uv, network access, administrator privileges, or private machine data.

## Requirement coverage map

| Requirement ID | Covered by | Level | Notes |
| --- | --- | --- | --- |
| R1 | T-RGT-001, T-RGT-010 | manual | Command semantics are preserved by command inventory and review evidence against the setup contract. |
| R2 | T-RGT-012 | contract | Tests reject command-execution CI and setup-command execution from guide blocks. |
| R3 | T-RGT-012 | contract | Tests and review reject generated docs, custom tooling, scaffolds, installers, and hidden automation. |
| R4 | T-RGT-001 | integration | Converted guides are checked against the accepted guide-template contract. |
| R5 | T-RGT-001 | integration | Metadata must appear near the top and before setup commands. |
| R6 | T-RGT-001 | integration | Required metadata labels are checked. |
| R7 | T-RGT-001, T-RGT-010 | integration | Scope metadata or equivalent is checked for state-changing converted guides. |
| R8 | T-RGT-001, T-RGT-010 | integration | Safety metadata or equivalent is checked for destructive, persistent, security-sensitive, or hard-to-undo guides. |
| R9 | T-RGT-001 | integration | `Fast path` must appear before `Walkthrough`. |
| R10 | T-RGT-001 | integration | `Walkthrough` must appear after `Fast path`. |
| R11 | T-RGT-010 | manual | Review evidence checks fast-path skimmability and command-forward scope. |
| R12 | T-RGT-010 | manual | Review evidence checks fast-path/walkthrough high-level step parity. |
| R13 | T-RGT-001 | integration | Numbered steps are checked where sequence matters. |
| R14 | T-RGT-001 | integration | Command-context text is checked before meaningful command or snippet blocks. |
| R15 | T-RGT-001 | integration | Static checks reject mixed Windows and Ubuntu commands in one converted guide code block where detectable. |
| R16 | T-RGT-001 | integration | PowerShell and Ubuntu command fences are checked. |
| R17 | T-RGT-001 | integration | Configuration fences are checked where snippets target known config files. |
| R18 | T-RGT-001 | integration | Expected-result text is checked near meaningful commands and verification commands. |
| R19 | T-RGT-002 | integration | Backup-before-edit or concrete not-applicable reasoning is checked for file edits and hard-to-undo changes. |
| R20 | T-RGT-002 | integration | Backup guidance must identify target state plus backup action or reason. |
| R21 | T-RGT-002 | integration | Rollback guidance is checked for state-changing converted guides. |
| R22 | T-RGT-003 | integration | Inline troubleshooting links are checked when anchors exist. |
| R23 | T-RGT-003, T-RGT-010 | manual | Review evidence rejects long guide-local recovery branches. |
| R24 | T-RGT-001 | integration | Placeholder and contributor-comment leakage is rejected. |
| R25 | T-RGT-011 | contract | Secrets, tokens, private hostnames, private cert material, personal paths, and machine names are rejected. |
| R26 | T-RGT-010 | manual | Review evidence checks that rationale is brief or routed to durable docs. |
| R27 | T-RGT-004 | integration | First smaller-guide slice paths are checked as converted before broader completion. |
| R28 | T-RGT-004 | migration | Numbered paths for tmux, Neovim, and uv must remain. |
| R29 | T-RGT-004 | integration | tmux guide remains Ubuntu scoped and does not claim native Windows tmux support. |
| R30 | T-RGT-002, T-RGT-004 | integration | tmux backup-before-edit coverage is checked. |
| R31 | T-RGT-004 | integration | tmux version and clean-session config verification are checked. |
| R32 | T-RGT-004 | integration | Neovim guide must cover Windows PowerShell and Ubuntu. |
| R33 | T-RGT-004 | integration | Neovim runtime/plugin state separation is checked. |
| R34 | T-RGT-002, T-RGT-004 | integration | Neovim backup-before-edit coverage is checked. |
| R35 | T-RGT-004 | integration | Neovim version, startup, plugin manager, and `:checkhealth` verification are checked. |
| R36 | T-RGT-004 | integration | uv remains under `docs/guides/` and is labeled optional. |
| R37 | T-RGT-004 | integration | uv must not make Python runtime setup mandatory for core setup. |
| R38 | T-RGT-011 | contract | uv package-index examples must be credential-free and non-private. |
| R39 | T-RGT-004 | integration | uv distinguishes project-level package-index config from user-level defaults. |
| R40 | T-RGT-005 | integration | Windows host remains one guide. |
| R41 | T-RGT-005 | migration | Windows Terminal and PowerShell are not split into separate files in this rollout. |
| R42 | T-RGT-005 | integration | Policy-aware Windows host guidance is checked. |
| R43 | T-RGT-005 | integration | Elevation, prompts, and enterprise-policy dependency notes are checked. |
| R44 | T-RGT-006 | migration | WSL install and migration split is checked. |
| R45 | T-RGT-006 | migration | `wsl-ubuntu-install.md` must exist. |
| R46 | T-RGT-006 | migration | `wsl-ubuntu-migration.md` must exist. |
| R47 | T-RGT-006 | migration | `02-wsl2-ubuntu.md` compatibility path must remain. |
| R48 | T-RGT-006 | migration | `02-wsl2-ubuntu.md` must be a short compatibility stub after split. |
| R49 | T-RGT-006 | migration | WSL stub routes by starting state to install and migration guides. |
| R50 | T-RGT-006 | migration | WSL stub command duplication is rejected. |
| R51 | T-RGT-006, T-RGT-009 | migration | WSL split must not broaden filename migration. |
| R52 | T-RGT-006, T-RGT-010 | manual | Fresh-install command contract preservation is reviewed against the setup spec. |
| R53 | T-RGT-006 | integration | WSL install command context, expected results, and verification are checked. |
| R54 | T-RGT-006, T-RGT-010 | manual | Migration command contract preservation is reviewed against the setup spec. |
| R55 | T-RGT-002, T-RGT-006 | integration | Backup/export guidance before `wsl --unregister` is checked. |
| R56 | T-RGT-006 | integration | Destructive `wsl --unregister` labeling before the command is checked. |
| R57 | T-RGT-006 | integration | Migration verification after import, launch, and default reset is checked. |
| R58 | T-RGT-007 | migration | Verification guide sequencing and active-reference handling are checked. |
| R59 | T-RGT-007 | integration | Verification guide fast path and walkthrough matrix coverage are checked. |
| R60 | T-RGT-007 | integration | Result vocabulary is checked. |
| R61 | T-RGT-008 | migration | Router remains active while numbered and task-scoped paths coexist. |
| R62 | T-RGT-008 | integration | Router labels uv setup optional. |
| R63 | T-RGT-008 | migration | Router WSL routing changes before and after split are checked. |
| R64 | T-RGT-009 | migration | Final filename migration remains deferred. |
| R65 | T-RGT-009 | migration | Final migration policy requires redirect-style stubs plus router updates. |
| R66 | T-RGT-009 | migration | Redirect-style stubs must not duplicate commands. |
| R67 | T-RGT-012 | contract | Static checks verify converted-guide structure without setup-command execution. |
| R68 | T-RGT-012 | contract | Static checks are scoped to converted guides. |
| R69 | T-RGT-003 | integration | Troubleshooting links and anchors are checked. |
| R70 | T-RGT-010 | manual | Review evidence records parity, backup, context, expected results, and missing anchors. |
| R71 | T-RGT-010 | manual | High-risk WSL and package-source command review evidence is required. |
| R72 | T-RGT-003, T-RGT-010 | manual | Missing troubleshooting anchors are same-slice dependencies or follow-ups. |
| R73 | T-RGT-009 | migration | Proxy exemplar and Ubuntu baseline are protected from unrelated edits. |
| R74 | T-RGT-013 | manual | Completion evidence must list converted guides, compatibility paths, checks run, and checks not run. |
| R75 | T-RGT-007 | migration | Verification conversion slice must include a target inventory. |
| Error behavior | T-RGT-001, T-RGT-002, T-RGT-003, T-RGT-006, T-RGT-007, T-RGT-009, T-RGT-012 | contract | Boundary failures map to static checks or mandatory review evidence. |
| AC1 | T-RGT-001 | integration | Converted-guide core contract is checked. |
| AC2 | T-RGT-004 | integration | First smaller-guide slice paths are checked. |
| AC3 | T-RGT-004 | migration | First smaller-guide numbered paths remain. |
| AC4 | T-RGT-004, T-RGT-008 | integration | uv optionality is checked in guide/router. |
| AC5 | T-RGT-005 | integration | Windows host remains one guide. |
| AC6 | T-RGT-006 | migration | WSL split target files are checked. |
| AC7 | T-RGT-006 | migration | WSL compatibility stub is checked. |
| AC8 | T-RGT-006 | migration | WSL stub command duplication is rejected. |
| AC9 | T-RGT-006, T-RGT-009 | migration | WSL split is treated as the only body-conformance filename exception. |
| AC10 | T-RGT-009 | migration | Final unnumbered filename migration is deferred. |
| AC11 | T-RGT-009 | migration | Redirect-style stubs are the future compatibility mechanism. |
| AC12 | T-RGT-010 | manual | Setup command semantics are preserved by review evidence. |
| AC13 | T-RGT-012 | contract | Command-execution CI is prohibited. |
| AC14 | T-RGT-012 | contract | Static checks are scoped to converted guides. |
| AC15 | T-RGT-003 | integration | Troubleshooting link and anchor validation is checked. |
| AC16 | T-RGT-010 | manual | Review evidence fields are required. |
| AC17 | T-RGT-001, T-RGT-002, T-RGT-003, T-RGT-006, T-RGT-012 | contract | Boundary behavior is tested. |
| AC18 | T-RGT-011 | contract | Security/privacy guardrails are checked. |
| AC19 | T-RGT-008, T-RGT-010 | manual | Router labels, titles, stable headings, inline link text, and stubs are reviewed. |
| AC20 | T-RGT-000 | smoke | This test spec exists at `specs/remaining-guides-template-rollout.test.md`. |
| AC21 | T-RGT-007 | migration | Verification sequencing and inventory are checked. |

## Example coverage map

| Example | Covered by | Notes |
| --- | --- | --- |
| E1 | T-RGT-004, T-RGT-010 | Smaller guide conversion preserves command semantics and gains required guide shape. |
| E2 | T-RGT-004, T-RGT-008 | uv optionality is checked in guide and router. |
| E3 | T-RGT-006 | WSL install and migration split is checked. |
| E4 | T-RGT-006 | WSL compatibility stub avoids command drift. |
| E5 | T-RGT-005 | Windows host remains unified. |
| E6 | T-RGT-007 | Verification guide becomes a guide-shaped proof surface. |

## Edge case coverage

| Edge case | Covered by | Level | Notes |
| --- | --- | --- | --- |
| EC1 | T-RGT-001 | integration | One-step converted guides still use numbered steps. |
| EC2 | T-RGT-001, T-RGT-010 | manual | Multiple environment branches are checked for clear fast-path defaults or labeled alternatives. |
| EC3 | T-RGT-002 | integration | Verification-only rollback can be not applicable only with no hidden recovery need. |
| EC4 | T-RGT-002 | integration | Disposable project-owned file backup not-applicable reasons must be concrete. |
| EC5 | T-RGT-011 | contract | Package-source examples must be credential-free and non-private. |
| EC6 | T-RGT-003, T-RGT-010 | manual | Missing troubleshooting anchors become same-slice targets or follow-ups. |
| EC7 | T-RGT-009 | migration | Incoming numbered links are preserved by compatibility paths. |
| EC8 | T-RGT-006, T-RGT-008 | manual | WSL install and migration guides route readers who start in the wrong guide. |
| EC9 | T-RGT-006 | migration | Compatibility stubs may explain and link, but cannot duplicate setup commands. |
| EC10 | T-RGT-002, T-RGT-010 | manual | Backup-before-edit uses layered static and review checks. |

## Test cases

### T-RGT-000. Test spec artifact exists

- Covers: AC20
- Level: smoke
- Fixture/setup: Repository after test-spec authoring.
- Steps: Confirm `specs/remaining-guides-template-rollout.test.md` exists and references the approved spec, plan, spec review, and plan review.
- Expected result: The rollout has a traceable test spec before implementation begins.
- Failure proves: Implementation would start without the required proof-planning artifact.
- Automation location: manual inspection before implementation.

### T-RGT-001. Converted guide core structure

- Covers: R4-R18, R24, AC1, AC17, EC1-EC2
- Level: integration
- Fixture/setup: Repository after each implementation milestone. The proof script owns a milestone-scoped list of converted guide paths.
- Steps: For each converted guide path, check visible metadata near the top, `Fast path` before `Walkthrough`, numbered procedural steps, explicit command/snippet context, expected-result text, appropriate code fences, no mixed Windows/Ubuntu command blocks where statically detectable, no unresolved placeholders, and no contributor-only template comments.
- Expected result: Converted guides satisfy the accepted two-speed guide shape without forcing unconverted guides to pass the new structure.
- Failure proves: A converted guide is structurally incomplete or the static check scope is too broad.
- Automation location: `tests/markdown/remaining-guides-template-rollout.test.sh`

### T-RGT-002. Backup, safety, rollback, and state-change coverage

- Covers: R7-R8, R19-R21, R30, R34, R55, AC16-AC17, EC3-EC4, EC10
- Level: integration
- Fixture/setup: Repository after each implementation milestone with converted guides listed in the proof script.
- Steps: Check state-changing guides include scope and rollback guidance. Check file edits or hard-to-undo persistent changes include backup guidance before the edit/change in every path that instructs the reader to perform it, or a concrete not-applicable reason. Check tmux, Neovim, and WSL migration target files/operations have their required backup/export coverage.
- Expected result: Safety and recovery information is visible before state-changing commands or snippets.
- Failure proves: A converted guide may expose readers to persistent changes without prior backup or rollback context.
- Automation location: `tests/markdown/remaining-guides-template-rollout.test.sh` plus milestone review evidence.

### T-RGT-003. Troubleshooting link and anchor validation

- Covers: R22-R23, R69, R72, AC15, EC6
- Level: integration
- Fixture/setup: Repository after each milestone with converted guide paths listed.
- Steps: Parse troubleshooting links from converted guides. Confirm linked troubleshooting files exist and anchor slugs resolve when an anchor is present. Confirm missing anchors are either added in the same slice or recorded as follow-ups when the guide uses a local failure note. Manually review that converted guides do not embed deep recovery branches.
- Expected result: Inline troubleshooting links route to real recovery targets and guides stay on the happy path.
- Failure proves: A reader could hit dead recovery links or guides could absorb troubleshooting content that belongs elsewhere.
- Automation location: `tests/markdown/remaining-guides-template-rollout.test.sh` plus milestone review evidence.

### T-RGT-004. First smaller-guide slice conformance

- Covers: R27-R39, R62, AC2-AC4, E1-E2, EC5
- Level: integration
- Fixture/setup: Repository after M1.
- Steps: Check `docs/guides/05-tmux.md`, `docs/guides/04-neovim.md`, and `docs/guides/06-uv.md` exist at their numbered paths and are included in the converted-guide check list. Check tmux remains Ubuntu-scoped, has `tmux -V` and clean disposable-session verification, and does not claim native Windows tmux support. Check Neovim covers Windows PowerShell and Ubuntu, keeps plugin/runtime state separate, and includes required verification. Check uv remains optional, does not make Python runtime setup mandatory, and distinguishes project-level package-index config from user-level defaults.
- Expected result: The first smaller-guide slice is converted without filename churn or command-scope expansion.
- Failure proves: The rollout skipped the required first slice, changed path strategy too early, or weakened guide-specific safety rules.
- Automation location: `tests/markdown/remaining-guides-template-rollout.test.sh`

### T-RGT-005. Windows host guide remains unified and policy-aware

- Covers: R40-R43, AC5, E5
- Level: integration
- Fixture/setup: Repository after M2.
- Steps: Check `docs/guides/01-windows-host.md` exists and is the only Windows host body-conformance target. Confirm no new Windows Terminal or PowerShell split guide files are introduced by this rollout. Check the guide preserves policy-aware coverage for WinGet, Microsoft Store/App Installer, WSL availability, Windows Terminal, and PowerShell. Check commands that require elevation, prompt for elevation, or depend on enterprise policy are labeled near the relevant commands.
- Expected result: Windows host setup remains one converted guide with visible policy and elevation boundaries.
- Failure proves: Body conformance was combined with unauthorized information-architecture migration or lost Windows policy context.
- Automation location: `tests/markdown/remaining-guides-template-rollout.test.sh`

### T-RGT-006. WSL install and migration split with compatibility stub

- Covers: R44-R57, R63, AC6-AC9, E3-E4, EC7-EC9
- Level: migration
- Fixture/setup: Repository after M3.
- Steps: Check `docs/guides/wsl-ubuntu-install.md`, `docs/guides/wsl-ubuntu-migration.md`, and `docs/guides/02-wsl2-ubuntu.md` exist. Check the compatibility stub routes by starting state to both task guides and does not duplicate WSL setup, migration, unregister, import, install, or import-in-place commands. Check install guide includes command context, expected results, and verification for WSL version, supported options, distro selection, install location, and distro launch. Check migration guide includes backup/export before `wsl --unregister`, destructive labeling before `wsl --unregister`, and verification after import-in-place, distro launch, and default distro reset where applicable.
- Expected result: The WSL split improves reader safety without breaking old links or duplicating high-risk commands.
- Failure proves: The WSL exception either failed to create the required task guides, broke compatibility, duplicated commands, or weakened destructive-operation safety.
- Automation location: `tests/markdown/remaining-guides-template-rollout.test.sh` plus WSL high-risk review evidence.

### T-RGT-007. Verification guide sequencing and target inventory

- Covers: R58-R60, R75, AC21, E6
- Level: migration
- Fixture/setup: Repository after M4.
- Steps: Confirm the first smaller-guide slice did not convert `docs/guides/99-verification.md`. Check the verification conversion slice includes `docs/changes/2026-06-16-remaining-guides-template-rollout/verification-target-inventory.md`. For every active setup-guide path referenced by `99-verification.md` fast path, walkthrough, verification matrix, or router links, confirm the path exists after the same slice. Confirm missing or not-yet-converted targets are listed as unresolved verification follow-ups and are not active verification links. Check result vocabulary includes `pass`, `fail`, `skipped`, and `needs manual action`.
- Expected result: Verification guide conversion is observable, sequenced, and free of broken active references.
- Failure proves: The verification guide was converted prematurely or points readers at missing targets.
- Automation location: `tests/markdown/remaining-guides-template-rollout.test.sh`

### T-RGT-008. Router behavior during coexistence

- Covers: R61-R63, AC4, AC19, EC8
- Level: migration
- Fixture/setup: Repository after each milestone.
- Steps: Check `docs/guides/README.md` remains the router. Before the WSL split, check it routes WSL readers to `02-wsl2-ubuntu.md`. After the WSL split, check it routes readers by starting state to `wsl-ubuntu-install.md` and `wsl-ubuntu-migration.md`. Check uv setup is labeled optional. Manually review router labels and compatibility-stub wording for clear reader intent.
- Expected result: The router remains usable while old numbered paths and new task-scoped WSL paths coexist.
- Failure proves: Readers could be routed to stale, ambiguous, or missing setup paths during migration.
- Automation location: `tests/markdown/remaining-guides-template-rollout.test.sh` plus milestone review evidence.

### T-RGT-009. Filename-migration and protected-file boundaries

- Covers: R51, R64-R66, R73, AC9-AC11
- Level: migration
- Fixture/setup: Repository after each milestone.
- Steps: Check the rollout does not perform broad final unnumbered filename migration outside the WSL split. Check numbered non-WSL guides remain at their approved paths. Check any redirect-style stubs contain links and explanation only and do not duplicate setup commands. Check `docs/guides/proxy-setup.md` and `docs/guides/03-ubuntu-baseline.md` are unchanged except for narrow router or link maintenance explicitly recorded in review evidence.
- Expected result: Body conformance stays separate from final filename migration and does not disturb settled exemplar/pilot files.
- Failure proves: The implementation expanded beyond the approved compatibility boundary.
- Automation location: `tests/markdown/remaining-guides-template-rollout.test.sh` plus diff review.

### T-RGT-010. Review evidence completeness

- Covers: R1, R11-R12, R23, R26, R52, R54, R70-R72, R74, AC12, AC16, AC19, EC2, EC6, EC8, EC10
- Level: manual
- Fixture/setup: Each milestone has a review record under `docs/changes/2026-06-16-remaining-guides-template-rollout/reviews/`.
- Steps: For each converted guide, record guide path, reviewer, review mode, command-inventory or command-contract review result, fast-path/walkthrough parity result, backup-before-edit result, command-context result, expected-result result, troubleshooting-anchor result, and unresolved follow-ups. For WSL migration and uv package-source guidance, record manual or dry-run command review evidence without claiming setup execution unless commands were actually run. Completion evidence lists converted guides, compatibility paths, checks run, and checks intentionally not run.
- Expected result: Judgment-heavy safety and command-contract requirements are reviewable even when static checks cannot prove them fully.
- Failure proves: The branch may pass text checks while missing the human review needed for safety-sensitive setup documentation.
- Automation location: milestone review records and `docs/changes/2026-06-16-remaining-guides-template-rollout/plan.md`

### T-RGT-011. Security and privacy guardrails

- Covers: R25, R38, AC18, EC5
- Level: contract
- Fixture/setup: Repository after each milestone.
- Steps: Scan changed guide, router, review, test, and inventory artifacts for secrets, tokens, proxy credentials, private hostnames, private certificate material, personal paths, user-specific machine names, and credential-like package-index examples. Check uv package-source examples use placeholder-safe, credential-free values and distinguish project-level from user-level configuration.
- Expected result: Published examples and review artifacts do not leak private data or normalize unsafe secret handling.
- Failure proves: The rollout introduced security/privacy risk into documentation or evidence.
- Automation location: `tests/markdown/remaining-guides-template-rollout.test.sh` plus manual diff review.

### T-RGT-012. Static-check boundary and no setup execution

- Covers: R2-R3, R49-R50, R67-R68, AC13-AC14
- Level: contract
- Fixture/setup: `tests/markdown/remaining-guides-template-rollout.test.sh` exists after M1 and is updated per milestone.
- Steps: Inspect and run the proof script. Confirm it checks converted-guide structure without executing guide code blocks, does not contain setup command execution checks, does not require Windows + WSL CI, and scopes converted-guide enforcement to milestone-converted paths. Confirm no generated docs tooling, custom scaffolder, installer, or hidden automation is introduced.
- Expected result: The validation layer proves document structure and links without becoming a workstation setup runner.
- Failure proves: Validation either exceeds the approved no-command-execution boundary or makes unconverted guides fail prematurely.
- Automation location: `tests/markdown/remaining-guides-template-rollout.test.sh`

### T-RGT-013. Completion evidence and lifecycle closeout

- Covers: R74, AC16-AC21
- Level: manual
- Fixture/setup: Repository after M5.
- Steps: Check the plan progress, validation notes, change metadata, and explanation record. Confirm completion evidence states converted guides, compatibility paths, checks run, checks intentionally not run, verification target inventory status, and remaining follow-ups. Confirm no lifecycle artifact claims final verification, branch readiness, PR readiness, or CI success without corresponding evidence.
- Expected result: Downstream explain-change, verify, and PR handoff have coherent source evidence.
- Failure proves: Lifecycle state may overclaim readiness or hide unverified risk.
- Automation location: `docs/changes/2026-06-16-remaining-guides-template-rollout/plan.md`, `change.yaml`, and `explain-change.md`

## Fixtures and data

- Converted-guide path list maintained inside `tests/markdown/remaining-guides-template-rollout.test.sh`, extended milestone by milestone.
- Review evidence under `docs/changes/2026-06-16-remaining-guides-template-rollout/reviews/`.
- Verification target inventory at `docs/changes/2026-06-16-remaining-guides-template-rollout/verification-target-inventory.md`.
- Existing upstream proof scripts under `tests/markdown/`.
- No private machine data, credentials, network access, Windows host, WSL runner, Neovim runtime, tmux session, or uv installation is required.

## Mocking/stubbing policy

No mocks are needed. The tests inspect repository files directly. Compatibility stubs are real Markdown artifacts, not test doubles.

The proof script may use shell helper functions such as `require_file`, `require_text`, `require_regex`, `require_order`, `reject_regex`, and heading-anchor slug helpers, matching existing `tests/markdown/*.test.sh` style.

## Migration or compatibility tests

Migration coverage is required for:

- first smaller-guide numbered paths remaining stable;
- `02-wsl2-ubuntu.md` remaining as a compatibility path after WSL split;
- WSL install and migration task guides being created at the specified paths;
- router behavior before and after WSL split;
- `99-verification.md` sequencing after active referenced paths exist or unresolved targets are inventoried;
- broad final unnumbered filename migration remaining deferred;
- future redirect-style stubs being command-free except harmless navigation or verification commands.

## Observability verification

No logs, metrics, traces, or audit events are introduced.

Required observability is documentation evidence:

- static proof-script failure messages identify the missing path, text, pattern, link, or anchor;
- review records identify guide path, reviewer, review mode, review result, and unresolved follow-ups;
- completion evidence lists converted guides, compatibility paths, checks run, and checks intentionally not run.

## Security/privacy verification

Security/privacy checks are required because the guides can mention package sources, proxy configuration, WSL state, editor runtime state, and machine-changing commands.

The proof must check or manually review that examples and evidence do not include:

- secrets, tokens, proxy credentials, private certificate material, or private hostnames;
- user-specific machine names;
- personal paths beyond documented generic placeholders;
- uv package-index examples that look like private internal indexes or persist credentials into shell history or committed files.

## Performance checks

No runtime performance behavior is introduced.

The static proof script should run locally with ordinary Bash and grep/sed utilities and should stay fast enough for documentation review. If it becomes slow, scope checks to the current milestone converted-path list instead of scanning every Markdown file indiscriminately.

## Manual QA checklist

- For each converted guide, compare command blocks against the pre-edit inventory and `specs/terminal-first-workstation-setup.md`.
- Confirm fast path and walkthrough follow the same high-level task order or explicitly label alternatives.
- Confirm backup guidance appears before file edits or hard-to-undo persistent changes.
- Confirm expected results are near meaningful commands and verification commands.
- Confirm troubleshooting links appear at likely failure points and route to real anchors when anchors are used.
- Confirm no deep recovery procedure moved from troubleshooting into a guide.
- Confirm `06-uv.md` remains optional and credential-free.
- Confirm WSL migration destructive commands are labeled and preceded by backup/export guidance.
- Confirm `99-verification.md` active references are backed by existing paths or unresolved follow-ups.
- Confirm commands were not executed by CI or proof scripts.

## What not to test and why

- Do not execute PowerShell, WSL, Ubuntu, Neovim, tmux, uv, package-manager, mount, sudoers, proxy, or verification setup commands from guide code blocks; the approved spec forbids command-execution CI for this rollout.
- Do not require a Windows + WSL runner; first-slice validation is static and review-based.
- Do not validate real package availability, network access, proxy reachability, certificate trust, WSL import behavior, or editor plugin installation; those are setup/runtime concerns outside this documentation rollout.
- Do not test final unnumbered filename migration beyond boundary checks; it is deferred to a later compatibility slice.
- Do not snapshot entire guides as the main proof; the requirements are structural and behavioral, not exact prose identity.

## Uncovered gaps

None requiring spec or architecture return.

Static checks cannot fully prove command semantics, prose quality, fast-path skimmability, or backup adequacy. Those are covered by mandatory review evidence in T-RGT-010.

## Next artifacts

- `tests/markdown/remaining-guides-template-rollout.test.sh` during M1 implementation.
- Milestone review records under `docs/changes/2026-06-16-remaining-guides-template-rollout/reviews/`.
- `docs/changes/2026-06-16-remaining-guides-template-rollout/verification-target-inventory.md` during the verification conversion slice.
- Implementation milestones M1-M5 from `docs/changes/2026-06-16-remaining-guides-template-rollout/plan.md`.

## Follow-on artifacts

None yet

## Readiness

Approved for implementation.

Ready to begin M1 implementation with tests/proof first. Not ready to claim implementation completion, verification, branch readiness, or PR readiness.
