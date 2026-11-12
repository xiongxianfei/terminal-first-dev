# PR Handoff: Remaining Guides Template Rollout

## Title

docs: roll out guide template to remaining guides

## PR Open Status

- Status: merged.
- URL: https://github.com/xiongxianfei/terminal-first-windows-dev/pull/4
- Merged at: 2026-06-16T13:20:16Z
- Merge commit: `d7ee9ac45cad6a8d0284486a2c90edf58e0af4c3`
- Local branch: `proposal/other-guides-template-rollout`
- Base branch: `main`
- Blocker: none.

## Summary

- Convert the remaining first-slice guides to the accepted how-to guide shape with visible metadata, fast paths, walkthroughs, expected results, backup guidance, rollback, and troubleshooting routing.
- Split WSL fresh install and WSL migration into separate task guides while preserving `02-wsl2-ubuntu.md` as a command-free compatibility path.
- Convert `99-verification.md` only after active referenced paths exist or unresolved targets are inventoried.
- Add a scoped rollout proof script and lifecycle evidence for implementation reviews, explanation, verification, and PR handoff.

## Why

- The repository already accepted the two-speed guide structure and reusable guide template, but several first-slice guides still used the older structure.
- The rollout needed to improve skimmability and safety without changing approved Windows, WSL, Ubuntu, Neovim, tmux, uv, or verification command semantics.
- WSL migration and verification needed explicit compatibility and sequencing evidence to avoid broken links, duplicated commands, or destructive-operation ambiguity.

## Spec / plan / architecture

- Proposal: `docs/proposals/2026-06-16-remaining-guides-template-rollout.md`
- Proposal review: `docs/changes/2026-06-16-remaining-guides-template-rollout/reviews/proposal-review.md`
- Spec: `specs/remaining-guides-template-rollout.md`
- Spec review: `docs/changes/2026-06-16-remaining-guides-template-rollout/reviews/spec-review.md`
- Spec review resolution: `docs/changes/2026-06-16-remaining-guides-template-rollout/reviews/spec-review-resolution.md`
- Test spec: `specs/remaining-guides-template-rollout.test.md`
- Plan: `docs/plans/2026-06-16-remaining-guides-template-rollout.md`
- Architecture / ADRs: not required; this change is Markdown guide structure, router updates, compatibility stubs, static checks, and review evidence only.
- Explain change: `docs/changes/2026-06-16-remaining-guides-template-rollout/explain-change.md`
- Verify report: `docs/changes/2026-06-16-remaining-guides-template-rollout/verify-report.md`

## What changed

- `docs/guides/05-tmux.md`, `04-neovim.md`, and `06-uv.md`: converted smaller tool guides first while preserving numbered paths and optional uv status.
- `docs/guides/01-windows-host.md`: converted as one unified Windows host guide with policy and elevation notes near relevant commands.
- `docs/guides/wsl-ubuntu-install.md` and `docs/guides/wsl-ubuntu-migration.md`: added separate task guides for WSL fresh install and migration.
- `docs/guides/02-wsl2-ubuntu.md`: replaced the old full guide body with a command-free compatibility stub that routes by starting state.
- `docs/guides/99-verification.md`: converted to the accepted guide shape after adding `verification-target-inventory.md`.
- `docs/guides/README.md`: updated router entries while numbered and task-scoped paths coexist.
- `tests/markdown/remaining-guides-template-rollout.test.sh`: added scoped structure, link, compatibility, security/privacy, verification sequencing, and lifecycle evidence checks.
- Existing Markdown checks were updated only where old wording assumptions conflicted with the accepted converted-guide shape.
- Change-local artifacts record proposal/spec/test-spec/plan/review/explanation/verification/PR evidence.

## Tests and verification

- [x] `bash tests/markdown/remaining-guides-template-rollout.test.sh` - passed.
- [x] `bash tests/markdown/how-to-guide-template-best-practices.test.sh` - passed.
- [x] `bash tests/markdown/guides-two-speed-how-to-structure.test.sh` - passed.
- [x] `bash tests/markdown/m1-project-entrypoint.test.sh` - passed.
- [x] `bash tests/markdown/m2-windows-wsl-storage.test.sh` - passed.
- [x] `bash tests/markdown/m3-ubuntu-baseline.test.sh` - passed.
- [x] `bash tests/markdown/m4-neovim-tmux.test.sh` - passed.
- [x] `bash tests/markdown/m5-release-readiness.test.sh` - passed.
- [x] `git diff --check` - passed.
- [x] `git diff --check ab8ada5c47237af6ae718ff4411763f19317dde0..HEAD` - passed.
- [ ] Hosted CI - not available or not observed; no `.github` workflow directory is present in this workspace.

## Requirement coverage

| Requirement area | Evidence |
| --- | --- |
| R1-R26 converted guide contract and safety rules | Converted guides, `remaining-guides-template-rollout.test.sh`, M1-M5 review evidence |
| R27-R39 smaller tool guides | `05-tmux.md`, `04-neovim.md`, `06-uv.md`, M1 evidence and review |
| R40-R43 Windows host guide | `01-windows-host.md`, M2 evidence and review |
| R44-R57 WSL split and compatibility stub | `wsl-ubuntu-install.md`, `wsl-ubuntu-migration.md`, `02-wsl2-ubuntu.md`, M3 evidence and review |
| R58-R60, R75 verification sequencing | `99-verification.md`, `verification-target-inventory.md`, M4 evidence and review |
| R61-R66 router and filename-migration boundaries | `docs/guides/README.md`, WSL compatibility stub, rollout proof |
| R67-R74 static checks, review evidence, completion evidence | Rollout proof script, review log, explain-change, verify report |
| AC1-AC21 | `verify-report.md` traceability table and final validation set |

## Review resolution summary

- Accepted: 0 implementation review findings
- Rejected: 0
- Deferred: 0
- Partially accepted: 0
- Needs decision: 0
- Review-resolution: not required for implementation code-review findings

Spec-review finding RGT-SR-001 was resolved before implementation in `docs/changes/2026-06-16-remaining-guides-template-rollout/reviews/spec-review-resolution.md`.

## Risks and rollback

- Static checks validate Markdown structure, links, compatibility boundaries, security/privacy guardrails, and lifecycle evidence; they do not execute workstation setup commands.
- Hosted CI was not observed because no `.github` workflow directory exists in this workspace.
- Broad final filename migration remains deferred to a later compatibility slice.
- `03-ubuntu-baseline.md`, WSL config, data mount, locale, and sudo verification targets remain unresolved verification follow-ups rather than active converted-guide links.
- Rollback can revert the converted guide bodies, WSL split/stub, router update, rollout proof script, and change-local artifacts from this branch. No runtime scripts, generated docs, or machine-changing automation were added.

## Reviewer notes

- Focus on command-semantics preservation while guide bodies moved into the template shape.
- Pay close attention to the WSL split: the old numbered path should route only and must not duplicate WSL install, migration, unregister, import, or import-in-place commands.
- Check that fast paths stay short enough to skim and that backup/export guidance appears before file edits or destructive persistent changes.
- The rollout proof intentionally remains local/static and avoids command execution by design.

## Follow-ups

- Broad final unnumbered filename migration remains a later compatibility slice.
- Command-execution validation remains deferred until command contracts and a Windows + WSL runner model are settled.
