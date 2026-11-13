# 007: Refine the task template and skill around seven sections

**Date:** 2026-11-13

## Background

The user selected a seven-section task structure and clarified that “accomplish” means **Approach**: how we intend to perform the work. After reviewing the task draft, the user requested implementation.

The repository template combines planned and actual work under Implementation. The task-writer skill uses a shorter four-section default. Update both to make inputs directly readable, outputs concrete, and planned work distinguishable from execution evidence. Keep sections proportional to the task.

## Input

- [AGENTS.md](../AGENTS.md) — repository task conventions and required checks.
- [REQS.md](../REQS.md) — shared requirements to preserve.
- `tasks/TEMPLATE.md` — existing template to refine.
- [README.md](../README.md) — task navigation to extend.
- [Skillsmith skills/task-writer/SKILL.md](../../20260525-skillsmith-task-writer/skills/task-writer/SKILL.md) — skill instructions and everyday example, starting at commit `a1b4e1d`.
- [Skillsmith README.md](../../20260525-skillsmith-task-writer/README.md) — catalog description and invocation example.
- [Skillsmith quality standard](../../20260525-skillsmith-task-writer/docs/skill-quality-standard.md) — authoring and evidence requirements.
- [Skillsmith workflow](../../20260525-skillsmith-task-writer/docs/workflows.md) — contribution and validation requirements.

Skillsmith's isolated checkout is on `feat/task-writer`, associated with [PR #58](https://github.com/xiongxianfei/skillsmith/pull/58). Preserve existing uncommitted work in this repository and the original Skillsmith checkout. Cross-repository links require the sibling checkout.

## Output

In this repository:

- **Create** [tasks/007-refine-task-template-and-skill.md](007-refine-task-template-and-skill.md) — this task and eventual verification results.
- **Modify** `tasks/TEMPLATE.md` — seven-section template with lifecycle guidance.
- **Modify** [AGENTS.md](../AGENTS.md) — matching conventions for future records.
- **Modify** [README.md](../README.md) — task 007 navigation.

In the isolated Skillsmith checkout:

- **Modify** [skills/task-writer/SKILL.md](../../20260525-skillsmith-task-writer/skills/task-writer/SKILL.md) — seven-section default, concrete input/output guidance, lifecycle rules, and revised everyday example.
- **Modify** [README.md](../../20260525-skillsmith-task-writer/README.md) — describe the revised format in the existing catalog entry.

Acceptance criteria: both defaults use Background, Input, Output, Rules, Approach, Progress checklist, and Execution result, in that order. Inputs identify readable materials or supplied facts; outputs identify deliverables and completion criteria. File outputs specify create/modify/delete, exact paths, and intended changes. Approach describes intended work; Execution result records actual work and evidence. New tasks have unchecked actions and a pending result; completion requires acceptance criteria to be met and results recorded. Required checks pass, with review evidence and limitations documented.

## Rules

Follow [repository conventions](../AGENTS.md), [requirements](../REQS.md), and Skillsmith's linked guidance. Preserve unrelated edits and completed records 001–006; apply the new format prospectively.

Keep the skill self-contained and independent of this repository. Existing project templates take precedence over its default. Everyday tasks need no artificial file paths. Retain direct drafting, consequential-gap clarification, language matching, and show-first behavior. Task creation alone does not authorize executing its underlying work.

No new scripts, schemas, dependencies, validation frameworks, installation, or merging.

## Approach

1. Save this record and its navigation link first. Continue Skillsmith work in the isolated checkout.
2. Replace Implementation with Approach and Result with Execution result in the template and conventions. Remove the separate Actual changes subsection; record actual changes and deviations with execution results. Explain section purposes without repeating the approach in the checklist.
3. Require specific readable inputs with purpose, short supplied facts inline, and honest missing/inaccessible input descriptions. Use exact action/path/change descriptions for file outputs and concrete non-file deliverables otherwise. Keep acceptance criteria under Output.
4. Before execution, record intended work, unchecked actions, and a pending result. During execution, update completed actions and blockers. At completion or handoff, record artifacts, actual checks, deviations, failures, skips, and outstanding work; leave unfinished items unchecked.
5. Apply the seven-section default to the skill and its dinner-planning example. Keep sections brief and never invent constraints to fill Rules. Update the existing catalog description.
6. Run this repository's unit tests, documentation checker, and whitespace check; Skillsmith's metadata validator, skill-creator validator, and whitespace check. Inspect task links separately, review diffs and preserved edits, and review everyday, file-changing, missing-input, show-first, blocked, and completed-task scenarios. Distinguish design review from observed model testing.

## Progress checklist

- [x] Save task 007 and add its README link.
- [x] Align the repository template and task conventions.
- [x] Refine the skill, everyday example, and catalog description.
- [x] Review concrete inputs, outputs, and lifecycle scenarios.
- [x] Run required checks and inspect links, diffs, and preserved edits.
- [x] Record actual outcomes and remaining limitations.

## Execution result

Implemented the agreed changes in all six listed output files. The template, conventions, and skill now use the seven sections in order; the skill's everyday example demonstrates the same format. Actual changes and deviations belong in Execution result, while Approach contains intended work. No implementation deviations.

Acceptance criteria met at the artifact and design-review level. Validation on 2026-11-13 using Ubuntu 24.04.4 LTS on WSL2 and Python 3.12.3:

- `python3 -m unittest discover -s tests -p 'test_*.py' -v`: all 7 tests passed.
- `python3 tests/check_docs.py`: passed, 18 maintained Markdown files and 135 local links/anchors.
- Skillsmith `python tests/validate_skills.py`: all 27 skills passed metadata checks.
- Skill-creator `scripts/quick_validate.py skills/task-writer`: passed, “Skill is valid!”
- `git diff --check` in both edited repositories: passed. Separately inspected whitespace and local links in task 007 (16), the template (4), Skillsmith README (33), and skill (0); all passed.
- Compared pre-task snapshots and reviewed task-specific diffs: only the planned files changed. Completed records 001–006, all other pre-existing edits, and the original Skillsmith checkout were preserved.

Author design review, not observed model testing or independent approval:

| Scenario | Review finding / expected behavior |
| --- | --- |
| Everyday dinner-planning request | Revised example has all seven sections, supplied facts inline, concrete meals/shopping-list deliverables, unchecked actions, and a pending result; no invented paths. |
| Create a guide and modify navigation | Output instructions require create/modify actions, exact paths, intended changes, and acceptance criteria; task 007 itself demonstrates file outputs and readable inputs. |
| Missing or inaccessible source | Instructions require identifying the missing input and whether it blocks progress; no claim to have read it. |
| Show the task first | Existing draft-first instruction remains; task creation alone does not authorize implementation or saving. |
| Blocked task | Annotate the blocked action with what is needed next, leave unfinished items unchecked, and record outstanding work at handoff. |
| Completed task | Record actual artifacts and verification evidence, account for deviations and skips, and claim completion only when acceptance criteria are met. |

No check failures or warnings occurred. External URLs and live model/cross-host behavior were not tested; metadata checks do not establish behavioral reliability. No platform installation was performed. Changes remain local and uncommitted; PR #58 has not been updated by this task. No installation or merging occurred.
