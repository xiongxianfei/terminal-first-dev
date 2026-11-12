# Code Review M3 R1: Remaining Guides Template Rollout

## Result

- Skill: code-review
- Status: completed
- Artifacts changed: `docs/changes/2026-06-16-remaining-guides-template-rollout/reviews/code-review-m3-r1.md`, `docs/changes/2026-06-16-remaining-guides-template-rollout/review-log.md`, `docs/plans/2026-06-16-remaining-guides-template-rollout.md`, `docs/changes/2026-06-16-remaining-guides-template-rollout/change.yaml`, `docs/plan.md`
- Open blockers: none
- Next stage: implement next milestone
- Review status: clean-with-notes
- Material findings: none
- Recording status: recorded
- Recording blocker: none
- Review record: `docs/changes/2026-06-16-remaining-guides-template-rollout/reviews/code-review-m3-r1.md`
- Review log: `docs/changes/2026-06-16-remaining-guides-template-rollout/review-log.md`
- Review resolution: not-required
- Reviewed milestone: M3
- Milestone closeout: closed
- Remaining implementation milestones: M4-M5
- Required review-resolution: no
- Finding IDs: none
- Verify readiness: not-claimed

## Review Inputs

- Diff/review surface: `371b5d2 M3: split WSL install and migration guides`
- Tracked governing branch state: reviewed commit is present in local branch history
- Plan: `docs/plans/2026-06-16-remaining-guides-template-rollout.md`
- Spec: `specs/remaining-guides-template-rollout.md`
- Test spec: `specs/remaining-guides-template-rollout.test.md`
- Workstation setup spec: `specs/terminal-first-workstation-setup.md`
- Implementation evidence: `docs/changes/2026-06-16-remaining-guides-template-rollout/reviews/m3-implementation-evidence.md`
- Tests reviewed: `tests/markdown/remaining-guides-template-rollout.test.sh`, `tests/markdown/m2-windows-wsl-storage.test.sh`, `tests/markdown/guides-two-speed-how-to-structure.test.sh`

## Diff Summary

M3 split the old combined WSL guide into `docs/guides/wsl-ubuntu-install.md` for fresh custom-location installs and `docs/guides/wsl-ubuntu-migration.md` for export/import-in-place migration.

The old `docs/guides/02-wsl2-ubuntu.md` path remains as a compatibility stub that routes by starting state and contains no WSL setup or migration commands. The router now links directly to the install and migration guides while preserving the old numbered WSL path as compatibility.

The diff extended rollout and legacy Markdown checks to validate the split files, command-free stub behavior, backup/export-before-unregister ordering, router links, and M3 evidence.

## Findings

No blocking or required-change findings.

## Checklist Coverage

| Check | Verdict | Evidence |
| --- | --- | --- |
| Spec alignment | pass | M3 satisfies R44-R57: fresh install and migration are split, `02-wsl2-ubuntu.md` remains a stub, router links route to both task guides, the install guide preserves the explicit `--distribution` and `--location` command contract, and migration preserves export/import-in-place ordering. |
| Test coverage | pass | `tests/markdown/remaining-guides-template-rollout.test.sh` now checks the two WSL guide files, stub command prohibition, install command contract, migration command contract, backup/export-before-unregister order, router links, and M3 evidence fields. |
| Edge cases | pass | Unsupported `--location`, Store/web-download fallback, missing storage-path clarity, export failure, import-in-place failure, wrong default distro, and launch failure are routed to existing troubleshooting or rollback guidance. |
| Error handling | pass | Migration blocks unregister until export verification is visible, labels unregister as destructive before the command block, and preserves the VHDX as the recovery source if import fails. |
| Architecture boundaries | pass | The change remains documentation and static validation only. It introduces no installer, generated documentation, hidden automation, or command-execution CI. |
| Compatibility | pass | The numbered WSL path remains available for old links and contains only routing, explanation, rollback-not-applicable text, and troubleshooting links. Unrelated numbered guides were not renamed. |
| Security/privacy | pass | No secrets, credentials, private hostnames, or private paths were introduced. Destructive WSL registration changes are labeled before commands. |
| Derived artifact currency | pass | No generated artifacts are involved. Change metadata, plan handoff, review log, and M3 implementation evidence are synchronized for the milestone state. |
| Unrelated changes | pass | The diff is limited to the WSL split, router/test updates needed by that split, M3 evidence, and lifecycle metadata. |
| Validation evidence | pass | The cited validation commands were rerun during review and passed. |

## Validation Evidence

Review reran these commands successfully:

```bash
bash tests/markdown/remaining-guides-template-rollout.test.sh
bash tests/markdown/how-to-guide-template-best-practices.test.sh
bash tests/markdown/guides-two-speed-how-to-structure.test.sh
bash tests/markdown/m1-project-entrypoint.test.sh
bash tests/markdown/m2-windows-wsl-storage.test.sh
bash tests/markdown/m3-ubuntu-baseline.test.sh
bash tests/markdown/m4-neovim-tmux.test.sh
bash tests/markdown/m5-release-readiness.test.sh
git diff --check HEAD^ HEAD
```

## No-Finding Rationale

The actual M3 diff satisfies the approved WSL split without changing the accepted WSL command contracts or broadening filename migration. The compatibility stub avoids command duplication, and the migration guide keeps backup/export and destructive warnings before the unregister command in both fast path and walkthrough.

## Residual Risks

No material M3 residual risk identified. Later milestones still need separate review for verification guide sequencing and lifecycle closeout.

## Handoff

M3 is closed. Next stage is `implement` for M4. No review-resolution is required.
