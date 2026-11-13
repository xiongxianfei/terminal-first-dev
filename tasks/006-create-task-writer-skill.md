# 006: Create a lightweight task-writing skill

**Date:** 2026-11-13

## Background

The user wants to share this repository's task-writing approach through Skillsmith. The goal is practical value with little overhead: make the work clear enough to start without turning every request into a large engineering process. The user selected a compact default format covering writing, research, personal planning, and repository work, and requested implementation of the supplied plan.

## Input

- [AGENTS.md](../AGENTS.md) — current task-record conventions.
- [REQS.md](../REQS.md) — repository requirements.
- `tasks/TEMPLATE.md` — source ideas to simplify and generalize.
- [Skillsmith AGENTS.md](https://github.com/xiongxianfei/skillsmith/blob/main/AGENTS.md) — target repository conventions.
- [Skillsmith quality standard](https://github.com/xiongxianfei/skillsmith/blob/main/docs/skill-quality-standard.md) — portable skill requirements.
- [Skillsmith workflow](https://github.com/xiongxianfei/skillsmith/blob/main/docs/workflows.md) — contribution and validation requirements.
- [Skillsmith README.md](https://github.com/xiongxianfei/skillsmith/blob/main/README.md) — catalog to update.

The local Skillsmith checkout contains unrelated changes, including an untracked start-of-work skill. Preserve them. The new skill focuses on writing a task artifact rather than facilitating a planning discussion. Record the inspected Skillsmith base revision with the results.

## Output

In this repository:

- [tasks/006-create-task-writer-skill.md](006-create-task-writer-skill.md) — task definition and actual results.
- [README.md](../README.md) — task 006 navigation.

In the isolated Skillsmith checkout:

- [skills/task-writer/SKILL.md](../../20260525-skillsmith-task-writer/skills/task-writer/SKILL.md) — one self-contained, portable skill.
- [README.md](../../20260525-skillsmith-task-writer/README.md) — one catalog entry and one short usage example.

Acceptance criteria: a clear request produces a useful task immediately; ordinary tasks do not require invented file paths; repository tasks follow local conventions; unknown facts and unfinished work are represented honestly. The skill needs no scripts, external services, or supporting files. Required validation and example review are recorded, with design review distinguished from observed model behavior.

## Rules

Follow [repository conventions](../AGENTS.md), [requirements](../REQS.md), and Skillsmith's linked conventions. Preserve unrelated edits and completed records. Keep the skill independent of this repository and any specific agent.

Use “20% effort, 80% result” as a simplicity principle, not a measured promise. Preserve essential requirements and verification while avoiding speculative scope, mandatory workshops, and unnecessary questions.

No new generators, schemas, CI workflows, architecture documents, or evaluation frameworks. Creating a task does not authorize executing the underlying work. Publishing, installation, and merging are outside this task.

## Implementation

### Agreed plan

1. Create this record and its README link first. Prepare the Skillsmith change on an isolated branch from current main, preserving local edits.
2. Write `task-writer` with valid name/description frontmatter. Trigger it for requests to create a task, write a task brief, or turn an idea into actionable work; do not turn unrelated execution requests into task-writing exercises.
3. Default to a concrete action/outcome title, Goal with purpose and supplied constraints, Input with available information/references/files, Output with deliverables and observable done criteria, and a short unchecked Checklist.
4. Draft directly when clear; ask only about consequential gaps. State assumptions without inventing deadlines, owners, sources, approvals, or completed work. Prefer one useful task, splitting only for independent outcomes. Scale detail to execution needs and follow existing project templates and numbering. Use linked paths for file-based work and concrete non-file deliverables otherwise. Return Markdown in chat unless saving is requested and permitted; honor “show first” and the requested language.
5. Include one small everyday example inside the skill. Add the catalog entry and usage example without changing installer behavior.
6. Validate metadata, review realistic examples, inspect links and diffs, and record actual results.

Acceptance examples to review: “Write a task to plan three vegetarian dinners for two, each under 30 minutes” should yield meals and a shopping-list deliverable without invented paths; “Create the next repository task to improve the fzf guide” should follow this repository's template and numbering; “Turn my launch idea into a task” without context should prompt for what is launching and the intended outcome; “Show a task to rewrite this introduction first” should return a draft without saving it or rewriting the introduction. These are expected outcomes, not observed model results.

### Actual changes

Created the task record and navigation first, then fetched Skillsmith's current main and created the sibling checkout `20260525-skillsmith-task-writer` on branch `feat/task-writer`, based on `fb326f8bdac2a44c2ad5d13f5673123685b69ba9`. Re-read that revision's conventions before editing. The original Skillsmith checkout was left untouched.

Added the single-file skill with the compact default, local-template precedence, consequential-gap clarification, honest progress reporting, language matching, and draft/save/execution boundaries. Included one everyday example and added exactly one catalog row and one usage example to Skillsmith's README. No installer or supporting resources changed. No deviations from the agreed implementation scope.

## Progress checklist

- [x] Create task 006 and link it from the README.
- [x] Write the single-file task-writer skill.
- [x] Add the Skillsmith catalog entry and usage example.
- [x] Validate metadata and review representative behavior.
- [x] Record results, limitations, and delivered paths.

## Result

Acceptance criteria met at the artifact and design-review level. Deliverables are linked above; Skillsmith changes were subsequently committed and submitted for review as recorded below. The cross-repository links require that sibling checkout and are local handoff links, not published artifact URLs.

Verification on 2026-11-13, Ubuntu 24.04.4 LTS on WSL2, Python 3.12.3:

- `python tests/validate_skills.py` in Skillsmith: all 27 skills passed metadata checks.
- Skill-creator's `scripts/quick_validate.py skills/task-writer`: passed, “Skill is valid!”
- `python3 -m unittest discover -s tests -p 'test_*.py' -v`: all 7 tests passed.
- `python3 tests/check_docs.py`: passed, 18 maintained Markdown files and 134 local links/anchors.
- `git diff --check` in both edited repositories and separate whitespace checks of the untracked new Markdown files: passed. Inspected the README diffs and complete new files.
- Separate local-link inspection of this task and the Skillsmith README/skill: passed. No local anchors were added. External URLs were not checked; Skillsmith source documents were read from its fetched checkout.
- Compared pre-task SHA-256 snapshots: original Skillsmith tracked/untracked files, including `skills/start-of-work/`, were preserved; this repository's pre-existing files were preserved except the intended README navigation addition.

Representative examples were reviewed against the instructions and existing repository template. This was author design review, not independent approval or observed model testing:

| Request | Review finding / expected behavior |
| --- | --- |
| Three vegetarian dinners for two, under 30 minutes | Included example has a concrete meal-plan/shopping-list output, time/portion checks, no artificial paths, and unchecked actions. |
| Create the next task to improve the fzf guide | Local instructions and template take precedence; use the next unused number, link actual files such as `docs/tools/fzf.md`, and leave implementation and checks pending. No demonstration task was saved. |
| Turn my launch idea into a task, with no context | Ask what is launching and the intended outcome; do not invent a product, owner, or deadline. |
| Show a task to rewrite this introduction first | Return a Markdown draft; do not save it or rewrite the introduction. |
| Rewrite this introduction directly | Description excludes unrelated execution requests; do not impose task creation. |
| Write a Chinese task brief to research two supplied options | Match the requested language, identify supplied information and comparison deliverables, and leave research/results pending. |

No validation failures or warnings occurred. `git diff --no-index` returned its normal status 1 while displaying a new file; this was not a failed check. Live model execution and cross-host compatibility testing were not performed, so no behavioral reliability or compatibility claim follows from the metadata checks. The initial implementation did not install, publish, commit, push, or merge changes.

On 2026-11-13, the user explicitly requested committing and creating a PR to main. Committed the two Skillsmith files as `a1b4e1db0bf8db3aec478742cdcad6f0cbbb81bb`, pushed `feat/task-writer`, and opened [Skillsmith PR #58](https://github.com/xiongxianfei/skillsmith/pull/58) targeting `main`. Re-fetched main (unchanged at `fb326f8`) and checked staged whitespace before committing. The PR records validation evidence and testing limitations. No merge or installation was performed; this repository's task record and navigation remain local changes.
