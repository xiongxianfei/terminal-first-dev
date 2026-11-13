# 009: Use task-writer directly and remove the repository template

**Date:** 2026-11-13

## Background

The user requested using the installed task-writer skill instead of maintaining a repository template, shortening AGENTS, and removing the entire README Tasks row. Existing task files remain, with obsolete template references cleaned up. The user reviewed the task draft and requested implementation.

## Input

- [AGENTS.md](../AGENTS.md) — duplicated format guidance and local conventions.
- `tasks/TEMPLATE.md` — template scheduled for deletion.
- [README.md](../README.md) — Tasks row to remove.
- [REQS.md](../REQS.md) — requirements to preserve.
- [Merged skill package](https://github.com/xiongxianfei/skillsmith/tree/0bd57b5384a5a6319dc5b409bbc8a9b81c2c3363/skills/task-writer) — installation source including its conditional example.
- [PR #58](https://github.com/xiongxianfei/skillsmith/pull/58) — merged source revision.

## Output

- **Install** the complete skill from commit `0bd57b5384a5a6319dc5b409bbc8a9b81c2c3363` into the current user's Codex skills directory, `~/.codex/skills/task-writer/`.
- **Create** [tasks/009-use-task-writer-directly.md](009-use-task-writer-directly.md) — task and verification results.
- **Delete** `tasks/TEMPLATE.md`.
- **Modify** [AGENTS.md](../AGENTS.md) — delegate formatting to the skill and retain local conventions.
- **Modify** [README.md](../README.md) — remove the entire Tasks row without replacement.
- **Modify** [tasks/003-standardize-task-records.md](003-standardize-task-records.md), [tasks/004-file-paths-and-json-tool-index.md](004-file-paths-and-json-tool-index.md), [tasks/005-json-only-tool-index.md](005-json-only-tool-index.md), [tasks/006-create-task-writer-skill.md](006-create-task-writer-skill.md), [tasks/007-refine-task-template-and-skill.md](007-refine-task-template-and-skill.md), and [tasks/008-refine-skillsmith-authoring-and-task-writer.md](008-refine-skillsmith-authoring-and-task-writer.md) — remove obsolete template links and directions.

Acceptance criteria: valid installed package with its reference; no duplicated format or lifecycle rules in AGENTS; no local template or README Tasks row; existing records retained without links to the deleted template; required checks pass and unrelated edits remain intact.

## Rules

Follow [requirements](../REQS.md) and local conventions except where this task replaces task maintenance rules. Install only task-writer for the current Codex user. Do not modify Skillsmith upstream or other agent environments. Preserve existing task numbering, unrelated content, and actual verification results. No archives, replacement templates, README task entries, commits, pushes, or PRs.

## Approach

1. Save this task without README navigation and snapshot existing files.
2. Install the complete pinned package with the skill-installer helper and validate it before deleting the template. If installation fails, retain the template. Inspect any unexpected existing installation before overwriting.
3. Replace AGENTS task guidance with skill delegation, next-unused numbering, date placement, required verification, separate task-link checks, show-first behavior, and an explicit missing-skill dependency report. Retain repository check commands.
4. Delete the template and README Tasks row. Replace deleted-template links in records 003–008 with plain-text mentions where needed for past-work statements; remove obsolete directions to use it. Add no archival explanation.
5. Run skill metadata validation, repository unit tests, documentation checks, whitespace checks, and targeted link inspection. Review the diff and preserved files. Report installation separately from observed automatic discovery; the installed skill becomes available on the next turn.

## Progress checklist

- [x] Save task 009 and snapshot existing files.
- [x] Install and validate task-writer.
- [x] Shorten AGENTS and delete the template and README Tasks row.
- [x] Clean obsolete task-record references.
- [x] Run checks, inspect the diff, and record results.

## Execution result

Completed the agreed scope. Installed the complete task-writer package from the pinned merged revision into `~/.codex/skills/task-writer/`, including `references/everyday-example.md`. Removed the repository template and README Tasks row, shortened AGENTS to skill delegation and local conventions, and converted deleted-template links in records 003–008 to plain-text mentions. Existing task files and unrelated edits remain intact. No archives or replacement template were created.

Verification on 2026-11-13 in the existing Ubuntu 24.04.4 LTS / WSL2 environment with Python 3.12.3:

- Skill-installer completed successfully; skill-creator metadata validation passed and the referenced example exists.
- All 7 documentation-checker unit tests passed.
- Documentation checker passed: 18 maintained Markdown files, 126 local links/anchors.
- `git diff --check` passed. Reviewed changes against the pre-task snapshot and confirmed unrelated files were unchanged.
- Inspected 114 local links across all nine task records and the installed entrypoint. No deleted-template links remain. Seven pre-existing missing targets remain in tasks 001, 002, and 004, referring to the previously removed tool README, generator, and generator test; these are unrelated to this task. All other inspected links/anchors resolve.

Acceptance criteria met. No installation or automated-check failures occurred. Automatic discovery was not observed during this turn; the installed skill will be available on the next turn. External URLs and live model behavior were not tested. Changes remain uncommitted; no push, PR, or upstream Skillsmith change was made.


The user subsequently requested committing the pending repository changes and creating a PR to main. Published the final documentation changes as `7ae99ab` on `docs/json-index-and-task-writer`, based on current main, and opened [terminal-first-dev PR #12](https://github.com/xiongxianfei/terminal-first-dev/pull/12). The PR includes the pending JSON-index work and records from this session, and supersedes PR #11's template-based approach. Re-ran all 7 unit tests, the documentation checker (18 files, 126 links), JSON parsing, and whitespace checks successfully. Rebasing made no file-content changes. The installed skill remains outside Git. No merge was performed.


After PR #11 merged, the user requested resolving PR #12's conflicts. Merged main at `29bf6e0` into the PR branch, retaining the approved skill-based AGENTS instructions, README Tasks-row removal, and plain-text template mentions in task 003. Removed the template reintroduced by main. The resolved tree matched the pre-merge implementation before adding this note. All 7 unit tests, documentation checks (18 files, 126 links), and whitespace checks passed.
