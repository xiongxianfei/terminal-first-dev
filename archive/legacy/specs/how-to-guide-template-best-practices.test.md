# How-To Guide Template Best Practices Test Spec

## Status

active

## Related spec and plan

- Spec: `specs/how-to-guide-template-best-practices.md`
- Spec review: `docs/changes/2026-06-15-how-to-guide-template-best-practices/reviews/spec-review.md`
- Spec review resolution: `docs/changes/2026-06-15-how-to-guide-template-best-practices/reviews/spec-review-resolution.md`
- Plan: `docs/changes/2026-06-15-how-to-guide-template-best-practices/plan.md`
- Plan review: `docs/changes/2026-06-15-how-to-guide-template-best-practices/reviews/plan-review-r1.md`
- Architecture/ADRs: not applicable for this slice; the approved spec and plan keep the change to Markdown structure, guide conformance evidence, and static validation.

## Testing strategy

The proof surface is documentation-first and static.

- Unit strategy: not applicable; this change does not introduce runtime units or functions.
- Integration strategy: use one repository-level Markdown proof script to check the template, reference exemplar, portability pilot, troubleshooting links, troubleshooting anchors, and validation-boundary contracts together.
- End-to-end strategy: use manual or dry-run evidence for the portability pilot to check whether an experienced reader can use the fast path without reading the walkthrough.
- Smoke strategy: file-existence, required-heading, required-label, and review-record checks prove the expected artifacts exist.
- Manual strategy: reviewer evidence covers qualitative judgments that static grep cannot prove, including fast-path skimmability, walkthrough usefulness, parity, and whether safety/backup guidance is enough for a real reader.
- Contract strategy: static checks map to requirement IDs and acceptance criteria, especially the template contract, guide conformance, backup-before-edit rule, troubleshooting boundary, and no-command-execution boundary.
- Migration strategy: check that the portability pilot remains at `docs/guides/03-ubuntu-baseline.md` unless a non-exemplar replacement pilot is recorded with rationale.

The implementation proof script should be:

```bash
bash tests/markdown/how-to-guide-template-best-practices.test.sh
```

The proof script must not execute setup commands from guide code blocks and must not require Windows, WSL, network access, administrator privileges, or private machine data.

## Requirement coverage map

| Requirement ID | Covered by | Level | Notes |
| --- | --- | --- | --- |
| R1 | T1 | smoke | Canonical template path is checked. |
| R2 | T1, T8 | contract | Template is plain Markdown and no generator/scaffolder/build step is introduced. |
| R3 | T1, T3 | contract | Template contributor notes are allowed; published guides must not retain template-only placeholders or comments. |
| R4 | T1 | contract | Template notes distinguish required and conditional sections. |
| R5 | T1 | contract | Template H1 placeholder is outcome-led. |
| R6 | T1 | contract | Visible metadata appears before setup commands. |
| R7 | T1 | contract | Required metadata labels are checked. |
| R8 | T1, T4 | contract | Conditional `Scope` line and state-changing module are checked. |
| R9 | T1, T4 | contract | Conditional `Safety` line and security-sensitive placement are checked. |
| R10 | T1 | contract | `Fast path` appears before `Walkthrough`. |
| R11 | T1 | contract | `Walkthrough` appears after `Fast path`. |
| R12 | T1, T4 | contract | `Rollback` section and persistent-change requirement language are checked. |
| R13 | T1, T5 | contract | `Troubleshooting` section is a symptom router, not deep recovery. |
| R14 | T1, T3 | contract | Numbered ordered steps are checked in template and guide surfaces. |
| R15 | T1, T2, T3 | contract | Explicit command context is checked near command blocks. |
| R16 | T1, T3 | contract | Expected-result text is checked near meaningful commands and verification. |
| R17 | T1, T5 | contract | Inline troubleshooting link shape is checked. |
| R18 | T1, T4 | contract | State-changing module includes `Scope`, `Backup`, and `Rollback`, with `Backup` before file-edit examples. |
| R19 | T1, T6 | manual | Template parity rule is checked statically; exemplar and pilot parity are reviewed manually. |
| R20 | T1, T5 | contract | Template keeps deep troubleshooting under `docs/troubleshooting/`. |
| R21 | T1, T6 | manual | Template rationale boundary is checked; guide prose is reviewed manually. |
| R22 | T2 | contract | `powershell` fence convention is checked. |
| R23 | T2 | contract | `bash` fence convention is checked. |
| R24 | T2 | contract | Configuration fence convention is checked where applicable. |
| R25 | T2 | contract | Windows and Ubuntu command separation is checked by convention text and review. |
| R26 | T2 | contract | Placeholder definition convention is checked. |
| R27 | T2, T8 | contract | Secret, credential, token, hostname, and certificate-material avoidance is checked. |
| R28 | T2 | contract | Re-runnable command preference is checked by convention text. |
| R29 | T2, T8 | contract | Non-idempotent command caution convention is checked. |
| R30 | T3 | contract | Published guide conformance rejects unremoved placeholders and contributor-only comments. |
| R31 | T3 | contract | Guide metadata remains near the top and before setup commands. |
| R32 | T3 | contract | Guide section order is checked. |
| R33 | T3 | contract | Guide command context is checked. |
| R34 | T3 | contract | Guide expected-result placement is checked. |
| R35 | T4 | contract | State-changing guide scope and rollback guidance are checked. |
| R35a | T4 | contract | Backup-before-edit or concrete not-applicable reason is checked in every path. |
| R36 | T4, T8 | contract | Safety guidance is checked for security, persistence, storage, identity, proxy, sudoers, fstab, WSL config, package source, execution policy, trust store, and editor runtime topics. |
| R37 | T5 | contract | Inline troubleshooting links are checked when matching anchors exist. |
| R38 | T5 | contract | Guide-local deep recovery branches are rejected by review and script guardrails. |
| R39 | T3, T6 | manual | Walkthrough prose is reviewed for task relevance and non-tutorial scope. |
| R40 | T6 | manual | Proxy guide is recorded as reference exemplar, not sole pilot. |
| R41 | T6, T7 | migration | Ubuntu baseline remains the portability pilot unless a replacement is recorded. |
| R42 | T6 | manual | Portability pilot evidence records fast-path-only usability. |
| R43 | T6 | manual | Pilot reviewer separation or exception is recorded. |
| R44 | T6 | manual | Pilot evidence records Windows 11 + WSL execution or documented dry-run mode. |
| R45 | T6 | manual | Fast-path success requires reaching the verification signal without walkthrough text. |
| R46 | T7 | contract | Static structure checks cover required metadata and sections. |
| R47 | T5, T7 | contract | Troubleshooting file links resolve. |
| R48 | T5, T7 | contract | Troubleshooting anchors resolve. |
| R49 | T7, T8 | contract | First-slice validation does not execute setup commands. |
| R50 | T7 | contract | First-slice validation does not require Windows + WSL CI. |
| R51 | T8 | contract | Command-execution validation remains deferred to later accepted artifacts. |
| R52 | T8 | contract | Changed artifacts do not alter setup command semantics. |
| R53 | T8 | contract | Existing two-speed guide structure compatibility is checked. |
| R54 | T7 | migration | `03-ubuntu-baseline.md` is not renamed by this slice. |
| Error behavior | T3, T4, T5, T6, T7, T8 | contract | Boundary cases are covered by static checks, review records, or manual review. |
| AC1 | T1, T9 | contract | Template file and required core sections are checked. |
| AC2 | T1, T4, T9 | contract | Conditional state-changing module and backup-before-edit placement are checked. |
| AC3 | T2, T9 | contract | Explicit command context is checked. |
| AC4 | T1, T3, T9 | contract | Expected-result text is checked near meaningful commands and verification. |
| AC5 | T5, T9 | contract | Inline troubleshooting links are checked. |
| AC6 | T2, T9 | contract | Command-block conventions are checked. |
| AC7 | T6, T9 | manual | Proxy guide is reviewed as reference exemplar, not sole pilot. |
| AC8 | T6, T7, T9 | manual | Ubuntu baseline is reviewed as portability pilot or replacement is recorded. |
| AC9 | T4, T6, T9 | contract | Pilot backup coverage is checked where user-owned or system-owned files are edited. |
| AC10 | T4, T7, T9 | contract | Review checklist or proof script records conditional safety-module coverage. |
| AC11 | T7, T8, T9 | contract | First-slice validation avoids command execution and Windows + WSL CI requirements. |
| AC12 | T8, T9 | contract | Generated tooling, hidden automation, installer behavior, and command-semantic drift are excluded. |
| AC13 | T2, T8, T9 | contract | Security-sensitive examples avoid private or credential material. |
| AC14 | T9 | contract | Proposal status is checked as `accepted`. |

## Example coverage map

| Example | Covered by | Notes |
| --- | --- | --- |
| E1 | T1, T9 | Contributor-copy template behavior is checked through template structure and acceptance proof. |
| E2 | T3, T6 | Fast-path-only reader behavior is checked statically and through pilot evidence. |
| E3 | T3, T6 | Walkthrough parity and task-relevant context are checked by guide conformance and manual review. |
| E4 | T4 | State-changing recovery visibility is checked through scope, safety, backup, and rollback coverage. |
| E5 | T5 | Troubleshooting links and deep-recovery boundary are checked. |
| E6 | T6 | Circular validation is avoided by separate reference exemplar and portability pilot evidence. |

## Edge case coverage

| Edge case | Covered by | Level | Notes |
| --- | --- | --- | --- |
| EC1 | T1, T4 | contract | Verification-only guides may mark recovery fields not applicable when no recovery need is hidden. |
| EC2 | T1, T3 | contract | One-step procedures still use numbered steps. |
| EC3 | T2, T3 | contract | Windows and Ubuntu commands are split with explicit context. |
| EC4 | T2, T3 | contract | Configuration snippets use appropriate fences and name their target. |
| EC5 | T2, T4 | contract | Re-runnable state-changing steps can be labeled safe to rerun. |
| EC6 | T2, T4 | contract | Non-idempotent steps are labeled before the command and include recovery guidance. |
| EC7 | T5 | contract | Missing troubleshooting anchors are not faked. |
| EC8 | T6 | manual | Dry-run pilot evidence is allowed but cannot claim command execution passed. |
| EC9 | T3 | contract | Contributor comments or placeholders in published guides fail conformance. |
| EC10 | T6 | manual | Exemplar success alone is insufficient; portability-pilot defects trigger template revision before broad conversion. |
| EC11 | T1, T3 | manual | Long rationale is kept out of guides or linked to ADR/architecture notes. |
| EC12 | T4, T6 | manual | Enterprise policy assumptions are recorded near prerequisites, scope, safety, or affected commands. |

## Test cases

### T1. Template core contract

- Covers: R1-R21, E1, EC1-EC2, EC11
- Level: integration
- Fixture/setup: Repository after M1 implementation.
- Steps: Check `docs/templates/how-to-guide.md` exists and is plain Markdown. Verify it includes an outcome-led H1 placeholder; visible metadata labels for `Prerequisites`, `Time`, `Outcome`, `Verify`, conditional `Scope`, and conditional `Safety`; `## Fast path`, `## Walkthrough`, `## Rollback`, and `## Troubleshooting` in order; numbered procedure examples; expected-result text; inline troubleshooting link shape; contributor notes that distinguish required and conditional sections; parity, troubleshooting-boundary, and rationale-boundary guidance.
- Expected result: The template is a copyable contributor-facing contract for two-speed how-to guides without requiring a generator or custom docs build step.
- Failure proves: Contributors do not have a stable reusable artifact for guide conformance.
- Automation location: `tests/markdown/how-to-guide-template-best-practices.test.sh`

### T2. Command-block conventions

- Covers: R15, R22-R29, EC3-EC6
- Level: contract
- Fixture/setup: Repository after M1 implementation.
- Steps: Check the template documents `powershell`, `bash`, and configuration fences such as `ini`, `toml`, `lua`, or `tmux`; requires environment context before commands; states that Windows and Ubuntu commands are not mixed in one block; requires placeholder definitions before use; prohibits secrets, proxy credentials, tokens, private hostnames, and private certificate material; prefers re-runnable commands; and labels non-idempotent commands before the command.
- Expected result: Command-block conventions are explicit enough for reviewers to catch wrong-shell and unsafe-example defects.
- Failure proves: The template can still produce ambiguous or security-sensitive command examples.
- Automation location: `tests/markdown/how-to-guide-template-best-practices.test.sh`

### T3. Published guide conformance shape

- Covers: R3, R14-R16, R30-R34, R39, E2-E3, EC2-EC4, EC9, EC11
- Level: integration
- Fixture/setup: Repository after M2 implementation with `docs/guides/proxy-setup.md` and `docs/guides/03-ubuntu-baseline.md` reviewed or updated.
- Steps: Check each guide under review has reader-facing metadata near the top before setup commands, `Fast path` before `Walkthrough`, numbered steps where sequence matters, explicit command or snippet context, expected-result text near meaningful commands and verification commands, and no unremoved template placeholders or contributor-only comments. Manually review whether walkthrough prose stays task-relevant and does not become a tutorial.
- Expected result: Published guides can be skimmed and reviewed consistently without leaking template-only authoring instructions.
- Failure proves: A guide may appear converted while missing the core reader-facing contract.
- Automation location: `tests/markdown/how-to-guide-template-best-practices.test.sh` plus manual notes in the exemplar and portability-pilot review records.

### T4. Safety, backup, and rollback coverage

- Covers: R8-R9, R12, R18, R35-R36, R35a, E4, EC1, EC5-EC6, EC12
- Level: integration
- Fixture/setup: Repository after M1 and M2 implementation.
- Steps: Check the template has a conditional state-changing module with `Scope`, `Backup`, and `Rollback`, with `Backup` before example commands, editor instructions, or snippets that edit user-owned or system-owned files. Check state-changing guides under review include scope and rollback guidance. Check file-editing or hard-to-undo paths include backup guidance before the edit/change in both fast path and walkthrough, or a concrete not-applicable reason. Check security-sensitive or persistent changes include safety guidance near metadata or the affected command.
- Expected result: Readers see recovery and safety context before relying on persistent changes.
- Failure proves: The guide may pass shape checks while hiding recovery needs or presenting an unsafe edit path.
- Automation location: `tests/markdown/how-to-guide-template-best-practices.test.sh`

### T5. Troubleshooting link and anchor boundary

- Covers: R13, R17, R20, R37-R38, R47-R48, E5, EC7
- Level: integration
- Fixture/setup: Repository after M2 and M3 implementation with existing troubleshooting documents under `docs/troubleshooting/`.
- Steps: Check guide links to troubleshooting use relative `../troubleshooting/<topic>.md#<anchor>` targets when anchors exist. Resolve each target file and anchor. Check guides keep final troubleshooting sections as symptom routers and do not embed long deep-recovery branches. Check guides do not invent fake anchors for missing troubleshooting coverage.
- Expected result: Failure-point routing is precise and deep recovery remains in troubleshooting docs.
- Failure proves: A blocked reader may hit dead links or find guide-local recovery content that belongs elsewhere.
- Automation location: `tests/markdown/how-to-guide-template-best-practices.test.sh`

### T6. Exemplar and portability-pilot evidence

- Covers: R19, R21, R39-R45, E2-E3, E6, EC8, EC10, EC12
- Level: manual
- Fixture/setup: `docs/changes/2026-06-15-how-to-guide-template-best-practices/exemplar-review.md` and `docs/changes/2026-06-15-how-to-guide-template-best-practices/portability-pilot-review.md` exist after M2.
- Steps: Review `docs/guides/proxy-setup.md` as the reference exemplar and record that it is not the sole pilot. Review `docs/guides/03-ubuntu-baseline.md`, or a documented non-exemplar replacement, as the portability pilot. Record reviewer, whether the reviewer authored the template or why separation was not possible, review mode, starting prerequisites, Windows 11 + WSL execution or dry-run status, fast-path result, verification signal, walkthrough use, defects found, backup coverage, and whether the guide felt too heavy or unclear.
- Expected result: The template is validated against both the demanding reference exemplar and an independent guide, and fast-path success is not claimed unless the verification signal is reachable without walkthrough text.
- Failure proves: Validation is circular, under-evidenced, or overclaims execution that did not happen.
- Automation location: manual records at `docs/changes/2026-06-15-how-to-guide-template-best-practices/exemplar-review.md` and `docs/changes/2026-06-15-how-to-guide-template-best-practices/portability-pilot-review.md`

### T7. Static proof script and migration boundary

- Covers: R41, R46-R50, R54
- Level: contract
- Fixture/setup: Repository after M3 implementation.
- Steps: Check `tests/markdown/how-to-guide-template-best-practices.test.sh` exists, is runnable with Bash, checks required metadata and sections, resolves troubleshooting file links and anchors, records backup/safety-module coverage, does not execute guide code-block commands, does not require Windows + WSL CI, and does not rename `docs/guides/03-ubuntu-baseline.md`.
- Expected result: Reviewers have a lightweight local proof that enforces stable structure without becoming a setup runner.
- Failure proves: Validation either undercovers the documentation contract or oversteps the first-slice execution boundary.
- Automation location: `tests/markdown/how-to-guide-template-best-practices.test.sh`

### T8. Non-goal, security, and compatibility guardrails

- Covers: R2, R27, R29, R36, R49-R53, AC11-AC13
- Level: contract
- Fixture/setup: Repository after M1-M3 implementation.
- Steps: Check changed artifacts do not introduce generated docs tooling, a one-command installer, hidden setup automation, command-execution CI, Windows + WSL runner requirements, or new command semantics for PowerShell, WSL, Ubuntu, Neovim, tmux, proxy, sudoers, fstab, mounts, package sources, execution policy, trust stores, or editor runtime behavior. Check examples and evidence avoid secrets, credentials, tokens, private hostnames, personal paths, private certificate material, and user-specific machine names. Check compatibility with `specs/guides-two-speed-how-to-structure.md`.
- Expected result: The change remains a documentation-template and static-validation slice with no hidden setup behavior change.
- Failure proves: Implementation exceeded the approved spec boundary or introduced security/privacy risk.
- Automation location: `tests/markdown/how-to-guide-template-best-practices.test.sh` plus manual diff review for command-semantic drift.

### T9. Acceptance criteria proof

- Covers: AC1-AC14
- Level: integration
- Fixture/setup: Repository after M1-M3 implementation and M4 evidence updates.
- Steps: Check the template exists with metadata, sections, conditional state-changing module, command context, expected results, troubleshooting links, and command-block conventions. Check proxy exemplar and Ubuntu baseline portability-pilot evidence exist. Check backup coverage is recorded. Check the proof script or review checklist records conditional safety-module coverage. Check first-slice validation does not execute setup commands or require Windows + WSL CI. Check changed artifacts do not introduce generated tooling, installer behavior, hidden automation, command-semantic drift, or sensitive examples. Check the proposal status is `accepted`.
- Expected result: Every acceptance criterion has an observable artifact, script assertion, or manual evidence record.
- Failure proves: The change is not ready for implementation closeout even if individual milestones appear complete.
- Automation location: `tests/markdown/how-to-guide-template-best-practices.test.sh` plus M4 validation notes in `docs/changes/2026-06-15-how-to-guide-template-best-practices/plan.md`

## Fixtures and data

- Existing source spec: `specs/how-to-guide-template-best-practices.md`.
- Existing related structure spec: `specs/guides-two-speed-how-to-structure.md`.
- Existing template target: `docs/templates/how-to-guide.md`.
- Reference exemplar: `docs/guides/proxy-setup.md`.
- Portability pilot: `docs/guides/03-ubuntu-baseline.md`.
- Existing troubleshooting docs under `docs/troubleshooting/`.
- Planned proof script: `tests/markdown/how-to-guide-template-best-practices.test.sh`.
- Planned exemplar evidence: `docs/changes/2026-06-15-how-to-guide-template-best-practices/exemplar-review.md`.
- Planned portability-pilot evidence: `docs/changes/2026-06-15-how-to-guide-template-best-practices/portability-pilot-review.md`.

No external services, credentials, private proxy data, Windows/WSL execution environment, administrator privileges, or network access are required for the automated proof.

## Mocking/stubbing policy

No mocks or stubs are needed. Static tests inspect repository files directly. Manual pilot evidence may use a documented dry-run review when a Windows 11 + WSL Ubuntu environment is unavailable, but the record must not claim setup command execution passed unless the reviewer actually ran the relevant commands.

## Migration or compatibility tests

Migration coverage is T7 and T8. The tests verify that `docs/guides/03-ubuntu-baseline.md` remains the portability pilot path unless a non-exemplar replacement is recorded with rationale, and that this slice remains compatible with `specs/guides-two-speed-how-to-structure.md`.

This test spec does not require broad guide renames, redirects, generated documentation tooling, or migration of every numbered guide.

## Observability verification

The proof script should print actionable failures that name the missing file, heading, metadata label, command convention, guide path, source link, target file, or missing anchor.

Exemplar and portability-pilot evidence must record:

- guide path;
- reviewer;
- whether reviewer separation from template authorship was possible;
- review mode;
- starting prerequisites;
- fast-path result;
- verification signal;
- whether walkthrough text was needed;
- backup coverage;
- defects found;
- command execution status.

Completion notes for this change must report which checks were run and must not claim CI or setup command execution passed unless observed.

## Security/privacy verification

Automated checks should look for guardrail language around secrets, proxy credentials, tokens, private hostnames, private certificate material, personal paths, one-command installers, generated command flows, and command-execution CI where practical.

Manual review must confirm template examples, guide content, exemplar evidence, and portability-pilot evidence do not contain credentials, tokens, private hostnames, private certificate material, user-specific machine names, or other private machine data.

The tests must not execute setup commands that affect WSL configuration, proxy behavior, trust stores, sudoers, fstab, package sources, execution policy, editor runtime state, or machine-wide state.

## Performance checks

The proof script should run as a lightweight local Markdown/static check using Bash, `test`, `grep`, `sed`, and `rg` where practical, matching the existing `tests/markdown/*.test.sh` style.

No timing benchmark is required. The only time-related evidence is the guide metadata and any manual approximate review time recorded in the exemplar or portability-pilot evidence.

## Manual QA checklist

- Confirm the template is copyable plain Markdown and does not read like a published guide.
- Confirm contributor notes identify required and conditional sections and are removable.
- Confirm the fast path stays command-forward and does not duplicate the full walkthrough.
- Confirm the walkthrough follows the fast path's high-level step order and adds only task-relevant context.
- Confirm command contexts make wrong-shell execution unlikely.
- Confirm backup guidance appears before user-owned or system-owned file edits in every path that instructs the edit.
- Confirm rollback guidance is visible for persistent machine-changing guides.
- Confirm inline troubleshooting links appear at likely failure points and resolve when anchors exist.
- Confirm reference exemplar evidence does not substitute for portability-pilot evidence.
- Confirm portability-pilot evidence does not claim execution when the review was a dry run.
- Confirm no private proxy, certificate, host, credential, token, personal path, or machine-specific data appears in guide or review evidence.
- Confirm command semantics still defer to accepted setup specs and are not changed by the template work.

## What not to test and why

- Do not execute setup commands from guide code blocks; the approved spec explicitly defers command-execution validation.
- Do not require a Windows + WSL CI runner; first-slice validation is static and local.
- Do not test exact PowerShell, WSL, Ubuntu, Neovim, tmux, proxy, sudoers, fstab, mount, or package-source command contracts; those are outside this spec unless later accepted artifacts define them.
- Do not require every guide in `docs/guides/` to be converted in this slice; broad guide conversion is out of scope.
- Do not require generated scaffolding, a documentation site, a wizard, or a template engine; the template remains plain Markdown.
- Do not rely only on snapshots; checks must assert concrete headings, metadata, links, anchors, and boundary language.

## Uncovered gaps

None blocking implementation. Qualitative judgments about fast-path skimmability, walkthrough usefulness, and command-semantic drift remain manual review obligations because the approved first slice intentionally avoids executing setup commands or building a semantic command parser.

## Next artifacts

- Implement M1 using this test spec as the proof contract for `docs/templates/how-to-guide.md`.
- Implement M2 exemplar and portability-pilot review evidence.
- Implement M3 static proof script at `tests/markdown/how-to-guide-template-best-practices.test.sh`.
- Use code-review after implementation milestones produce a diff.

## Follow-on artifacts

None yet

## Readiness

Active proof contract for implementation. The next implementation stage should add or update proof surfaces before changing the template and guide conformance artifacts.
