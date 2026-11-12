# Plan: Two-Speed How-To Guide Structure

## Status

- Plan lifecycle state: completed
- Terminal disposition: terminal

## Purpose / big picture

This plan sequences the approved guide-structure spec into reviewable implementation slices. The change reshapes `docs/guides/` into reader-intent how-to documentation, adds a reusable contributor template, proves the pattern with a proxy setup pilot, and adds lightweight validation for shape and links.

The plan deliberately avoids command-contract changes and command-execution CI. The existing workstation setup spec remains authoritative for setup command semantics.

## Source artifacts

- Proposal: `docs/proposals/2026-06-07-guides-two-speed-how-to-structure.md`
- Proposal review: `docs/changes/2026-06-07-guides-two-speed-how-to-structure/reviews/proposal-review.md`
- Spec: `specs/guides-two-speed-how-to-structure.md`
- Spec review: `docs/changes/2026-06-07-guides-two-speed-how-to-structure/reviews/spec-review.md`
- Architecture: not required for this slice because the approved spec changes documentation structure and validation expectations only.
- Test spec: `specs/guides-two-speed-how-to-structure.test.md`

## Context and orientation

Current guide files are numbered setup pages:

- `docs/guides/01-windows-host.md`
- `docs/guides/02-wsl2-ubuntu.md`
- `docs/guides/03-ubuntu-baseline.md`
- `docs/guides/04-neovim.md`
- `docs/guides/05-tmux.md`
- `docs/guides/06-uv.md`
- `docs/guides/99-verification.md`

Current troubleshooting files are:

- `docs/troubleshooting/enterprise-policy.md`
- `docs/troubleshooting/proxy.md`
- `docs/troubleshooting/ubuntu-baseline.md`
- `docs/troubleshooting/wsl.md`

The first implementation should preserve discoverability for the existing numbered guide content while introducing the new task-scoped structure. `proxy-setup.md` is the pilot because it tests prerequisites, environmental variance, multi-step verification, and inline troubleshooting links. Existing setup command semantics remain governed by `specs/terminal-first-workstation-setup.md`.

## Non-goals

- Do not convert every first-slice setup guide in this plan.
- Do not redefine PowerShell, WSL, Neovim, tmux, proxy, sudoers, fstab, mount, or package-source command contracts.
- Do not add command-execution CI.
- Do not add a static-site generator, generated docs wizard, or custom docs platform.
- Do not replace troubleshooting docs with guide-local recovery trees.
- Do not create hidden setup automation or a one-command installer.

## Requirements covered

| Requirements | Planned coverage |
| --- | --- |
| R1-R5 | M1 creates the guide router and preserves troubleshooting as a separate reader mode. |
| R6-R8 | M1 records migration/discoverability for existing numbered guides and keeps task filenames unnumbered. |
| R9-R11 | M1 adds the reusable how-to template under `docs/templates/how-to-guide.md`. |
| R12-R28, R40 | M2 converts `proxy-setup.md` as the two-speed pilot with metadata, numbered steps, verification, safety notes, and inline troubleshooting links. |
| R29-R32 | M2 records proxy-pilot review evidence for fast-path completion from documented prerequisites. |
| R33-R36 | M3 adds lightweight structure/link validation and advisory command-review coverage without command-execution CI. |
| R37-R39 | M1-M3 preserve the documentation-first boundary and avoid generated docs or hidden automation. |
| R41-R42 | M1 establishes router targets for the first task-scoped guide set and optional future guides. |
| AC1-AC12 | M1-M3 collectively satisfy acceptance criteria after review and validation. |

## Current Handoff Summary

- Current milestone: M3
- Current milestone state: closed
- Last reviewed milestone: M3
- Review status: code-review M3 R1 clean-with-notes
- Remaining in-scope implementation milestones: none
- Next stage: done
- Final closeout readiness: ready
- Reason final closeout is or is not ready: PR https://github.com/xiongxianfei/terminal-first-windows-dev/pull/2 was merged at 2026-06-15T17:17:29Z with merge commit `0a49d6262c98efa36ab88c452ea9bcf48dd807c4`.

## Milestones

### M1. Router and template foundation

- Milestone state: closed
- Goal: Add the reader-intent guide router and contributor-facing how-to template while preserving discoverability for existing numbered guides.
- Requirements: R1-R11, R37-R39, R41-R42, AC2-AC3, AC10-AC11
- Files/components likely touched:
  - `docs/guides/README.md`
  - `docs/templates/how-to-guide.md`
  - `docs/guides/`
- Dependencies:
  - Approved plan-review.
  - Test spec defining router/template structure checks.
- Tests to add/update:
  - Static structure proof for `docs/guides/README.md`.
  - Static structure proof for `docs/templates/how-to-guide.md`.
  - Migration discoverability check for existing numbered guide content.
- Implementation steps:
  - Create `docs/templates/how-to-guide.md` with required metadata and two-speed sections.
  - Create or update `docs/guides/README.md` as an intent router.
  - Link existing numbered guides from the router while naming the planned task-scoped targets.
  - Record migration/discoverability notes for current numbered setup pages.
- Validation commands:
  - `test -f docs/templates/how-to-guide.md`
  - `test -f docs/guides/README.md`
  - `rg -n "Fast path|Walkthrough|Prerequisites|Outcome|Verify" docs/templates/how-to-guide.md`
  - `rg -n "01-windows-host|02-wsl2-ubuntu|03-ubuntu-baseline|04-neovim|05-tmux|99-verification" docs/guides/README.md`
- Expected observable result: Readers can choose setup tasks by intent, contributors can copy a reviewed template, and current numbered guides remain discoverable.
- Result:
  - Added `docs/templates/how-to-guide.md` with top metadata, `Fast path`, `Walkthrough`, rollback, troubleshooting, and review checklist sections.
  - Added `docs/guides/README.md` as a reader-intent router with the current numbered setup sequence, planned task-scoped guide targets, troubleshooting routing, and contributor-template link.
  - Preserved discoverability for the existing numbered guides during migration.
  - M1 validation passed with the listed file, heading, numbered-guide discoverability, template-location, and whitespace checks.
- Commit message: `M1: add guide router and how-to template`
- Milestone closeout:
  - validation passed
  - progress updated
  - decision log updated if needed
  - validation notes updated
  - milestone committed
- Risks:
  - Router becomes a flat table of contents.
  - Template becomes too verbose and encourages tutorial prose.
- Rollback/recovery:
  - Revert `docs/guides/README.md` and `docs/templates/how-to-guide.md` to the previous guide index state if the router/template proves unusable during review.

### M2. Proxy setup pilot

- Milestone state: closed
- Goal: Convert proxy setup into the first task-scoped two-speed guide and capture pilot benefit evidence.
- Requirements: R12-R32, R40, AC4-AC7, AC12
- Files/components likely touched:
  - `docs/guides/proxy-setup.md`
  - `docs/troubleshooting/proxy.md`
  - `docs/changes/2026-06-07-guides-two-speed-how-to-structure/pilot-review.md`
- Dependencies:
  - M1 closed.
  - Existing proxy troubleshooting content reviewed for stable anchors.
  - Test spec defining pilot structure and link checks.
- Tests to add/update:
  - Static proxy-guide structure proof.
  - Relative link and anchor proof for proxy troubleshooting links.
  - Manual pilot walkthrough evidence record.
- Implementation steps:
  - Author `docs/guides/proxy-setup.md` using `docs/templates/how-to-guide.md`.
  - Keep setup command semantics aligned with `specs/terminal-first-workstation-setup.md`.
  - Add or stabilize only the proxy troubleshooting anchors needed by the pilot.
  - Record the proxy pilot fast-path self-walkthrough in `pilot-review.md`.
- Validation commands:
  - `test -f docs/guides/proxy-setup.md`
  - `rg -n "^## Fast path$|^## Walkthrough$|Prerequisites|Outcome|Verify" docs/guides/proxy-setup.md`
  - `rg -n "../troubleshooting/proxy.md#" docs/guides/proxy-setup.md`
  - `test -f docs/changes/2026-06-07-guides-two-speed-how-to-structure/pilot-review.md`
- Expected observable result: Proxy setup is available as a task-scoped two-speed guide with inline recovery links and recorded fast-path benefit evidence.
- Result:
  - Added `docs/guides/proxy-setup.md` as the two-speed proxy pilot guide.
  - Updated `docs/guides/README.md` so proxy readers route to the task-scoped pilot while the numbered Ubuntu baseline proxy section remains discoverable as compatibility context.
  - Added `docs/changes/2026-06-07-guides-two-speed-how-to-structure/pilot-review.md` with manual fast-path benefit evidence, documented starting state, approximate completion time, and command-execution limits.
  - M2 validation passed with file, structure, troubleshooting-link, anchor, pilot-evidence, whitespace, and ASCII checks.
- Commit message: `M2: convert proxy setup pilot guide`
- Milestone closeout:
  - validation passed
  - progress updated
  - decision log updated if needed
  - validation notes updated
  - milestone committed
- Risks:
  - Proxy guide expands into full corporate-proxy troubleshooting.
  - Troubleshooting anchors are unstable or missing.
  - Fast path omits a needed safety warning.
- Rollback/recovery:
  - Remove or demote `proxy-setup.md` and keep proxy guidance available through the existing numbered Ubuntu baseline and troubleshooting docs while revising the template.

### M3. Lightweight guide validation

- Milestone state: closed
- Goal: Add lightweight validation for guide shape and links without executing setup command blocks.
- Requirements: R33-R36, AC8-AC10
- Files/components likely touched:
  - `tests/markdown/`
  - `tests/markdown/guides-two-speed-how-to-structure.test.sh`
  - `docs/plans/2026-06-07-guides-two-speed-how-to-structure.md`
  - `docs/changes/2026-06-07-guides-two-speed-how-to-structure/review-log.md`
  - `docs/changes/2026-06-07-guides-two-speed-how-to-structure/review-resolution.md`
- Dependencies:
  - M1 and M2 closed.
  - Test spec exists and names the checks.
  - `specs/guides-two-speed-how-to-structure.test.md` is upstream source evidence for implementation and validation.
  - Implementation does not modify `specs/guides-two-speed-how-to-structure.test.md`; changes to that file belong to the test-spec stage or a later test-spec revision.
- Tests to add/update:
  - Static guide structure check for router, template, and proxy pilot.
  - Link/anchor check for guide-to-troubleshooting references.
  - Negative check that this slice does not require command-execution CI.
- Implementation steps:
  - Add or update a focused Markdown/static proof script for the guide-structure slice.
  - Ensure the proof checks required sections and links without running setup commands.
  - Document advisory command review expectations in validation notes or checklist form.
- Validation commands:
  - `bash tests/markdown/guides-two-speed-how-to-structure.test.sh`
  - `git diff --cached --name-only`
  - `git diff --cached --check`
- Expected observable result: The new guide structure can be checked locally for shape and links, while command execution remains advisory.
- Result:
  - Added `tests/markdown/guides-two-speed-how-to-structure.test.sh` as the implementation-owned static proof script.
  - The proof script checks router, template, proxy pilot, troubleshooting anchors, migration discoverability, pilot evidence, advisory command-review language, and the no-command-execution boundary.
  - The proof script inspects repository Markdown only and does not execute setup commands from the guides.
  - M3 validation passed with the proof script, staged-surface, whitespace, and ASCII checks.
- Commit message: `M3: add guide structure validation`
- Milestone closeout:
  - validation passed
  - progress updated
  - decision log updated if needed
  - validation notes updated
  - milestone committed
- Risks:
  - Validation becomes too rigid before the guide pattern stabilizes.
  - Link checking misses anchors if implemented as text-only grep.
- Rollback/recovery:
  - Keep the manual review checklist and remove overly brittle static checks until a better link/anchor validation approach is available.

## Validation plan

- `test -f docs/templates/how-to-guide.md`: proves the reusable template exists.
- `test -f docs/guides/README.md`: proves the router exists.
- `test -f docs/guides/proxy-setup.md`: proves the pilot guide exists.
- `rg -n "^## Fast path$|^## Walkthrough$" docs/guides/proxy-setup.md docs/templates/how-to-guide.md`: checks required two-speed headings.
- `rg -n "../troubleshooting/proxy.md#" docs/guides/proxy-setup.md`: checks proxy guide has inline troubleshooting anchor links.
- `bash tests/markdown/guides-two-speed-how-to-structure.test.sh`: planned static proof after test-spec and implementation.
- `git diff --cached --name-only`: confirms the staged milestone surface before whitespace validation.
- `git diff --cached --check`: staged whitespace check for implementation-owned files.

### Test-spec ownership policy

The test spec is an upstream validation contract for this implementation plan. It is authored after plan-review and before implementation. Implementation milestones may depend on `specs/guides-two-speed-how-to-structure.test.md`, but they do not own or modify it.

Implementation-owned validation scripts belong under `tests/`, such as `tests/markdown/guides-two-speed-how-to-structure.test.sh`. Whitespace validation for implementation milestones is scoped to staged files or explicitly listed implementation-owned files and change-local plan/review evidence.

## Risks and recovery

- Risk: The router becomes another table of contents.
  - Recovery: Rework router groupings around reader intent statements and keep filenames secondary.
- Risk: The proxy pilot stalls while trying to perfect all proxy troubleshooting.
  - Recovery: Stabilize only anchors needed by the pilot and leave broader proxy taxonomy for a later change.
- Risk: Fast path and walkthrough commands drift.
  - Recovery: Review M2 for step parity and use M3 checks where practical.
- Risk: Existing numbered guide links break.
  - Recovery: Keep router links or compatibility notes until replacements are complete.
- Risk: Static checks overfit the pilot.
  - Recovery: Reduce checks to required stable shape and leave content-quality judgment to review.

## Dependencies

- Plan-review approval before implementation.
- Test spec after plan-review and before implementation.
- Existing workstation setup spec remains authoritative for setup command semantics.
- Proxy troubleshooting anchors must exist or be added in the same slice for inline pilot links.

## Progress

- 2026-06-07: Plan created after approved proposal and approved spec.
- 2026-06-07: Plan-review R2 approved the plan; test spec authored at `specs/guides-two-speed-how-to-structure.test.md`.
- 2026-06-07: M1 implementation started after baseline file-existence checks failed for the missing router and template as expected.
- 2026-06-07: M1 added the guide router and how-to template, then passed targeted validation.
- 2026-06-07: M1 explanation recorded in `docs/changes/2026-06-07-guides-two-speed-how-to-structure/explain-change.md` for code-review handoff.
- 2026-06-07: M1 code-review R1 recorded clean-with-notes and closed M1. Next stage is M2 implementation.
- 2026-06-15: M2 implementation started after baseline file-existence and structure checks failed for the missing proxy pilot guide and pilot review evidence as expected.
- 2026-06-15: M2 added the proxy pilot guide, router update, and pilot review evidence, then passed targeted validation.
- 2026-06-15: M2 code-review R1 recorded clean-with-notes and closed M2. Next stage is M3 implementation.
- 2026-06-15: M3 implementation started after the planned proof script was missing as expected.
- 2026-06-15: M3 added the static guide-structure proof script and passed targeted validation.
- 2026-06-15: M3 code-review R1 recorded clean-with-notes and closed M3. No in-scope implementation milestones remain.
- 2026-06-15: Final explain-change updated to summarize M1-M3 rationale, review outcomes, validation evidence, alternatives, scope control, and risks.
- 2026-06-15: Final verification passed locally and was recorded in `docs/changes/2026-06-07-guides-two-speed-how-to-structure/verify-report.md`.
- 2026-06-15: PR handoff prepared at `docs/changes/2026-06-07-guides-two-speed-how-to-structure/pr.md`.
- 2026-06-15: Created local branch `feature/guides-two-speed-how-to-structure`; pushing/opening PR was blocked because GitHub credentials were unavailable.
- 2026-06-16: GitHub CLI authentication became available; branch push and PR creation retried.
- 2026-06-16: Opened PR https://github.com/xiongxianfei/terminal-first-windows-dev/pull/2.
- 2026-06-16: Confirmed PR #2 merged at 2026-06-15T17:17:29Z with merge commit `0a49d6262c98efa36ab88c452ea9bcf48dd807c4`; marked change terminal.

## Decision log

| Date | Decision | Reason | Alternatives rejected |
| --- | --- | --- | --- |
| 2026-06-07 | Use three implementation milestones | Separates router/template foundation, proxy pilot, and validation so each can be reviewed independently | One broad documentation rewrite |
| 2026-06-07 | Keep existing numbered guides discoverable during M1 | Avoids breaking current reader paths while task-scoped migration starts | Immediate removal or mass rename |
| 2026-06-07 | Add validation after the proxy pilot | Checks should be based on the proven template shape and pilot behavior | Build validation before authoring the pilot |
| 2026-06-07 | Keep test-spec upstream of implementation | Preserves workflow sequencing: plan-review -> test-spec -> implementation, and prevents implementation milestones from appearing to mutate their own validation contract | Listing `specs/guides-two-speed-how-to-structure.test.md` as an M3 implementation-touched file |

## Surprises and discoveries

- Existing guide files are numbered setup guides; the migration needs discoverability preservation even though task-scoped guide filenames should be unnumbered.

## Validation notes

- Plan authoring checks performed: source artifacts read, spec-review evidence checked, current guide/troubleshooting files listed.
- PR-001 plan fix applied: M3 now owns `tests/markdown/guides-two-speed-how-to-structure.test.sh` and keeps `specs/guides-two-speed-how-to-structure.test.md` as upstream source evidence only.
- Test spec authored and ready for implementation use.
- M1 baseline proof before edits:
  - `test -f docs/templates/how-to-guide.md` failed because the template did not exist.
  - `test -f docs/guides/README.md` failed because the router did not exist.
  - `rg -n "Fast path|Walkthrough|Prerequisites|Outcome|Verify" docs/templates/how-to-guide.md` failed because the template did not exist.
  - `rg -n "01-windows-host|02-wsl2-ubuntu|03-ubuntu-baseline|04-neovim|05-tmux|99-verification" docs/guides/README.md` failed because the router did not exist.
- M1 validation after implementation:
  - `test -f docs/templates/how-to-guide.md` passed.
  - `test -f docs/guides/README.md` passed.
  - `rg -n "Fast path|Walkthrough|Prerequisites|Outcome|Verify" docs/templates/how-to-guide.md` passed.
  - `rg -n "01-windows-host|02-wsl2-ubuntu|03-ubuntu-baseline|04-neovim|05-tmux|99-verification" docs/guides/README.md` passed.
  - `test ! -f docs/guides/_template.md && test ! -f docs/guides/how-to-guide.md` passed.
  - `git diff --check -- docs/guides/README.md docs/templates/how-to-guide.md docs/plans/2026-06-07-guides-two-speed-how-to-structure.md docs/changes/2026-06-07-guides-two-speed-how-to-structure/change.yaml` passed.
- M1 final handoff validation:
  - Re-ran the M1 file, heading, numbered-guide discoverability, and template-location checks; all passed.
  - `git diff --check -- docs/guides/README.md docs/templates/how-to-guide.md docs/plans/2026-06-07-guides-two-speed-how-to-structure.md docs/changes/2026-06-07-guides-two-speed-how-to-structure/change.yaml docs/changes/2026-06-07-guides-two-speed-how-to-structure/explain-change.md docs/plan.md` passed.
  - `LC_ALL=C rg -n "[^\\x00-\\x7F]" docs/guides/README.md docs/templates/how-to-guide.md docs/plans/2026-06-07-guides-two-speed-how-to-structure.md docs/changes/2026-06-07-guides-two-speed-how-to-structure/change.yaml docs/changes/2026-06-07-guides-two-speed-how-to-structure/explain-change.md docs/plan.md` returned no matches.
- M1 code-review validation:
  - `test -f docs/templates/how-to-guide.md` passed.
  - `test -f docs/guides/README.md` passed.
  - `rg -n "Fast path|Walkthrough|Prerequisites|Outcome|Verify" docs/templates/how-to-guide.md` passed.
  - `rg -n "01-windows-host|02-wsl2-ubuntu|03-ubuntu-baseline|04-neovim|05-tmux|99-verification" docs/guides/README.md` passed.
  - `git diff HEAD^..HEAD --check` passed.
  - `git status --short` returned no output before review artifacts were recorded.
- M2 baseline proof before edits:
  - `test -f docs/guides/proxy-setup.md` failed because the proxy pilot guide did not exist.
  - `rg -n "^## Fast path$|^## Walkthrough$|Prerequisites|Outcome|Verify" docs/guides/proxy-setup.md` failed because the proxy pilot guide did not exist.
  - `rg -n "../troubleshooting/proxy.md#" docs/guides/proxy-setup.md` failed because the proxy pilot guide did not exist.
  - `test -f docs/changes/2026-06-07-guides-two-speed-how-to-structure/pilot-review.md` failed because the pilot review evidence did not exist.
- M2 validation after implementation:
  - `test -f docs/guides/proxy-setup.md` passed.
  - `rg -n "^## Fast path$|^## Walkthrough$|Prerequisites|Outcome|Verify" docs/guides/proxy-setup.md` passed.
  - `rg -n "../troubleshooting/proxy.md#" docs/guides/proxy-setup.md` passed.
  - `test -f docs/changes/2026-06-07-guides-two-speed-how-to-structure/pilot-review.md` passed.
  - `rg -n "^## Automatic proxy mirroring does not work$|^## Manual proxy fallback cautions$|^## WSL SSL certificate trust fails$" docs/troubleshooting/proxy.md` passed.
  - `rg -n "Command execution status: not executed|Completion result: completable|Approximate completion time|documented starting state" docs/changes/2026-06-07-guides-two-speed-how-to-structure/pilot-review.md` passed.
- M2 final handoff validation:
  - Re-ran the M2 file, metadata/section, troubleshooting-link, pilot-evidence, and numbered-step checks; all passed.
  - `rg -n "^## Documented starting state$|Completion result|Approximate completion time|Command execution status" docs/changes/2026-06-07-guides-two-speed-how-to-structure/pilot-review.md` passed.
  - `rg -n "^1\\. |^2\\. |^3\\. |^### 1\\. |^### 2\\. |^### 3\\. " docs/guides/proxy-setup.md` passed.
  - `git diff --check -- docs/guides/proxy-setup.md docs/guides/README.md docs/changes/2026-06-07-guides-two-speed-how-to-structure/pilot-review.md docs/changes/2026-06-07-guides-two-speed-how-to-structure/explain-change.md docs/plans/2026-06-07-guides-two-speed-how-to-structure.md docs/changes/2026-06-07-guides-two-speed-how-to-structure/change.yaml docs/plan.md` passed.
  - `LC_ALL=C rg -n "[^\\x00-\\x7F]" docs/guides/proxy-setup.md docs/guides/README.md docs/changes/2026-06-07-guides-two-speed-how-to-structure/pilot-review.md docs/changes/2026-06-07-guides-two-speed-how-to-structure/explain-change.md docs/plans/2026-06-07-guides-two-speed-how-to-structure.md docs/changes/2026-06-07-guides-two-speed-how-to-structure/change.yaml docs/plan.md` returned no matches.
- M2 code-review validation:
  - `test -f docs/guides/proxy-setup.md` passed.
  - `rg -n "^## Fast path$|^## Walkthrough$|Prerequisites|Outcome|Verify" docs/guides/proxy-setup.md` passed.
  - `rg -n "../troubleshooting/proxy.md#" docs/guides/proxy-setup.md` passed.
  - `test -f docs/changes/2026-06-07-guides-two-speed-how-to-structure/pilot-review.md` passed.
  - `rg -n "^## Automatic proxy mirroring does not work$|^## Manual proxy fallback cautions$|^## WSL SSL certificate trust fails$" docs/troubleshooting/proxy.md` passed.
  - `git diff HEAD^..HEAD --check` passed.
- M3 baseline proof before edits:
  - `test -f tests/markdown/guides-two-speed-how-to-structure.test.sh` failed because the proof script did not exist.
  - `bash tests/markdown/guides-two-speed-how-to-structure.test.sh` failed because the proof script did not exist.
- M3 validation after implementation:
  - `bash tests/markdown/guides-two-speed-how-to-structure.test.sh` passed.
  - The proof script initially exposed literal-backtick quoting defects in its own checks; the checks were corrected to treat Markdown code spans as literal text.
- M3 final handoff validation:
  - `bash tests/markdown/guides-two-speed-how-to-structure.test.sh` passed.
  - `git diff --check -- tests/markdown/guides-two-speed-how-to-structure.test.sh docs/plans/2026-06-07-guides-two-speed-how-to-structure.md docs/changes/2026-06-07-guides-two-speed-how-to-structure/change.yaml docs/changes/2026-06-07-guides-two-speed-how-to-structure/explain-change.md docs/plan.md` passed.
  - `LC_ALL=C rg -n "[^\\x00-\\x7F]" tests/markdown/guides-two-speed-how-to-structure.test.sh docs/plans/2026-06-07-guides-two-speed-how-to-structure.md docs/changes/2026-06-07-guides-two-speed-how-to-structure/change.yaml docs/changes/2026-06-07-guides-two-speed-how-to-structure/explain-change.md docs/plan.md` returned no matches.
  - `git diff --cached --name-only` showed only the M3 proof script and lifecycle metadata files.
  - `git diff --cached --check` passed.
- M3 code-review validation:
  - `bash tests/markdown/guides-two-speed-how-to-structure.test.sh` passed.
  - `git diff HEAD^..HEAD --check` passed.
  - `git show --check --format=short HEAD` passed.
  - `rg -n "apt update|sudo apt|winget |wsl --install|update-ca-certificates" tests/markdown/guides-two-speed-how-to-structure.test.sh` returned no matches.
- Final verification validation:
  - `bash tests/markdown/guides-two-speed-how-to-structure.test.sh` passed.
  - `bash tests/markdown/m1-project-entrypoint.test.sh` initially failed because it still applied numbered setup-guide section requirements to `docs/guides/README.md`.
  - `tests/markdown/m1-project-entrypoint.test.sh` was updated to scope legacy setup-guide section checks to `docs/guides/[0-9][0-9]-*.md`.
  - `bash tests/markdown/m1-project-entrypoint.test.sh` passed after the fix.
  - `bash -c 'set -euo pipefail; for test_script in tests/markdown/*.test.sh; do echo "== $test_script"; bash "$test_script"; done'` passed.
  - Hosted CI was not available or observed.

## Outcome and retrospective

- Completed. The guide router, contributor template, proxy pilot, pilot evidence, and lightweight guide-structure validation were merged through PR #2.
- Final local verification passed before PR handoff. Hosted CI was not available or observed.
- The only verification-stage drift found was the legacy guide glob in `tests/markdown/m1-project-entrypoint.test.sh`, which was corrected to apply setup-guide section checks only to numbered setup guides.

## Readiness

- See `Current Handoff Summary`.
- Done.
- Remaining completion gates: none.
