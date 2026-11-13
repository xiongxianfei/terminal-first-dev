# 005: Keep the tool index in JSON only

**Date:** 2026-11-13

## Background

The user requested keeping JSON as the tool summary and removing Markdown generation. They confirmed deletion of the entire tool README, reviewed this task's draft, and requested implementation.

## Input

- [docs/tools/tools.json](../docs/tools/tools.json) — five-tool summary to preserve.
- `docs/tools/README.md`, `scripts/render_tool_index.py`, and `tests/test_render_tool_index.py` — summary page and generation tooling to remove.
- [README.md](../README.md) — navigation and destination for retained guidance.
- [REQS.md](../REQS.md) and [AGENTS.md](../AGENTS.md) — requirements and conventions to simplify.
- [.github/workflows/docs.yml](../.github/workflows/docs.yml) — generation check to remove.
- `tasks/TEMPLATE.md` and [tasks/004-file-paths-and-json-tool-index.md](004-file-paths-and-json-tool-index.md) — task format and prior work.

The starting working tree includes task 004's uncommitted changes. Paths scheduled for removal are recorded as code so this record will not introduce broken links.

## Output

- [tasks/005-json-only-tool-index.md](005-json-only-tool-index.md) — task plan and verification results.
- [README.md](../README.md) — direct JSON/guide links, retained safety guidance, and task navigation.
- [REQS.md](../REQS.md) — JSON-only summary requirement.
- [AGENTS.md](../AGENTS.md) — direct JSON maintenance without generation checks.
- [.github/workflows/docs.yml](../.github/workflows/docs.yml) — remove freshness validation and rename the test step.
- `docs/tools/README.md`, `scripts/render_tool_index.py`, and `tests/test_render_tool_index.py` — delete.

Acceptance criteria: JSON remains unchanged as the sole tool summary. Generation tooling and its CI step are removed. Current documentation links resolve, required checks pass, and guides, configurations, and completed records remain unchanged.

## Rules

Follow [AGENTS.md](../AGENTS.md) and [REQS.md](../REQS.md), updating requirements for this request. Preserve individual guides, configurations, the template, and records 001–004. No replacement generators, validators, dependencies, or CI machinery. Do not execute installation commands. Preserve historical records even where their links refer to removed artifacts; report those links separately.

## Implementation

### Agreed plan

1. Create this record first.
2. Link JSON and all five guides from the root README; retain coverage explanations and installation cautions there.
3. Delete the tool README, generator, and generator tests; simplify requirements, maintenance instructions, and CI.
4. Run unit tests, documentation checks, JSON parsing, and whitespace checks. Inspect task links separately and compare preserved files with pre-task hashes.

### Actual changes

Removed the tool README, generator, and generator tests. The root README now links directly to JSON and all five guides and retains installation cautions, coverage explanations, and setup links. Requirements and conventions describe direct JSON maintenance; CI retains documentation checks only. No deviations from the agreed plan.

## Progress checklist

- [x] Create task 005.
- [x] Update navigation, guidance, requirements, and CI; remove generation artifacts.
- [x] Run checks and inspect links and preserved files.
- [x] Record outcomes and limitations.

## Result

Acceptance criteria met. Verification on 2026-11-13 using Ubuntu 24.04.4 LTS on WSL2 and Python 3.12.3:

- Unit tests: all 7 remaining documentation-checker tests passed.
- Documentation checker: passed, 18 maintained Markdown files and 133 local links/anchors.
- `python3 -m json.tool docs/tools/tools.json`: passed.
- `git diff --check`: passed; diff reviewed.
- Pre-task SHA-256 comparisons: JSON, all five guides, reusable configurations, and records 001–004 unchanged.
- Search of current documentation, tests, and CI: no obsolete generator references or links to the deleted tool README.
- Separate task/template review: 70 links across 6 files; 7 expected historical broken links, all in preserved records. Task 001 has one and task 002 has two references to the deleted tool README. Task 004 has two references to that README and one each to the deleted generator and generator tests. All other task/template links resolve, including this record's links.

The JSON schema and all five records remain unchanged. The task template remains unchanged from the start of this task. No replacement automation was added. Hosted CI, external URLs, and platform installation behavior were not tested; the CI commands passed locally. Historical references above remain as records of prior work. No remaining implementation work.
