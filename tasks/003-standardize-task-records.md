# 003: Standardize task records

**Date:** 2026-11-13

## Background

Task records need to explain why work matters, which sources inform it, what should be delivered, and what actually happened. The existing format does not explicitly separate all of these. A single status label also hides which actions remain; a progress checklist makes completion visible per action.

## Input

- User discussion in this conversation: use Background, Input, Output, Rules, Implementation, Progress checklist, and Result; replace the proposed top-level status with actionable checkboxes.
- User-selected scope: apply the format to future tasks only and leave completed records unchanged.
- Existing [task conventions](../AGENTS.md#task-records) and records [001](001-tmux-uv-terminal-block-guides.md) and [002](002-official-links-and-tool-recommendations.md), as present at commit `21ee27b`.

## Output

- Updated task-writing conventions and a reusable template.
- This task as the first example of the new format, linked from the root [topic index](../README.md#topics).
- Acceptance criteria: conventions, template, and task 003 use the seven agreed sections in order, track progress with concrete checkboxes, and distinguish expected outputs from actual results. Tasks 001 and 002 remain unchanged, required documentation checks pass, and task/template links resolve.

## Rules

Follow [repository conventions](../AGENTS.md) and [requirements](../REQS.md). Apply the format to future tasks; preserve completed records and sequential numbering. The template is not a numbered task. Keep the date near the top and use the progress checklist instead of a status field. Record only observed results and identify skips. This task changes documentation only; tool instructions, reusable configurations, checker behavior, and public APIs are outside scope.

## Implementation

### Agreed plan

1. Define the seven sections and checklist behavior in the task-writing conventions.
2. Create the template and use it for task 003, keeping the agreed approach separate from actual changes.
3. Link the task and template from the README.
4. Run required checks, inspect task/template links separately, confirm existing records are unchanged, and record results.

### Actual changes

- Updated [AGENTS.md](../AGENTS.md#task-records) with section definitions, template usage, progress tracking, and evidence requirements.
- Added the template and this record with the agreed structure and no top-level status field.
- Added task 003 and the template to the root [topic index](../README.md#topics).
- No deviations from the agreed plan.

## Progress checklist

- [x] Create task 003 with its inputs, outputs, and agreed plan.
- [x] Create the reusable task template.
- [x] Apply the template structure to task 003.
- [x] Update task-writing rules in AGENTS.md.
- [x] Add task and template links to README.md.
- [x] Run required checks and separately inspect task/template links.
- [x] Confirm tasks 001 and 002 are unchanged and inspect the diff.
- [x] Record actual results and remaining limitations.

## Result

Delivered the updated conventions, reusable template, and task 003 example with README navigation. Acceptance criteria are met: all seven sections are defined and used, progress is tracked per action, expected deliverables are separate from observed results, and tasks 001 and 002 remain unchanged.

Verification on 2026-11-13, using Ubuntu 24.04.4 LTS on WSL2 and Python 3.12.3:

| Check | Result |
| --- | --- |
| `python3 -m unittest discover -s tests -p 'test_*.py' -v` | Passed: 7 tests. |
| `python3 tests/check_docs.py` | Passed: 19 maintained Markdown files and 136 local links/anchors. |
| Separate task/template link check | Passed: 26 local links/anchors across all task records and the template. |
| Structure review | Template and task 003 contain the seven sections in order, with no top-level status field. |
| Preservation check | Tasks 001 and 002 match their committed contents byte for byte. |
| Whitespace and diff review | `git diff --check` passed; new files have no trailing whitespace. Changes are limited to conventions, README navigation, the template, and task 003. |

No tool installation or platform runtime checks were performed because this task changes the documentation workflow only. No external URLs were added or revalidated. The repository checker still excludes task contents; their links were checked separately. No remaining task work or blockers.
