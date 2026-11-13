# 008: Refine task-writer and Skillsmith authoring guidance

**Date:** 2026-11-13

## Background

The user requested refining task-writer and Skillsmith's rules according to official OpenAI and Anthropic guidance, committing the related changes, and submitting them to main. The user selected updating existing PR #58 and then requested implementation of this task's draft.

Task 007's seven-section skill refinements remain uncommitted. Include them while removing repetition and applying progressive disclosure. Preserve the agreed task format and lifecycle behavior.

## Input

- [tasks/007-refine-task-template-and-skill.md](007-refine-task-template-and-skill.md) — agreed behavior and previous verification.
- [AGENTS.md](../AGENTS.md), [REQS.md](../REQS.md), and `tasks/TEMPLATE.md` — local conventions and requirements.
- [Skillsmith skills/task-writer/SKILL.md](../../20260525-skillsmith-task-writer/skills/task-writer/SKILL.md) — skill including task 007's uncommitted changes, on top of `a1b4e1d`.
- [Skillsmith AGENTS.md](../../20260525-skillsmith-task-writer/AGENTS.md) — agent instructions and principles.
- [Skillsmith quality standard](../../20260525-skillsmith-task-writer/docs/skill-quality-standard.md) — authoring, portability, and evidence guidance.
- [Skillsmith workflow](../../20260525-skillsmith-task-writer/docs/workflows.md) — validation and PR procedures.
- [Skillsmith README.md](../../20260525-skillsmith-task-writer/README.md) — catalog and usage example.
- [Skillsmith validator](../../20260525-skillsmith-task-writer/tests/validate_skills.py) — metadata checks to retain unchanged.
- [PR #58](https://github.com/xiongxianfei/skillsmith/pull/58) — existing submission from `feat/task-writer` to `main`.
- [OpenAI: Build skills](https://developers.openai.com/plugins/build/skills) — workflow boundaries, resources, and activation testing.
- [OpenAI: Rethinking skills and prompts](https://developers.openai.com/blog/rethinking-skills-and-prompts-for-gpt-6-astra) — focused descriptions and progressive disclosure.
- [Anthropic: Skill authoring best practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices) — specificity, conditional references, examples, and evaluation-driven iteration.

Official sources were reviewed on 2026-11-13. Cross-repository links require the sibling Skillsmith checkout.

## Output

In this repository:

- **Create** [tasks/008-refine-skillsmith-authoring-and-task-writer.md](008-refine-skillsmith-authoring-and-task-writer.md) — definition, results, commits, and PR link.
- **Modify** [README.md](../README.md) — task 008 navigation.

In the isolated Skillsmith checkout:

- **Modify** [skills/task-writer/SKILL.md](../../20260525-skillsmith-task-writer/skills/task-writer/SKILL.md) — concise core and conditional reference loading.
- **Create** [skills/task-writer/references/everyday-example.md](../../20260525-skillsmith-task-writer/skills/task-writer/references/everyday-example.md) — move the existing everyday example into a reference.
- **Modify** [docs/skill-quality-standard.md](../../20260525-skillsmith-task-writer/docs/skill-quality-standard.md) — sourced authoring guidance with requirements, recommendations, and evidence distinguished.
- **Modify** [docs/workflows.md](../../20260525-skillsmith-task-writer/docs/workflows.md) — proportionate evaluation and reference-loading review.
- **Modify** [AGENTS.md](../../20260525-skillsmith-task-writer/AGENTS.md) — concise guidance aligned with the owning documents.
- **Modify** [README.md](../../20260525-skillsmith-task-writer/README.md) — include the pending seven-section catalog update.
- **Update PR #58** — publish scoped commits and replace its title/body with the complete scope and evidence.

Acceptance criteria: preserve all seven sections, lifecycle rules, concrete inputs/outputs, local-template precedence, and draft/execution boundaries. Keep essential instructions in SKILL.md and load the everyday example only for everyday tasks with non-file deliverables or an explicit request for that example. Describe portability at directory level and choose references by conditional need. Attribute vendor recommendations without turning them into universal requirements. Required checks pass, related changes are committed and pushed, and PR #58 targets main with the final scope.

## Rules

Follow the linked repository conventions and requirements. Preserve unrelated edits and completed task records. Include task 007's pending Skillsmith changes; keep this repository's records and navigation local.

The earlier single-file restriction is superseded; the complete skill directory remains self-contained. Do not impose task-writer's seven-section format on other skills. Do not rewrite other skills, installer behavior, architecture documents, validation code, or CI. Preserve metadata and safety requirements. Treat vendor line-count and evaluation examples as guidance rather than new automated gates. No mandatory cross-vendor test matrix or evaluation framework. Commit and push as requested; do not merge, install, or release.

## Approach

1. Save this task and navigation first, snapshot existing changes, and continue in the isolated `feat/task-writer` checkout.
2. Consolidate repeated skill instructions, preserve core behavior, and move the dinner example into the named reference with an explicit loading condition. Add no asset or executable helper.
3. Refine the quality standard around focused descriptions, useful model context, explicit inputs/outputs, specificity proportional to risk, and progressive disclosure based on relevance. Explain self-contained directories, shallow references, and explicit loading conditions. Cite official sources and link from the other owning documents rather than duplicating guidance.
4. Recommend representative failures and expected outcomes before extensive prompt writing. Distinguish metadata validation, author scenario review, and observed model testing. Preserve the lightweight automated checks and require evidence for behavioral claims.
5. Run Skillsmith's metadata and skill-creator validators; local unit tests and documentation checker; whitespace, link, preservation, and full-diff inspection. Review everyday, repository, missing-input, show-first, direct-execution, blocked, and completed scenarios as design evidence. Cross-host testing is outside scope.
6. Make two scoped Skillsmith commits: authoring rules, then skill refinements including task 007's changes. Push the branch and update PR #58 to “feat: add task-writer and align skill authoring guidance.” Replace its obsolete single-file/four-section description. Inspect CI and resolve failures caused by this change before handoff.

## Progress checklist

- [x] Save task 008 and navigation; preserve existing edits and confirm the branch.
- [x] Refine task-writer and extract its conditional example.
- [x] Align rules with attributed official guidance.
- [x] Run checks and review representative scenarios.
- [x] Commit and push related Skillsmith changes.
- [x] Update PR #58 and inspect CI.
- [x] Record artifacts, commits, evidence, and limitations.

## Execution result

Completed the agreed scope without deviations. The skill now preserves its seven-section contract in an 82-line entrypoint and places the existing worked example in a directly linked reference with explicit loading conditions. Shared rules cite OpenAI and Anthropic, distinguish directory portability from single-file packaging, and separate metadata checks, design review, and observed model evidence. Task 007's pending Skillsmith changes are included. Other skills, installer, metadata validator, CI, and architecture documents are unchanged.

Published two scoped commits on `feat/task-writer`:

- `f88b4fc` — authoring guidance and workflow alignment.
- `8abab9843e3318e05e266a2cd612fbb2a39478a4` — task-writer lifecycle and progressive disclosure.

Updated [PR #58](https://github.com/xiongxianfei/skillsmith/pull/58) targeting `main`, including its title, complete scope, distribution note, evidence, and limitations. The PR contains exactly the six planned Skillsmith files. GitHub Actions [Validate Skills run 43432712550](https://github.com/xiongxianfei/skillsmith/actions/runs/43432712550) completed successfully for the latest commit. The isolated Skillsmith working tree is clean. This task record and local navigation remain uncommitted as planned.

Verification on 2026-11-13, Ubuntu 24.04.4 LTS on WSL2, Python 3.12.3:

- `python tests/validate_skills.py`: all 27 skills passed metadata checks.
- Skill-creator `scripts/quick_validate.py skills/task-writer`: passed.
- `python3 -m unittest discover -s tests -p 'test_*.py' -v`: all 7 tests passed.
- `python3 tests/check_docs.py`: passed, 18 maintained Markdown files and 136 local links/anchors.
- `git diff --check` in both repositories, staged whitespace checks, and the final PR diff whitespace check: passed.
- Separate local-link/anchor and whitespace inspection across the six Skillsmith files and this task: passed (72 local links before converting the planned example path to a delivered link; final task links checked again afterward).
- Snapshot comparison confirmed unrelated files and completed tasks were preserved, including all original Skillsmith checkout changes. Reviewed the complete changed content and final PR file list.

Author design review, not observed model testing or independent approval:

| Scenario | Expected behavior checked against the final instructions |
| --- | --- |
| Everyday dinner task | Read the example, use concrete non-file deliverables, keep seven sections and a pending result; do not transfer meal constraints to unrelated tasks. |
| Repository guide task | Follow local template/numbering and exact file actions; skip the everyday example unless explicitly requested. |
| Missing input | Identify the missing or inaccessible material and whether it blocks progress; clarify consequential gaps without inventing facts. |
| Show the task first | Return the draft before saving or executing. |
| Direct execution request | Do not impose a task-writing exercise. |
| Blocked task | Leave unfinished items unchecked, annotate the next needed step, and report outstanding work at handoff. |
| Completed task | Require acceptance criteria and evidence-backed results before claiming completion. |

Acceptance criteria met. No check failures or warnings occurred. Actual reference-loading behavior, live model quality, and cross-host compatibility were not tested; metadata validation and design review do not establish those claims. No merge, installation, or release was performed.
