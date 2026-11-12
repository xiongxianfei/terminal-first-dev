# Review Resolution: MacBook Setup Best Practices Plan

## Result

- Skill: plan
- Status: completed
- Closeout status: closed
- Material findings closed: PR-001, CR-M2-001
- Open findings: none
- Finding: PR-001
- Resolution status: closed by plan-review R2
- Recording status: recorded
- Review record: `docs/changes/2026-06-17-macbook-setup-best-practices/reviews/plan-review-r1.md`
- Review log: `docs/changes/2026-06-17-macbook-setup-best-practices/review-log.md`
- Updated artifact: `docs/plans/2026-06-17-macbook-setup-best-practices.md`
- Open blockers: none
- Next stage: test-spec

## Finding

### PR-001 - Companion-repo validation commands do not name their execution workdir

- Disposition: accepted
- Action taken: revised the plan's M1-M3 validation commands and global validation plan to state whether each command runs from `/home/xiongxianfei/data/20260524-terminal-dev` or `/home/xiongxianfei/data/20260617-terminal-first-macos-dev`.
- Rationale: The implementation surface is the sibling macOS companion repository while lifecycle artifacts remain in this Windows repository, so validation commands need explicit workdir boundaries.
- Validation evidence: current-repo `git diff --check` passed for the resolution edits.
- Remaining action: none; plan-review R2 approved the resolution.

## Code Review Resolution - CR-M2-001

- Skill: implement
- Status: completed
- Finding: CR-M2-001
- Resolution status: closed by code-review M2 R2
- Recording status: recorded
- Review record: `docs/changes/2026-06-17-macbook-setup-best-practices/reviews/code-review-m2.md`
- Review log: `docs/changes/2026-06-17-macbook-setup-best-practices/review-log.md`
- Updated companion artifact: `../20260617-terminal-first-macos-dev/docs/guides/macbook-terminal-baseline.md`
- Updated companion proof: `../20260617-terminal-first-macos-dev/tests/markdown/macbook-setup-best-practices.test.sh`
- Companion commit: `271f260 M2: add source reference checks`
- Open blockers: none
- Next stage: implement M3

### Finding

CR-M2-001 - M2 guide and proof do not include or validate Apple/Homebrew source-reference links required by the plan.

### Resolution Summary

Added official source links near the relevant setup guidance:

- Apple Software Update: `https://support.apple.com/en-us/108382`
- Apple Command Line Tools: `https://developer.apple.com/documentation/xcode/installing-the-command-line-tools`
- Homebrew installation documentation: `https://docs.brew.sh/Installation`
- Homebrew install and uninstall script repository: `https://github.com/Homebrew/install`

Extended `tests/markdown/macbook-setup-best-practices.test.sh` to assert those source links. No setup automation, Brewfiles, generated configuration, or command-success claims were added.

### Validation Evidence

- Expected failing proof before the guide fix: `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && bash tests/markdown/macbook-setup-best-practices.test.sh` failed with `FAIL: docs/guides/macbook-terminal-baseline.md missing official Apple Software Update source link`.
- After the guide fix: `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && bash tests/markdown/macbook-setup-best-practices.test.sh` passed.
- `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && git diff --check` passed.

### Remaining Action

Closed by `docs/changes/2026-06-17-macbook-setup-best-practices/reviews/code-review-m2-r2.md`. Proceed to M3 implementation.
