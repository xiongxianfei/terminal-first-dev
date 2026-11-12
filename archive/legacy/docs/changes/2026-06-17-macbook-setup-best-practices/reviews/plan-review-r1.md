# Plan Review R1: MacBook Setup Best Practices

## Result

- Skill: plan-review
- Review status: changes-requested
- Material findings: PR-001
- Recording status: recorded
- Recording blocker: none
- Review record: `docs/changes/2026-06-17-macbook-setup-best-practices/reviews/plan-review-r1.md`
- Review log: `docs/changes/2026-06-17-macbook-setup-best-practices/review-log.md`
- Review resolution: not-required before fixing; required after revision only if the finding disposition needs separate explanation
- Open blockers: PR-001
- Immediate next stage: plan revision

## Findings

### PR-001 - Companion-repo validation commands do not name their execution workdir

- Finding ID: PR-001
- Severity: major
- Location: `docs/plans/2026-06-17-macbook-setup-best-practices.md`, M1-M3 validation commands and global validation plan
- Evidence: The plan correctly says the implementation surface is `../20260617-terminal-first-macos-dev` and lists companion-repo files such as `../20260617-terminal-first-macos-dev/tests/markdown/macbook-setup-best-practices.test.sh`. However, M1-M3 validation commands use `bash tests/markdown/macbook-setup-best-practices.test.sh` and `git diff --check` without stating whether those commands run from the Windows repo or the companion repo. From this repository, that test path does not exist; from the companion repo, it is plausible. The ambiguity matters because the plan is stored in the Windows repo while implementation files live in a sibling repository.
- Required outcome: Make validation commands unambiguous about repository/workdir boundaries before test-spec or implementation begins.
- Safe resolution path: Revise the plan so companion-repo commands either use an explicit workdir form such as `cd ../20260617-terminal-first-macos-dev && bash tests/markdown/macbook-setup-best-practices.test.sh` and `cd ../20260617-terminal-first-macos-dev && git diff --check`, or use fully qualified relative paths from this repository. If the current repo also needs a docs-only check for plan metadata, list that separately as `git diff --check` from `/home/xiongxianfei/data/20260524-terminal-dev`.

## Review Dimensions

| Review dimension | Verdict | Notes |
| --- | --- | --- |
| self-contained context | pass | The plan names the accepted proposal, approved spec, spec review, workflow guide, constitution, companion repository workdir, and current handoff state. |
| source alignment | pass | Milestones map to R1-R29 and AC1-AC8 without adding role stacks, managed-Mac defaults, Intel claims, or automation beyond the approved spec. |
| milestone size | pass | M1 companion baseline, M2 guide content, and M3 verification evidence are reviewable slices. |
| sequencing | pass | Plan-review precedes test-spec, M1 precedes guide content, and M3 waits for the guide plus real manual verification evidence. |
| scope discipline | pass | The plan preserves the Windows-repo boundary and keeps macOS implementation in the companion repo. |
| validation quality | concern | PR-001 leaves validation commands ambiguous across two repositories. |
| TDD readiness | concern | Test-spec is correctly required before implementation, but PR-001 must be fixed so the eventual test commands are executable from a known workdir. |
| risk coverage | pass | The plan covers companion baseline drift, scope creep, automation creep, managed-Mac safety, and unavailable verification evidence. |
| architecture alignment | pass | Architecture is correctly skipped for documentation-only guide work and explicitly triggered if scripts, Brewfiles, generated config, dotfile bootstrap, or setup automation appear. |
| operational readiness | concern | Companion repo exists and is clean, but command execution context must be explicit before implementation. |
| plan maintainability | pass | Current handoff, dependencies, progress, decision log, validation notes, and remaining gates are visible. |

## Missing Milestones Or Dependencies

No missing implementation milestones. The required fix is to clarify cross-repository validation command execution context.

## Suggested Edits

- In M1-M3 validation commands, replace bare `bash tests/markdown/macbook-setup-best-practices.test.sh` with a command that explicitly runs in `../20260617-terminal-first-macos-dev`.
- In M1-M3 validation commands, clarify whether `git diff --check` runs in this repository, the companion repository, or both.
- In the global validation plan, name the companion repo workdir for the Markdown/static checks and link-check command selection.

## Recommendation

Revise the plan for PR-001, then rerun plan-review. No automatic downstream handoff occurs from this direct review invocation.
