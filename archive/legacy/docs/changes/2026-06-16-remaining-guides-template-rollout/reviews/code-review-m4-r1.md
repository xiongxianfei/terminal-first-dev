# Code Review M4 R1: Remaining Guides Template Rollout

## Result

- Skill: code-review
- Status: completed
- Artifacts changed: `docs/changes/2026-06-16-remaining-guides-template-rollout/reviews/code-review-m4-r1.md`, `docs/changes/2026-06-16-remaining-guides-template-rollout/review-log.md`, `docs/plans/2026-06-16-remaining-guides-template-rollout.md`, `docs/changes/2026-06-16-remaining-guides-template-rollout/change.yaml`, `docs/plan.md`
- Open blockers: none
- Next stage: implement next milestone
- Review status: clean-with-notes
- Material findings: none
- Recording status: recorded
- Recording blocker: none
- Review record: `docs/changes/2026-06-16-remaining-guides-template-rollout/reviews/code-review-m4-r1.md`
- Review log: `docs/changes/2026-06-16-remaining-guides-template-rollout/review-log.md`
- Review resolution: not-required
- Reviewed milestone: M4
- Milestone closeout: closed
- Remaining implementation milestones: M5
- Required review-resolution: no
- Finding IDs: none
- Verify readiness: not-claimed

## Review Inputs

- Diff/review surface: `fcafd69 M4: convert verification guide`
- Tracked governing branch state: reviewed commit is present in local branch history
- Plan: `docs/plans/2026-06-16-remaining-guides-template-rollout.md`
- Spec: `specs/remaining-guides-template-rollout.md`
- Test spec: `specs/remaining-guides-template-rollout.test.md`
- Implementation evidence: `docs/changes/2026-06-16-remaining-guides-template-rollout/reviews/m4-implementation-evidence.md`
- Verification target inventory: `docs/changes/2026-06-16-remaining-guides-template-rollout/verification-target-inventory.md`
- Tests reviewed: `tests/markdown/remaining-guides-template-rollout.test.sh`, `tests/markdown/m5-release-readiness.test.sh`

## Diff Summary

M4 converted `docs/guides/99-verification.md` to the accepted visible metadata, `Fast path`, `Walkthrough`, `Rollback`, and `Troubleshooting` shape. The converted guide preserves the result vocabulary, verification matrix, publication gate, static checks, and rollback coverage.

The diff added `docs/changes/2026-06-16-remaining-guides-template-rollout/verification-target-inventory.md` to distinguish active verification references from unresolved follow-ups. It also extended the rollout proof to check active paths, unresolved Ubuntu baseline handling, result vocabulary, and M4 evidence.

## Findings

No blocking or required-change findings.

## Checklist Coverage

| Check | Verdict | Evidence |
| --- | --- | --- |
| Spec alignment | pass | M4 satisfies R58-R60 and R75: verification is converted after prior guide paths exist, active references point to existing paths, unresolved Ubuntu baseline targets are inventoried, and the result vocabulary is preserved. |
| Test coverage | pass | `tests/markdown/remaining-guides-template-rollout.test.sh` checks converted-guide shape for `99-verification.md`, inventory presence, active referenced paths, unresolved baseline link rejection, result vocabulary, and M4 evidence fields. |
| Edge cases | pass | The guide records manual Windows checks as `needs manual action` or `skipped` when unrun, and unresolved Ubuntu baseline, WSL config, data mount, locale, and sudo targets are not active converted-guide links. |
| Error handling | pass | Verification failures are represented as `fail`; missing or policy-blocked tools are routed to `needs manual action`; missing optional local tools are `skipped` or `needs manual action`. |
| Architecture boundaries | pass | The change remains documentation and static validation only. It adds no command-execution CI, generated docs, installers, or hidden automation. |
| Compatibility | pass | Existing router behavior remains intact while `99-verification.md` references current task-scoped paths. No broad filename migration is introduced. |
| Security/privacy | pass | The guide warns that verification output must not include secrets, proxy credentials, tokens, private hostnames, or private machine paths. |
| Derived artifact currency | pass | No generated artifacts are involved. Plan, change metadata, review log, M4 evidence, and inventory are synchronized for the milestone state. |
| Unrelated changes | pass | The diff is limited to verification guide conversion, inventory/evidence, rollout proof checks, and lifecycle metadata. |
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

The actual M4 diff satisfies the approved verification sequencing rule without pointing active verification links at missing or not-yet-converted guide paths. The inventory records unresolved follow-ups, and the proof script directly checks the split between active references and unresolved baseline targets.

## Residual Risks

No material M4 residual risk identified. M5 still needs separate implementation and review for lifecycle closeout and completion evidence.

## Handoff

M4 is closed. Next stage is `implement` for M5. No review-resolution is required.
