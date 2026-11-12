# Plan: How-To Guide Template Best Practices

## Status

- Plan lifecycle state: draft
- Terminal disposition: not-terminal

## Purpose / big picture

This plan sequences the approved how-to guide template spec into reviewable implementation slices. The work updates the reusable contributor template, checks the proxy reference exemplar and Ubuntu baseline portability pilot against the stronger contract, and adds lightweight validation for template and guide conformance.

The plan keeps the project documentation-first. It does not change setup command semantics, add command-execution CI, introduce generated documentation tooling, or hide setup behind automation.

## Source artifacts

- Proposal: `docs/proposals/2026-06-15-how-to-guide-template-best-practices.md`
- Proposal review: `docs/changes/2026-06-15-how-to-guide-template-best-practices/reviews/proposal-review.md`
- Spec: `specs/how-to-guide-template-best-practices.md`
- Spec review: `docs/changes/2026-06-15-how-to-guide-template-best-practices/reviews/spec-review.md`
- Spec review resolution: `docs/changes/2026-06-15-how-to-guide-template-best-practices/reviews/spec-review-resolution.md`
- Upstream structure spec: `specs/guides-two-speed-how-to-structure.md`
- Architecture: not required because the approved spec changes documentation structure and static validation expectations only.
- Test spec: pending; next after plan-review.

## Context and orientation

The repository already has the earlier two-speed guide structure implemented:

- `docs/templates/how-to-guide.md` is the existing reusable template.
- `docs/guides/proxy-setup.md` is the reference exemplar.
- `docs/guides/03-ubuntu-baseline.md` is the portability pilot for this change.
- `docs/troubleshooting/` owns deep recovery content.
- `tests/markdown/guides-two-speed-how-to-structure.test.sh` is the existing guide-structure proof from the prior change.

This change tightens the template and guide conformance rules. The biggest safety addition is backup guidance: published guides that edit user-owned or system-owned files, or describe hard-to-undo persistent state changes, need backup guidance before the edit in every path that tells the reader to perform it, or a concrete not-applicable reason.

The proxy guide already received a fast-path backup cue while resolving `HGT-SR-001`. Implementation must preserve that cue and validate the walkthrough cue as part of the exemplar review.

## Non-goals

- Do not rewrite all guides.
- Do not rename numbered guide paths.
- Do not redefine PowerShell, WSL, Ubuntu, Neovim, tmux, proxy, sudoers, fstab, mount, package-source, or editor-runtime command semantics.
- Do not move deep troubleshooting into guide pages.
- Do not create a generated documentation site, scaffolder, wizard, or template engine.
- Do not create a one-command installer or hidden setup automation.
- Do not execute guide command blocks in CI during this slice.
- Do not create beginner tutorials inside `docs/guides/`.

## Requirements covered

| Requirements | Planned coverage |
| --- | --- |
| R1-R21 | M1 updates `docs/templates/how-to-guide.md` with the required core, conditional safety modules, troubleshooting relationship, rationale boundary, and removable contributor notes. |
| R22-R29 | M1 records command-block conventions for PowerShell, Bash, config fences, placeholder definition, secret avoidance, rerunnable commands, and non-idempotent cautions. |
| R30-R39 | M2 reviews and updates published-guide conformance for exemplar and pilot guide behavior, including metadata, command context, expected results, safety, backup, rollback, troubleshooting, and walkthrough scope. |
| R40-R45 | M2 treats `proxy-setup.md` as reference exemplar and `03-ubuntu-baseline.md` as portability pilot, with fast-path-only review evidence. |
| R46-R51 | M3 adds or updates static structure, link, anchor, and no-command-execution validation. |
| R52-R54 | M1-M3 preserve existing command semantics, compatibility with the upstream two-speed spec, and the current `03-ubuntu-baseline.md` path. |
| AC1-AC6 | M1 validates the template contract and command-block conventions. |
| AC7-AC9 | M2 validates exemplar and portability pilot evidence, including backup guidance for `.wslconfig` edits. |
| AC10-AC13 | M3 validates review-check coverage, no command execution, no generated tooling or hidden automation, and secret-free examples. |
| AC14 | Upstream status settlement before this plan normalized the spec to `approved`. |

## Current Handoff Summary

- Current milestone: M4
- Current milestone state: closed
- Last reviewed milestone: M4 code-review R1
- Review status: clean-with-notes
- Remaining in-scope implementation milestones: none
- Next stage: pr
- Final closeout readiness: branch-ready for PR handoff
- Reason final closeout is or is not ready: M1-M4 are closed after code review, durable explanation exists, and final local verification passed. PR handoff has not run.

## Milestones

### M1. Template contract update

- Milestone state: closed
- Goal: Update the reusable how-to guide template so contributors can copy a spec-conformant structure for new guides.
- Requirements: R1-R29, R52-R54, AC1-AC6, AC12-AC13
- Files/components likely touched:
  - `docs/templates/how-to-guide.md`
- Dependencies:
  - Approved plan-review.
  - Test spec defining template checks before implementation begins.
- Tests to add/update:
  - Static template checks in `tests/markdown/how-to-guide-template-best-practices.test.sh`.
- Implementation steps:
  - Add or revise removable contributor notes that distinguish required core from conditional modules.
  - Ensure the template has visible metadata placeholders for `Prerequisites`, `Time`, `Outcome`, `Verify`, conditional `Scope`, and conditional `Safety`.
  - Ensure `Fast path`, `Walkthrough`, `Rollback`, and `Troubleshooting` are present in order.
  - Place `Backup` before any example file edit in the conditional state-changing module.
  - Document command-block conventions for `powershell`, `bash`, config fences, placeholder definition, secret avoidance, and non-idempotent commands.
  - Keep deep troubleshooting and durable rationale outside guide prose.
- Validation commands:
  - `test -f docs/templates/how-to-guide.md`
  - `rg -n "Prerequisites|Time|Outcome|Verify|Scope|Safety" docs/templates/how-to-guide.md`
  - `rg -n "^## Fast path$|^## Walkthrough$|^## Rollback$|^## Troubleshooting$" docs/templates/how-to-guide.md`
  - `rg -n "Backup|Rollback|Scope|powershell|bash|not idempotent|secrets|troubleshooting" docs/templates/how-to-guide.md`
  - `git diff --cached --check`
- Expected observable result: The template is copyable, plain Markdown, and includes the required core plus conditional safety, backup, rollback, command-context, and troubleshooting conventions.
- Commit message: `M1: update how-to guide template contract`
- Milestone closeout:
  - validation passed
  - progress updated
  - decision log updated if needed
  - validation notes updated
  - milestone committed
- Risks:
  - Template becomes too heavy for simple guides.
  - Contributor comments leak into published guides.
- Rollback/recovery:
  - Revert `docs/templates/how-to-guide.md` to the previous template and reapply only the required core if review finds the conditional module too heavy.

### M2. Exemplar and portability pilot conformance

- Milestone state: closed
- Goal: Validate the template against the demanding proxy exemplar and the independent Ubuntu baseline portability pilot.
- Requirements: R30-R45, R52-R54, AC7-AC9, AC12-AC13
- Files/components likely touched:
  - `docs/guides/proxy-setup.md`
  - `docs/guides/03-ubuntu-baseline.md`
  - `docs/changes/2026-06-15-how-to-guide-template-best-practices/exemplar-review.md`
  - `docs/changes/2026-06-15-how-to-guide-template-best-practices/portability-pilot-review.md`
- Dependencies:
  - M1 closed.
  - Test spec defines the required review evidence fields.
- Tests to add/update:
  - Static guide conformance checks for metadata, section order, command context, expected results, backup guidance, rollback, and troubleshooting links.
  - Manual or dry-run evidence records for the reference exemplar and portability pilot.
- Implementation steps:
  - Review `proxy-setup.md` as the reference exemplar without treating it as the only pilot.
  - Preserve or add backup guidance before `.wslconfig` edits in both fast path and walkthrough.
  - Review `03-ubuntu-baseline.md` as the portability pilot and update only the parts needed for template conformance.
  - Record reviewer, review mode, starting prerequisites, fast-path result, verification signal, defects, and backup coverage.
  - Keep command semantics aligned with existing accepted setup specs.
- Validation commands:
  - `rg -n "Backup: if \`%UserProfile%\\\\.wslconfig\` already exists|Backup behavior: if the file already exists" docs/guides/proxy-setup.md`
  - `rg -n "^## Fast path$|^## Walkthrough$|Prerequisites|Outcome|Verify" docs/guides/proxy-setup.md docs/guides/03-ubuntu-baseline.md`
  - `rg -n "Run from|Expected result|Rollback|Troubleshooting|Backup" docs/guides/proxy-setup.md docs/guides/03-ubuntu-baseline.md`
  - `test -f docs/changes/2026-06-15-how-to-guide-template-best-practices/exemplar-review.md`
  - `test -f docs/changes/2026-06-15-how-to-guide-template-best-practices/portability-pilot-review.md`
  - `git diff --cached --check`
- Expected observable result: The exemplar and portability pilot show that the template works beyond a single source guide, and review evidence captures fast-path usability and backup coverage.
- Commit message: `M2: validate how-to guide exemplar and pilot`
- Milestone closeout:
  - validation passed
  - progress updated
  - decision log updated if needed
  - validation notes updated
  - milestone committed
- Risks:
  - The portability pilot reveals the template is too heavy for non-proxy setup content.
  - Existing `03-ubuntu-baseline.md` command flow is changed unintentionally.
- Rollback/recovery:
  - Revert guide edits for this milestone and record the pilot defect in the plan before revising the template or spec.

### M3. Static validation checks

- Milestone state: closed
- Goal: Add lightweight static validation for template and guide conformance without executing setup command blocks.
- Requirements: R46-R54, AC10-AC13
- Files/components likely touched:
  - `tests/markdown/how-to-guide-template-best-practices.test.sh`
  - `tests/markdown/`
  - `docs/plans/2026-06-15-how-to-guide-template-best-practices.md`
- Dependencies:
  - M1 and M2 closed.
  - Test spec approved enough to define the validation contract.
- Tests to add/update:
  - New static proof script for template, exemplar, portability pilot, troubleshooting links, anchors, backup coverage, and no-command-execution guardrails.
- Implementation steps:
  - Add a focused shell script under `tests/markdown/`.
  - Check template sections, metadata, command conventions, conditional safety module, and backup placement cues.
  - Check guide links to troubleshooting files and anchors resolve where referenced.
  - Check the script does not execute guide command blocks or require Windows/WSL.
  - Include negative checks for generated docs tooling, one-command installer language, and hidden automation if practical.
- Validation commands:
  - `bash tests/markdown/how-to-guide-template-best-practices.test.sh`
  - `git diff --cached --name-only`
  - `git diff --cached --check`
- Expected observable result: Reviewers can run one local static proof for the stable template and guide-conformance contract without executing setup commands.
- Commit message: `M3: add how-to template validation`
- Milestone closeout:
  - validation passed
  - progress updated
  - decision log updated if needed
  - validation notes updated
  - milestone committed
- Risks:
  - Static checks overfit current prose instead of stable contract.
  - Anchor parsing misses a valid Markdown heading form.
- Rollback/recovery:
  - Reduce brittle checks to required headings, metadata, links, and backup cues; leave qualitative concerns to review evidence.

### M4. Lifecycle closeout and evidence

- Milestone state: closed
- Goal: Complete change-local evidence and prepare the change for final downstream gates after implementation milestones are closed.
- Requirements: AC10-AC14
- Files/components likely touched:
  - `docs/plans/2026-06-15-how-to-guide-template-best-practices.md`
  - `docs/changes/2026-06-15-how-to-guide-template-best-practices/explain-change.md`
  - `docs/changes/2026-06-15-how-to-guide-template-best-practices/verify-report.md`
  - `docs/changes/2026-06-15-how-to-guide-template-best-practices/pr.md`
- Dependencies:
  - M1-M3 closed.
  - Code review and any review-resolution complete.
- Tests to add/update:
  - Not applicable; this milestone records downstream lifecycle evidence after implementation validation exists.
- Implementation steps:
  - Update plan progress, validation notes, and current handoff summary.
  - Record change rationale in explain-change.
  - Run final verification when requested by the workflow.
  - Prepare PR handoff only after verification passes.
- Validation commands:
  - `bash tests/markdown/how-to-guide-template-best-practices.test.sh`
  - `git diff --check`
- Expected observable result: The change has coherent plan, rationale, verification, and handoff evidence without claiming final readiness prematurely.
- Commit message: `M4: close how-to template plan evidence`
- Milestone closeout:
  - validation passed
  - progress updated
  - decision log updated if needed
  - validation notes updated
  - milestone committed
- Risks:
  - Closeout wording implies branch or PR readiness before verify.
- Rollback/recovery:
  - Keep the plan active and name the missing downstream gate instead of marking terminal state too early.

## Validation plan

- `test -f docs/templates/how-to-guide.md`: proves the reusable template exists.
- `rg -n "Prerequisites|Time|Outcome|Verify|Scope|Safety" docs/templates/how-to-guide.md`: checks visible metadata coverage.
- `rg -n "^## Fast path$|^## Walkthrough$|^## Rollback$|^## Troubleshooting$" docs/templates/how-to-guide.md`: checks template section coverage.
- `rg -n "Backup|Rollback|Scope|powershell|bash|not idempotent|secrets|troubleshooting" docs/templates/how-to-guide.md`: checks safety, rollback, command, and troubleshooting conventions.
- `rg -n "^## Fast path$|^## Walkthrough$|Prerequisites|Outcome|Verify" docs/guides/proxy-setup.md docs/guides/03-ubuntu-baseline.md`: checks exemplar and pilot top-level shape.
- `rg -n "Backup: if \`%UserProfile%\\\\.wslconfig\` already exists|Backup behavior: if the file already exists" docs/guides/proxy-setup.md`: checks proxy `.wslconfig` backup coverage.
- `bash tests/markdown/how-to-guide-template-best-practices.test.sh`: planned proof after test-spec and implementation.
- `git diff --cached --check`: staged whitespace validation during implementation.
- `git diff --check`: final whitespace validation across unstaged changes when staging is not used.

## Risks and recovery

- Risk: The template becomes too heavy for simple guides.
  - Recovery: Keep only the required core universal and make safety, scope, backup, and rollback conditional.
- Risk: The portability pilot reveals that template language is proxy-specific.
  - Recovery: Revise the template wording before applying it to future guides.
- Risk: Backup checks become brittle or miss file-editing cases.
  - Recovery: Keep static checks focused on known pilot edits and require review checklist evidence for broader cases.
- Risk: Static checks imply command correctness.
  - Recovery: Keep no-command-execution language explicit in tests, docs, and completion notes.
- Risk: Existing guide command semantics drift during conformance edits.
  - Recovery: Revert command-flow changes and keep setup behavior governed by existing accepted setup specs.

## Dependencies

- Plan-review approval before implementation.
- Test spec after plan-review and before implementation.
- Existing `specs/guides-two-speed-how-to-structure.md` remains the upstream guide-structure contract.
- Existing `specs/terminal-first-workstation-setup.md` remains authoritative for setup command semantics.
- Troubleshooting anchors referenced by exemplar or pilot guides must exist or be created in the same implementation slice.

## Progress

- 2026-06-15: Plan created after proposal acceptance, spec approval, and second-pass spec-review approval.
- 2026-06-15: Upstream status settlement normalized `specs/how-to-guide-template-best-practices.md` from `draft` to `approved`.
- 2026-06-15: HGT-SR-001 resolution already added proxy fast-path backup guidance before the `.wslconfig` edit; implementation must preserve and validate it.
- 2026-06-15: Plan review R1 approved the plan with no material findings, and the test spec was approved as the active proof contract.
- 2026-06-15: M1 implementation started with the template proof script before changing `docs/templates/how-to-guide.md`.
- 2026-06-15: M1 template implementation completed targeted validation and moved to `review-requested`.
- 2026-06-15: M1 code review R1 closed with `clean-with-notes` and no material findings.
- 2026-06-15: M2 implementation started by extending the static proof script to cover guide conformance and required exemplar/pilot evidence before changing the portability pilot.
- 2026-06-15: M2 implementation completed targeted validation and moved to `review-requested`.
- 2026-06-15: M2 code review R1 closed with `clean-with-notes` and no material findings.
- 2026-06-15: M3 implementation extended the proof script with troubleshooting link/anchor resolution, no-command-execution guardrails, no-Windows-WSL-runner guardrails, pilot path compatibility checks, and secret/generated-tooling negative checks.
- 2026-06-15: M3 code review R1 closed with `clean-with-notes` and no material findings.
- 2026-06-15: M4 implementation added the AC14 proposal-status assertion to the static proof and refreshed change-local rationale and handoff evidence without creating verify or PR artifacts early.
- 2026-06-15: M4 code review R1 closed with `clean-with-notes` and no material findings.
- 2026-06-15: Final verification found and fixed stale broad-smoke expectations for the converted Ubuntu pilot, restored exact Ubuntu baseline semantic cues, ran the targeted proof and full Markdown/static suite, and recorded `verify-report.md`.

## Decision log

| Date | Decision | Reason | Alternatives rejected |
| --- | --- | --- | --- |
| 2026-06-15 | Use four milestones: template, exemplar/pilot, validation, lifecycle closeout | Keeps implementation reviewable while preserving downstream lifecycle gates | One large documentation rewrite |
| 2026-06-15 | Put the concrete plan under `docs/changes/2026-06-15-how-to-guide-template-best-practices/plan.md` | Matched `docs/workflows.md` change-plan mapping at the time | `docs/plans/YYYY-MM-DD-slug.md` portable fallback |
| 2026-06-17 | Migrate the concrete plan to `docs/plans/2026-06-15-how-to-guide-template-best-practices.md` | Owner updated workflow routing so plan bodies live under `docs/plans/` | Keeping the plan body under `docs/changes/<change-id>/plan.md` |
| 2026-06-15 | Treat architecture as not required before planning | The approved spec-review states this is documentation structure and validation work, not scripts, generated files, data flow, or machine-changing automation | Creating an architecture package for documentation-only structure |

## Surprises and discoveries

- `docs/plan.md` already has an active first-slice workstation setup plan, so this plan is added as a second active planning item rather than replacing that work.
- The proxy guide fast-path backup cue already exists from HGT-SR-001 resolution and should be preserved during M2.
- The first run of `tests/markdown/how-to-guide-template-best-practices.test.sh` failed against the previous template because the template lacked removable contributor guidance and the new conditional template contract; this was the expected proof-first failure for M1.

## Validation notes

- Plan authoring validation:
  - `rg` checks confirmed spec review approval, no open findings, and current spec status before settlement.
  - `git diff --check` should be run after plan file creation.
- M1 proof-first validation:
  - `bash tests/markdown/how-to-guide-template-best-practices.test.sh` failed before the template change with `missing text in docs/templates/how-to-guide.md: <!--`.
- M1 final validation:
  - `bash -n tests/markdown/how-to-guide-template-best-practices.test.sh && bash tests/markdown/how-to-guide-template-best-practices.test.sh` passed.
  - `test -f docs/templates/how-to-guide.md` passed.
  - `rg -n "Prerequisites|Time|Outcome|Verify|Scope|Safety" docs/templates/how-to-guide.md` passed.
  - `rg -n "^## Fast path$|^## Walkthrough$|^## Rollback$|^## Troubleshooting$" docs/templates/how-to-guide.md` passed.
  - `rg -n "Backup|Rollback|Scope|powershell|bash|not idempotent|secrets|troubleshooting" docs/templates/how-to-guide.md` passed.
  - `git diff --check` passed.
- M2 proof-first validation:
  - `bash -n tests/markdown/how-to-guide-template-best-practices.test.sh && bash tests/markdown/how-to-guide-template-best-practices.test.sh` failed before the portability-pilot rewrite with `missing text in docs/guides/03-ubuntu-baseline.md: **Prerequisites:**`.
  - After the portability-pilot rewrite, the same command failed with `missing required file: docs/changes/2026-06-15-how-to-guide-template-best-practices/exemplar-review.md`, proving the evidence-record checks were active.
- M2 final validation:
  - `bash -n tests/markdown/how-to-guide-template-best-practices.test.sh && bash tests/markdown/how-to-guide-template-best-practices.test.sh` passed.
  - `rg -n 'Backup: if `%UserProfile%\\.wslconfig` already exists|Backup behavior: if the file already exists' docs/guides/proxy-setup.md` passed.
  - `rg -n '^## Fast path$|^## Walkthrough$|Prerequisites|Outcome|Verify' docs/guides/proxy-setup.md docs/guides/03-ubuntu-baseline.md` passed.
  - `rg -n 'Run from|Expected result|Rollback|Troubleshooting|Backup' docs/guides/proxy-setup.md docs/guides/03-ubuntu-baseline.md` passed.
  - `test -f docs/changes/2026-06-15-how-to-guide-template-best-practices/exemplar-review.md` passed.
  - `test -f docs/changes/2026-06-15-how-to-guide-template-best-practices/portability-pilot-review.md` passed.
  - `git diff --check` passed.
- M3 final validation:
  - `bash -n tests/markdown/how-to-guide-template-best-practices.test.sh && bash tests/markdown/how-to-guide-template-best-practices.test.sh` passed.
  - `git diff --check` passed.
- M4 final validation:
  - `bash -n tests/markdown/how-to-guide-template-best-practices.test.sh && bash tests/markdown/how-to-guide-template-best-practices.test.sh` passed.
  - `rg -n 'status: accepted|^## Status$|^accepted$' docs/proposals/2026-06-15-how-to-guide-template-best-practices.md` passed.
  - `git diff --check` passed.
- Final verification validation:
  - `bash -n tests/markdown/how-to-guide-template-best-practices.test.sh && bash tests/markdown/how-to-guide-template-best-practices.test.sh` passed.
  - `rg -n 'status: accepted|^## Status$|^accepted$' docs/proposals/2026-06-15-how-to-guide-template-best-practices.md` passed.
  - `bash tests/markdown/m3-ubuntu-baseline.test.sh` failed before the semantic-cue restoration, then passed.
  - `bash -c 'set -euo pipefail; for test_script in tests/markdown/*.test.sh; do echo "== $test_script"; bash "$test_script"; done'` failed before verification-stage drift fixes, then passed.
  - `git diff --check` passed.

## Outcome and retrospective

- Pending. Fill after implementation milestones and downstream closeout gates complete.

## Readiness

- See `Current Handoff Summary`.
- Branch-ready for PR handoff. Readiness is not Done; PR handoff remains.
