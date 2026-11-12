# Remaining Guides Template Rollout Plan

## Status

- Plan lifecycle state: active
- Terminal disposition: not-terminal

## Purpose / big picture

Apply the approved how-to guide template to the remaining first-slice guides in small, reviewable slices while preserving setup command semantics. The rollout prioritizes low-risk tool guides first, keeps numbered paths stable during body conformance, handles the WSL install/migration split as a safety exception, and leaves broad filename migration for a later compatibility slice.

The work is documentation-only. It must improve structure, safety cues, verification, rollback, and router behavior without adding command-execution CI, generated tooling, setup scripts, or new workstation behavior.

## Source artifacts

- Proposal: `docs/proposals/2026-06-16-remaining-guides-template-rollout.md`
- Proposal review: `docs/changes/2026-06-16-remaining-guides-template-rollout/reviews/proposal-review.md`
- Spec: `specs/remaining-guides-template-rollout.md`
- Spec review: `docs/changes/2026-06-16-remaining-guides-template-rollout/reviews/spec-review.md`
- Spec review resolution: `docs/changes/2026-06-16-remaining-guides-template-rollout/reviews/spec-review-resolution.md`
- Upstream template spec: `specs/how-to-guide-template-best-practices.md`
- Upstream setup contract: `specs/terminal-first-workstation-setup.md`
- Workflow guide: `docs/workflows.md`
- Constitution: `CONSTITUTION.md`

## Context and orientation

The repository is documentation-first. Existing guide commands are the product surface, so body-conformance edits must not silently change command behavior.

The accepted template exemplar is `docs/guides/proxy-setup.md`; the accepted portability pilot is `docs/guides/03-ubuntu-baseline.md`. This rollout must not modify either file except for narrow router or link maintenance.

The remaining rollout targets are:

- `docs/guides/05-tmux.md`
- `docs/guides/04-neovim.md`
- `docs/guides/06-uv.md`
- `docs/guides/01-windows-host.md`
- `docs/guides/02-wsl2-ubuntu.md`
- `docs/guides/wsl-ubuntu-install.md`
- `docs/guides/wsl-ubuntu-migration.md`
- `docs/guides/99-verification.md`
- `docs/guides/README.md`

Architecture is not required for this change because the work affects documentation structure, review evidence, and static checks only. No runtime architecture, persisted application state, API, deployment flow, or executable setup behavior changes.

## Non-goals

- Changing approved setup command semantics.
- Executing guide command blocks in CI.
- Creating generated documentation, custom tooling, scaffolding, installers, or one-command setup automation.
- Completing broad unnumbered filename migration.
- Removing numbered paths without compatibility stubs.
- Moving `06-uv.md` out of `docs/guides/`.
- Replacing `proxy-setup.md` or `03-ubuntu-baseline.md` as the accepted exemplar and pilot.
- Adding tutorial-style beginner material to `docs/guides/`.

## Requirements covered

| Requirements | Plan coverage |
| --- | --- |
| R1-R26 | Every conversion milestone preserves command semantics and applies visible metadata, fast path, walkthrough, command context, expected results, backup, rollback, troubleshooting, and secret-avoidance rules. |
| R27-R39 | M1 converts the first smaller-guide slice for tmux, Neovim, and uv while preserving numbered paths and optional uv status. |
| R40-R43 | M2 converts Windows host as one guide and preserves policy/elevation guidance. |
| R44-R57 | M3 performs the WSL install/migration split and replaces `02-wsl2-ubuntu.md` with a command-free compatibility stub. |
| R58-R60, R75 | M4 converts `99-verification.md` only after active referenced paths exist or unresolved targets are inventoried. |
| R61-R66 | M1-M4 update the router as needed while deferring broad filename migration. |
| R67-R74 | M1-M5 add scoped static checks, review evidence, validation notes, and completion evidence without executing setup commands. |
| AC1-AC21 | M1-M5 collectively produce the converted guide bodies, router updates, compatibility behavior, scoped checks, review evidence, and verification target inventory required by acceptance. |

## Current Handoff Summary

- Current milestone: complete
- Current milestone state: done
- Last reviewed milestone: M5
- Review status: clean-with-notes
- Remaining in-scope implementation milestones: none
- Next stage: none
- Final closeout readiness: complete
- Reason final closeout is or is not ready: PR #4 merged on 2026-06-16 at merge commit `d7ee9ac45cad6a8d0284486a2c90edf58e0af4c3`.

## Milestones

### M1. Smaller tool guides and scoped checks

- Milestone state: closed
- Goal: Convert `05-tmux.md`, `04-neovim.md`, and `06-uv.md` to the accepted guide shape while preserving their numbered paths and command semantics.
- Requirements: R1-R39, R61-R62, R67-R74, AC1-AC4, AC12-AC18
- Files/components likely touched:
  - `docs/guides/05-tmux.md`
  - `docs/guides/04-neovim.md`
  - `docs/guides/06-uv.md`
  - `docs/guides/README.md`
  - `tests/markdown/remaining-guides-template-rollout.test.sh`
  - `docs/changes/2026-06-16-remaining-guides-template-rollout/reviews/code-review-m1-r1.md`
- Dependencies:
  - Approved plan review.
  - Approved test spec mapping converted-guide structure, backup-before-edit, command context, expected results, uv optionality, and credential-free examples.
- Tests to add/update:
  - Add scoped static checks that only enforce template structure on converted guides.
  - Add checks for uv optional labeling and credential-free package-index examples.
  - Add link and anchor checks for troubleshooting targets referenced by the converted guides.
- Implementation steps:
  - Inventory current command blocks in the three guides before editing.
  - Convert each guide to visible metadata, `Fast path`, `Walkthrough`, rollback, and troubleshooting-router shape.
  - Preserve `05-tmux.md`, `04-neovim.md`, and `06-uv.md` filenames.
  - Add backup guidance before edits to `~/.tmux.conf`, `%LocalAppData%\nvim`, and `~/.config/nvim`.
  - Keep Neovim Windows and Ubuntu runtime/plugin state separate.
  - Label uv as optional and keep package-index examples credential-free.
  - Update the router only as needed for the converted guide entries.
  - Record review evidence for parity, backup coverage, command context, expected results, and troubleshooting anchors.
- Validation commands:
  - `bash tests/markdown/remaining-guides-template-rollout.test.sh`
  - `bash tests/markdown/how-to-guide-template-best-practices.test.sh`
  - `bash tests/markdown/guides-two-speed-how-to-structure.test.sh`
  - `git diff --cached --check`
- Expected observable result: The first smaller-guide slice is template-conformant, uv remains optional, static checks are scoped to converted guides, and no setup commands are executed by validation.
- Commit message: `M1: convert smaller tool guides`
- Milestone closeout:
  - validation passed
  - progress updated
  - review evidence recorded
  - validation notes updated
  - milestone committed
  - ready for code-review
- Risks:
  - Existing command examples drift while prose is reorganized.
  - Fast paths become too long because three different tool guides are converted together.
  - Static checks accidentally fail unconverted guides.
- Rollback/recovery:
  - Revert only the M1 guide, router, and test changes if review finds command drift or over-broad validation.

### M2. Windows host guide conversion

- Milestone state: closed
- Goal: Convert `01-windows-host.md` as one unified host-baseline guide.
- Requirements: R1-R26, R40-R43, R61, R67-R74, AC1, AC5, AC12-AC19
- Files/components likely touched:
  - `docs/guides/01-windows-host.md`
  - `docs/guides/README.md`
  - `tests/markdown/remaining-guides-template-rollout.test.sh`
  - `docs/changes/2026-06-16-remaining-guides-template-rollout/reviews/code-review-m2-r1.md`
- Dependencies:
  - M1 closed and reviewed.
  - Test spec covers Windows host policy/elevation review evidence.
- Tests to add/update:
  - Extend scoped static checks to include `01-windows-host.md`.
  - Add static or review-evidence checks that administrator elevation, policy dependency, and command context are visible.
- Implementation steps:
  - Inventory existing Windows Terminal, PowerShell, WinGet, WSL availability, and profile guidance.
  - Convert the guide body without splitting it into separate Windows Terminal or PowerShell files.
  - Keep policy-aware and elevation-sensitive notes near the relevant commands.
  - Add expected results and verification commands in both fast path and walkthrough where applicable.
  - Update the router entry without introducing final filename migration.
  - Record review evidence for command context, expected results, backup or not-applicable reasoning, and policy/elevation coverage.
- Validation commands:
  - `bash tests/markdown/remaining-guides-template-rollout.test.sh`
  - `bash tests/markdown/how-to-guide-template-best-practices.test.sh`
  - `bash tests/markdown/guides-two-speed-how-to-structure.test.sh`
  - `git diff --cached --check`
- Expected observable result: `01-windows-host.md` is a unified converted guide with explicit Windows command context, policy/elevation notes, expected results, and router coverage.
- Commit message: `M2: convert Windows host guide`
- Milestone closeout:
  - validation passed
  - progress updated
  - review evidence recorded
  - validation notes updated
  - milestone committed
  - ready for code-review
- Risks:
  - Combining host setup topics may make the fast path too dense.
  - Elevation or enterprise-policy caveats may move too far from the commands they qualify.
- Rollback/recovery:
  - Revert only M2 files and restore the prior host-guide body if review finds scope creep or command-semantics drift.

### M3. WSL install and migration split

- Milestone state: closed
- Goal: Split `02-wsl2-ubuntu.md` into fresh-install and migration guides, then replace the numbered path with a command-free compatibility stub.
- Requirements: R1-R26, R44-R57, R61, R63, R67-R74, AC1, AC6-AC9, AC12-AC19
- Files/components likely touched:
  - `docs/guides/wsl-ubuntu-install.md`
  - `docs/guides/wsl-ubuntu-migration.md`
  - `docs/guides/02-wsl2-ubuntu.md`
  - `docs/guides/README.md`
  - `tests/markdown/remaining-guides-template-rollout.test.sh`
  - `docs/changes/2026-06-16-remaining-guides-template-rollout/reviews/code-review-m3-r1.md`
- Dependencies:
  - M2 closed and reviewed.
  - Test spec covers compatibility-stub command prohibition and WSL high-risk review evidence.
- Tests to add/update:
  - Add static checks for the presence of `wsl-ubuntu-install.md` and `wsl-ubuntu-migration.md`.
  - Add checks that `02-wsl2-ubuntu.md` routes to both task guides and does not duplicate WSL install, migration, unregister, or import commands.
  - Add link checks for router and cross-guide starting-state links.
- Implementation steps:
  - Inventory current WSL fresh-install, custom-location, migration/export, unregister, import, import-in-place, and recovery commands.
  - Move fresh-install guidance into `wsl-ubuntu-install.md` with explicit command context, expected results, and verification.
  - Move migration guidance into `wsl-ubuntu-migration.md` with export/backup guidance before destructive commands.
  - Label `wsl --unregister` as destructive before the command appears.
  - Replace `02-wsl2-ubuntu.md` with a short compatibility stub that routes by starting state and duplicates no setup commands.
  - Update the router to point WSL readers to install or migration paths after the split.
  - Record high-risk manual or dry-run command review evidence without executing workstation setup commands.
- Validation commands:
  - `bash tests/markdown/remaining-guides-template-rollout.test.sh`
  - `bash tests/markdown/how-to-guide-template-best-practices.test.sh`
  - `bash tests/markdown/guides-two-speed-how-to-structure.test.sh`
  - `git diff --cached --check`
- Expected observable result: Fresh install and migration have separate task-scoped guides, `02-wsl2-ubuntu.md` is a command-free stub, and destructive migration operations have visible backup/export and safety coverage before commands.
- Commit message: `M3: split WSL install and migration guides`
- Milestone closeout:
  - validation passed
  - progress updated
  - high-risk review evidence recorded
  - validation notes updated
  - milestone committed
  - ready for code-review
- Risks:
  - The split can accidentally lose recovery guidance or change command ordering.
  - The compatibility stub can grow into a duplicate guide.
  - Links into the old numbered guide may need clearer routing text.
- Rollback/recovery:
  - Revert the M3 guide split, restore `02-wsl2-ubuntu.md`, and keep M1-M2 intact if the WSL split fails review.

### M4. Verification guide and router proof surface

- Milestone state: closed
- Goal: Convert `99-verification.md` only when active referenced guide paths exist or unresolved verification targets are explicitly inventoried.
- Requirements: R1-R26, R58-R63, R67-R75, AC1, AC12-AC21
- Files/components likely touched:
  - `docs/guides/99-verification.md`
  - `docs/guides/README.md`
  - `docs/changes/2026-06-16-remaining-guides-template-rollout/verification-target-inventory.md`
  - `tests/markdown/remaining-guides-template-rollout.test.sh`
  - `docs/changes/2026-06-16-remaining-guides-template-rollout/reviews/code-review-m4-r1.md`
- Dependencies:
  - M3 closed and reviewed.
  - All active setup-guide paths referenced by `99-verification.md` either exist after the slice or are recorded as unresolved verification follow-ups.
  - Test spec covers R58 sequencing checks and the verification target inventory.
- Tests to add/update:
  - Add static checks that active verification links resolve.
  - Add checks or review evidence that `99-verification.md` was not converted in M1.
  - Add checks that unresolved verification targets are not active verification links.
- Implementation steps:
  - Build a verification target inventory listing each active setup-guide path referenced by `99-verification.md`.
  - Convert `99-verification.md` to fast path and walkthrough shape.
  - Preserve the result vocabulary `pass`, `fail`, `skipped`, and `needs manual action`.
  - Keep missing or not-yet-converted targets as unresolved follow-ups rather than active verification links.
  - Update the router proof surface after active links resolve.
  - Record verification sequencing evidence and static link-check results.
- Validation commands:
  - `bash tests/markdown/remaining-guides-template-rollout.test.sh`
  - `bash tests/markdown/how-to-guide-template-best-practices.test.sh`
  - `bash tests/markdown/guides-two-speed-how-to-structure.test.sh`
  - `git diff --cached --check`
- Expected observable result: `99-verification.md` is converted after referenced paths are stable, active verification references resolve, and unresolved targets are separately inventoried.
- Commit message: `M4: convert verification guide`
- Milestone closeout:
  - validation passed
  - progress updated
  - verification target inventory recorded
  - review evidence recorded
  - validation notes updated
  - milestone committed
  - ready for code-review
- Risks:
  - Verification references can point to not-yet-converted paths.
  - The verification guide can become a broad implementation checklist instead of a proof surface.
- Rollback/recovery:
  - Revert M4 files and leave `99-verification.md` in its prior structure until referenced paths and inventory are ready.

### M5. Lifecycle closeout and completion evidence

- Milestone state: closed
- Goal: Consolidate completion evidence, plan state, and change metadata after guide conversion milestones are reviewed.
- Requirements: R70-R75, AC16-AC21
- Files/components likely touched:
  - `docs/plans/2026-06-16-remaining-guides-template-rollout.md`
  - `docs/changes/2026-06-16-remaining-guides-template-rollout/change.yaml`
  - `docs/changes/2026-06-16-remaining-guides-template-rollout/explain-change.md`
  - `docs/plan.md`
- Dependencies:
  - M1-M4 closed after code review.
  - Durable explanation has been written before final verify.
- Tests to add/update:
  - No new functional checks expected. Re-run the full documentation validation set.
- Implementation steps:
  - Update the plan progress, validation notes, decision log, and current handoff.
  - Update `change.yaml` with the current stage and next gate.
  - Record completion evidence listing converted guides, compatibility paths, checks run, and checks intentionally not run.
  - Prepare durable explanation and final verification inputs.
- Validation commands:
  - `bash tests/markdown/remaining-guides-template-rollout.test.sh`
  - `bash tests/markdown/how-to-guide-template-best-practices.test.sh`
  - `bash tests/markdown/guides-two-speed-how-to-structure.test.sh`
  - `bash tests/markdown/m1-project-entrypoint.test.sh`
  - `bash tests/markdown/m2-windows-wsl-storage.test.sh`
  - `bash tests/markdown/m3-ubuntu-baseline.test.sh`
  - `bash tests/markdown/m4-neovim-tmux.test.sh`
  - `bash tests/markdown/m5-release-readiness.test.sh`
  - `git diff --cached --check`
- Expected observable result: The branch has coherent lifecycle evidence for explain-change, final verify, and PR handoff.
- Commit message: `M5: record rollout completion evidence`
- Milestone closeout:
  - validation passed
  - progress updated
  - completion evidence recorded
  - validation notes updated
  - milestone committed
  - ready for code-review
- Risks:
  - Lifecycle metadata can claim readiness before review or validation has actually run.
- Rollback/recovery:
  - Correct lifecycle metadata and keep the plan non-terminal if any review or verification gate remains open.

## Validation plan

The test spec owns exact test IDs and final command names. This plan expects validation to remain static and review-based:

- Structure checks for converted guides only.
- Link and anchor checks for troubleshooting references and active verification references.
- Static checks for compatibility-stub routing and command duplication boundaries.
- Static or review-evidence checks for backup-before-edit, command context, expected results, fast-path/walkthrough parity, and uv credential avoidance.
- Manual or dry-run command review evidence for high-risk WSL migration and package-source guidance.
- No execution of setup commands from guide code blocks.

Baseline validation commands after the test spec and implementation add the rollout check:

```bash
bash tests/markdown/remaining-guides-template-rollout.test.sh
bash tests/markdown/how-to-guide-template-best-practices.test.sh
bash tests/markdown/guides-two-speed-how-to-structure.test.sh
bash tests/markdown/m1-project-entrypoint.test.sh
bash tests/markdown/m2-windows-wsl-storage.test.sh
bash tests/markdown/m3-ubuntu-baseline.test.sh
bash tests/markdown/m4-neovim-tmux.test.sh
bash tests/markdown/m5-release-readiness.test.sh
git diff --cached --check
```

## Risks and recovery

- Command drift: inventory command blocks before each milestone and compare reviewer-visible command semantics against `specs/terminal-first-workstation-setup.md`; revert the milestone if semantics change without a new accepted spec.
- Safety regression: require backup/export guidance before user-owned, system-owned, or destructive persistent changes; block review if guidance appears only after the edit.
- Over-broad static checks: scope checks to converted guide paths and extend the checked path list milestone by milestone.
- WSL split complexity: keep install and migration separate, keep the numbered compatibility path command-free, and record high-risk review evidence.
- Verification sequencing ambiguity: convert `99-verification.md` only with a verification target inventory and valid active references.
- Link churn: keep numbered paths until compatibility stubs exist and defer broad filename migration.

## Dependencies

- Approved plan review before test spec.
- Approved test spec before implementation.
- Existing troubleshooting anchors or same-slice additions for any inline troubleshooting links introduced by converted guides.
- Existing `tests/markdown/` conventions for static Markdown checks.
- Reviewer availability for high-risk WSL and uv package-source evidence.

## Progress

- 2026-06-16: Proposal review approved the remaining-guides rollout after resolved decisions were recorded.
- 2026-06-16: Spec review approved the rollout spec after RGT-SR-001 made verification sequencing observable.
- 2026-06-16: Plan drafted and spec status normalized to `approved`.
- 2026-06-16: Test spec approved and activated.
- 2026-06-16: M1 implementation converted `05-tmux.md`, `04-neovim.md`, and `06-uv.md`; added scoped rollout proof script; updated legacy Neovim/tmux and entrypoint checks for converted-guide coexistence; recorded M1 implementation evidence.
- 2026-06-16: M1 code-review R1 recorded `clean-with-notes` with no material findings; M1 closed.
- 2026-06-16: M2 implementation converted `01-windows-host.md` as one unified guide; extended the scoped rollout proof for Windows host policy/elevation coverage; updated the legacy Windows/WSL baseline check for converted guide wording; recorded M2 implementation evidence.
- 2026-06-16: M2 code-review R1 recorded `clean-with-notes` with no material findings; M2 closed.
- 2026-06-16: M3 implementation split `02-wsl2-ubuntu.md` into `wsl-ubuntu-install.md` and `wsl-ubuntu-migration.md`; replaced the numbered file with a command-free compatibility stub; updated the router and WSL storage checks for the split; recorded high-risk WSL command review evidence.
- 2026-06-16: M3 code-review R1 recorded `clean-with-notes` with no material findings; M3 closed.
- 2026-06-16: M4 implementation converted `99-verification.md` to the accepted guide shape; added `verification-target-inventory.md`; extended rollout proof for active verification references, unresolved follow-ups, result vocabulary, and M4 evidence; recorded M4 implementation evidence.
- 2026-06-16: M4 code-review R1 recorded `clean-with-notes` with no material findings; M4 closed.
- 2026-06-16: M5 implementation recorded completion evidence in `explain-change.md`, extended rollout proof for closeout evidence and non-claims, and updated lifecycle metadata for M5 code-review.
- 2026-06-16: M5 code-review R1 recorded `clean-with-notes` with no material findings; M5 closed and final closeout is ready to begin at explain-change.
- 2026-06-16: Explain-change updated `explain-change.md` with full diff rationale, requirement traceability, validation evidence, review state, scope control, and remaining risks; lifecycle metadata now hands off to final verify.
- 2026-06-16: Final verify recorded branch-ready evidence in `verify-report.md`; lifecycle metadata now hands off to PR. Hosted CI and PR readiness remain unclaimed.
- 2026-06-16: PR handoff opened PR #4 at https://github.com/xiongxianfei/terminal-first-windows-dev/pull/4 and recorded the PR body in `pr.md`.
- 2026-06-16: PR #4 merged at merge commit `d7ee9ac45cad6a8d0284486a2c90edf58e0af4c3`; lifecycle status moved to done.

## Decision log

| Date | Decision | Reason | Alternatives rejected |
| --- | --- | --- | --- |
| 2026-06-16 | Plan implementation in five milestones | Matches spec risk tiers and keeps WSL/verification work isolated for review | One broad guide conversion diff |
| 2026-06-16 | Put smaller tool guides first | Exercises template conformance on lower-risk guides before Windows host and WSL migration | Highest-risk WSL conversion first |
| 2026-06-16 | Treat WSL split as its own milestone | Fresh install and migration have different starting states and destructive-risk profiles | Keeping WSL split inside a mixed guide-conversion milestone |
| 2026-06-16 | Convert verification only after WSL paths and inventory are ready | Satisfies R58 and prevents active verification links to missing targets | Reviewer-discretion sequencing |

## Surprises and discoveries

- The second-pass spec review approved the spec, but the spec body still said `draft`; this plan normalizes the spec status to `approved` before downstream artifacts rely on it.
- The legacy entrypoint and Neovim/tmux checks still asserted pre-template guide wording. M1 updated those checks to preserve their original contract while accepting the converted guide shape.
- The first draft of the rollout proof rejected the word `secret` in safety prose. M1 narrowed that assertion to credential-like patterns and private-looking hostnames so safety cautions remain allowed.
- The legacy Windows/WSL baseline check asserted the old `PowerShell best practices` heading. M2 updated that assertion to the converted `Windows-side shell posture` walkthrough heading without weakening the underlying host checks.
- The WSL compatibility stub needed to keep two-speed headings for legacy guide-shape checks while avoiding all setup command duplication. M3 made it a route-only page with metadata, fast path, walkthrough, rollback, and troubleshooting links, but no WSL command blocks.
- The rollout proof's command-literal self-guard also applies to ordering assertions. M3 constructs the unregister command string before checking backup/destructive ordering so the script does not embed a runnable-looking destructive command.
- The verification guide has to preserve the legacy release-readiness wording for repository-wide `git diff --check` while also using the new two-speed guide shape. M4 kept the advisory sentence in the converted static-checks walkthrough.
- `03-ubuntu-baseline.md` still exists but is not a converted active verification target. M4 records Ubuntu baseline, WSL config, data mount, locale, and sudo as unresolved verification follow-ups instead of active converted-guide links.
- Explain-change records final verification, branch readiness, and PR readiness as not claimed until later workflow stages own that evidence.

## Validation notes

- Plan-authoring validation is limited to artifact structure and whitespace checks.
- Implementation validation will run after the test spec defines the rollout test script and review-evidence expectations.
- 2026-06-16 M1 pre-implementation proof: `bash tests/markdown/remaining-guides-template-rollout.test.sh` failed as expected with `missing text in docs/guides/05-tmux.md: **Prerequisites:**`.
- 2026-06-16 M1 validation passed:
  - `bash tests/markdown/remaining-guides-template-rollout.test.sh`
  - `bash tests/markdown/how-to-guide-template-best-practices.test.sh`
  - `bash tests/markdown/guides-two-speed-how-to-structure.test.sh`
  - `bash tests/markdown/m1-project-entrypoint.test.sh`
  - `bash tests/markdown/m2-windows-wsl-storage.test.sh`
  - `bash tests/markdown/m3-ubuntu-baseline.test.sh`
  - `bash tests/markdown/m4-neovim-tmux.test.sh`
  - `bash tests/markdown/m5-release-readiness.test.sh`
  - `git diff --check`
- 2026-06-16 M1 code-review validation rerun passed:
  - `bash tests/markdown/remaining-guides-template-rollout.test.sh`
  - `bash tests/markdown/how-to-guide-template-best-practices.test.sh`
  - `bash tests/markdown/guides-two-speed-how-to-structure.test.sh`
  - `bash tests/markdown/m1-project-entrypoint.test.sh`
  - `bash tests/markdown/m2-windows-wsl-storage.test.sh`
  - `bash tests/markdown/m3-ubuntu-baseline.test.sh`
  - `bash tests/markdown/m4-neovim-tmux.test.sh`
  - `bash tests/markdown/m5-release-readiness.test.sh`
  - `git diff --check HEAD^ HEAD`
- 2026-06-16 M2 pre-implementation proof: `bash tests/markdown/remaining-guides-template-rollout.test.sh` failed as expected with `missing text in docs/guides/01-windows-host.md: **Prerequisites:**`.
- 2026-06-16 M2 validation passed:
  - `bash tests/markdown/remaining-guides-template-rollout.test.sh`
  - `bash tests/markdown/how-to-guide-template-best-practices.test.sh`
  - `bash tests/markdown/guides-two-speed-how-to-structure.test.sh`
  - `bash tests/markdown/m1-project-entrypoint.test.sh`
  - `bash tests/markdown/m2-windows-wsl-storage.test.sh`
  - `bash tests/markdown/m3-ubuntu-baseline.test.sh`
  - `bash tests/markdown/m4-neovim-tmux.test.sh`
  - `bash tests/markdown/m5-release-readiness.test.sh`
  - `git diff --check`
- 2026-06-16 M2 code-review validation rerun passed:
  - `bash tests/markdown/remaining-guides-template-rollout.test.sh`
  - `bash tests/markdown/how-to-guide-template-best-practices.test.sh`
  - `bash tests/markdown/guides-two-speed-how-to-structure.test.sh`
  - `bash tests/markdown/m1-project-entrypoint.test.sh`
  - `bash tests/markdown/m2-windows-wsl-storage.test.sh`
  - `bash tests/markdown/m3-ubuntu-baseline.test.sh`
  - `bash tests/markdown/m4-neovim-tmux.test.sh`
  - `bash tests/markdown/m5-release-readiness.test.sh`
  - `git diff --check HEAD^ HEAD`
- 2026-06-16 M3 pre-implementation proof: `bash tests/markdown/remaining-guides-template-rollout.test.sh` failed as expected with `missing required file: docs/guides/wsl-ubuntu-install.md`.
- 2026-06-16 M3 validation passed:
  - `bash tests/markdown/remaining-guides-template-rollout.test.sh`
  - `bash tests/markdown/how-to-guide-template-best-practices.test.sh`
  - `bash tests/markdown/guides-two-speed-how-to-structure.test.sh`
  - `bash tests/markdown/m1-project-entrypoint.test.sh`
  - `bash tests/markdown/m2-windows-wsl-storage.test.sh`
  - `bash tests/markdown/m3-ubuntu-baseline.test.sh`
  - `bash tests/markdown/m4-neovim-tmux.test.sh`
  - `bash tests/markdown/m5-release-readiness.test.sh`
  - `git diff --check`
- 2026-06-16 M3 code-review validation rerun passed:
  - `bash tests/markdown/remaining-guides-template-rollout.test.sh`
  - `bash tests/markdown/how-to-guide-template-best-practices.test.sh`
  - `bash tests/markdown/guides-two-speed-how-to-structure.test.sh`
  - `bash tests/markdown/m1-project-entrypoint.test.sh`
  - `bash tests/markdown/m2-windows-wsl-storage.test.sh`
  - `bash tests/markdown/m3-ubuntu-baseline.test.sh`
  - `bash tests/markdown/m4-neovim-tmux.test.sh`
  - `bash tests/markdown/m5-release-readiness.test.sh`
  - `git diff --check HEAD^ HEAD`
- 2026-06-16 M4 pre-implementation proof: `bash tests/markdown/remaining-guides-template-rollout.test.sh` failed as expected with `missing text in docs/guides/99-verification.md: **Prerequisites:**`.
- 2026-06-16 M4 validation passed:
  - `bash tests/markdown/remaining-guides-template-rollout.test.sh`
  - `bash tests/markdown/how-to-guide-template-best-practices.test.sh`
  - `bash tests/markdown/guides-two-speed-how-to-structure.test.sh`
  - `bash tests/markdown/m1-project-entrypoint.test.sh`
  - `bash tests/markdown/m2-windows-wsl-storage.test.sh`
  - `bash tests/markdown/m3-ubuntu-baseline.test.sh`
  - `bash tests/markdown/m4-neovim-tmux.test.sh`
  - `bash tests/markdown/m5-release-readiness.test.sh`
  - `git diff --check`
- 2026-06-16 M4 code-review validation rerun passed:
  - `bash tests/markdown/remaining-guides-template-rollout.test.sh`
  - `bash tests/markdown/how-to-guide-template-best-practices.test.sh`
  - `bash tests/markdown/guides-two-speed-how-to-structure.test.sh`
  - `bash tests/markdown/m1-project-entrypoint.test.sh`
  - `bash tests/markdown/m2-windows-wsl-storage.test.sh`
  - `bash tests/markdown/m3-ubuntu-baseline.test.sh`
  - `bash tests/markdown/m4-neovim-tmux.test.sh`
  - `bash tests/markdown/m5-release-readiness.test.sh`
  - `git diff --check HEAD^ HEAD`
- 2026-06-16 M5 pre-implementation proof: `bash tests/markdown/remaining-guides-template-rollout.test.sh` failed as expected with `missing required file: docs/changes/2026-06-16-remaining-guides-template-rollout/explain-change.md`.
- 2026-06-16 M5 validation passed:
  - `bash tests/markdown/remaining-guides-template-rollout.test.sh`
  - `bash tests/markdown/how-to-guide-template-best-practices.test.sh`
  - `bash tests/markdown/guides-two-speed-how-to-structure.test.sh`
  - `bash tests/markdown/m1-project-entrypoint.test.sh`
  - `bash tests/markdown/m2-windows-wsl-storage.test.sh`
  - `bash tests/markdown/m3-ubuntu-baseline.test.sh`
  - `bash tests/markdown/m4-neovim-tmux.test.sh`
  - `bash tests/markdown/m5-release-readiness.test.sh`
  - `git diff --check`
- 2026-06-16 M5 code-review validation rerun passed:
  - `bash tests/markdown/remaining-guides-template-rollout.test.sh`
  - `bash tests/markdown/how-to-guide-template-best-practices.test.sh`
  - `bash tests/markdown/guides-two-speed-how-to-structure.test.sh`
  - `bash tests/markdown/m1-project-entrypoint.test.sh`
  - `bash tests/markdown/m2-windows-wsl-storage.test.sh`
  - `bash tests/markdown/m3-ubuntu-baseline.test.sh`
  - `bash tests/markdown/m4-neovim-tmux.test.sh`
  - `bash tests/markdown/m5-release-readiness.test.sh`
  - `git diff --check HEAD^ HEAD`
- 2026-06-16 explain-change validation passed:
  - `bash tests/markdown/remaining-guides-template-rollout.test.sh`
  - `git diff --check`
- 2026-06-16 final verify validation passed:
  - `bash tests/markdown/remaining-guides-template-rollout.test.sh`
  - `bash tests/markdown/how-to-guide-template-best-practices.test.sh`
  - `bash tests/markdown/guides-two-speed-how-to-structure.test.sh`
  - `bash tests/markdown/m1-project-entrypoint.test.sh`
  - `bash tests/markdown/m2-windows-wsl-storage.test.sh`
  - `bash tests/markdown/m3-ubuntu-baseline.test.sh`
  - `bash tests/markdown/m4-neovim-tmux.test.sh`
  - `bash tests/markdown/m5-release-readiness.test.sh`
  - `git diff --check`
  - `git diff --check ab8ada5c47237af6ae718ff4411763f19317dde0..HEAD`

## Outcome and retrospective

Pending implementation.

## Readiness

- M1 is closed.
- M2 is closed.
- M3 is closed.
- M4 is closed.
- M5 is closed.
- Explain-change is recorded.
- Final verification is recorded.
- PR #4 merged.
