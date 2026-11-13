# 004: Use file-based task inputs/outputs and a JSON tool index

**Date:** 2026-11-13

## Background

The user requested implementation of the Task 004 plan: make task inputs and outputs identify concrete files, and maintain the existing five-tool summary in JSON with a generated Markdown table. This makes task scope reviewable and provides an editable structured summary while preserving the readable guides and safety guidance.

## Input

Source files were read at commit `6b2e07808741d5704f4285c67973dccc421c788c`:

- [AGENTS.md](../AGENTS.md) — editing rules, task conventions, and required checks.
- [REQS.md](../REQS.md) — requirements for tool summaries and platform coverage.
- [README.md](../README.md) — topic navigation to extend.
- `tasks/TEMPLATE.md` — starting task format.
- [tasks/001-tmux-uv-terminal-block-guides.md](001-tmux-uv-terminal-block-guides.md), [tasks/002-official-links-and-tool-recommendations.md](002-official-links-and-tool-recommendations.md), and [tasks/003-standardize-task-records.md](003-standardize-task-records.md) — completed records to preserve.
- [docs/tools/README.md](../docs/tools/README.md) — original five rows, commands, links, and surrounding guidance.
- [docs/tools/neovim.md](../docs/tools/neovim.md), [docs/tools/tmux.md](../docs/tools/tmux.md), [docs/tools/uv.md](../docs/tools/uv.md), [docs/tools/zoxide.md](../docs/tools/zoxide.md), and [docs/tools/fzf.md](../docs/tools/fzf.md) — detailed procedures for comparison with summary commands.
- [.github/workflows/docs.yml](../.github/workflows/docs.yml) — existing documentation CI.
- [tests/check_docs.py](../tests/check_docs.py) and [tests/test_check_docs.py](../tests/test_check_docs.py) — existing documentation checks and test conventions.

## Output

- [AGENTS.md](../AGENTS.md) — file-based task conventions and generator maintenance/check commands.
- `tasks/TEMPLATE.md` — file lists for Input and Output, with acceptance criteria below Output.
- [tasks/004-file-paths-and-json-tool-index.md](004-file-paths-and-json-tool-index.md) — plan, progress, and observed results.
- [README.md](../README.md) — link to task 004.
- [REQS.md](../REQS.md) — generated-summary requirement.
- [docs/tools/tools.json](../docs/tools/tools.json) — five existing tool records and literal installation commands.
- [docs/tools/README.md](../docs/tools/README.md) — marked generated table and maintenance workflow.
- [scripts/render_tool_index.py](../scripts/render_tool_index.py) — validating standard-library generator and read-only `--check` mode.
- [tests/test_render_tool_index.py](../tests/test_render_tool_index.py) — generator regression tests.
- [.github/workflows/docs.yml](../.github/workflows/docs.yml) — generated-table freshness check.

Acceptance criteria: preserve the five rows, column order, links, platform coverage, commands, and surrounding guidance. Validate schema, unique names, guide files, and markers before writing. Render literal commands safely and `null` as `—`; detect stale output without writes. Regeneration preserves surrounding prose and is idempotent. Required tests and checks pass; task/template links resolve, records 001–003 are unchanged, and all five guides are compared with summary commands. Record actual verification and skips below.

## Rules

Follow [AGENTS.md](../AGENTS.md) and [REQS.md](../REQS.md). Apply file-based task conventions to future records only; preserve completed records 001–003. No new tools, installation methods, external dependencies, runtime configuration changes, or execution of stored commands. Individual guides remain the source for detailed instructions. Retain existing safety guidance and official links without claiming new platform verification.

## Implementation

### Agreed plan

1. Update task conventions and the template; create and link this record.
2. Transfer the five rows into JSON and implement validation and table generation between explicit markers.
3. Add generator regression tests, maintenance documentation, requirements, and the CI freshness check.
4. Run required checks, inspect task/template links and the diff, compare commands with all five guides, verify preservation/idempotence, and record evidence.

### Actual changes

- Updated the task conventions and template so Background identifies the user request, Input lists source files, and Output lists files to create or modify followed by acceptance criteria. Linked this record from the root README; completed records remain unchanged.
- Transferred the original five-tool table into `docs/tools/tools.json`, retaining row order, recommendations, commands, coverage, and official links. Added explicit generated-table markers without changing the original table or surrounding prose.
- Added the standard-library generator with schema, unique-name, existing-guide-path, and marker validation before writes. It escapes Markdown text and literal shell commands, preserves surrounding bytes and line endings, avoids unnecessary writes, and provides read-only stale detection with `--check`.
- Added 15 generator tests alongside the seven existing checker tests. Documented the JSON/regenerate/review workflow, updated requirements and maintenance checks, and added CI freshness validation.
- No scope deviations. Original guide procedures and reusable configurations were not changed.

## Progress checklist

- [x] Create task 004 with concrete input/output files and the agreed plan.
- [x] Update task conventions, template, requirements, and README navigation.
- [x] Add JSON records, the validating generator, table markers, maintenance workflow, and CI freshness check.
- [x] Add and run generator tests for valid data, escaping, validation failures, markers, determinism, and read-only stale detection.
- [x] Compare installation commands with all five guides.
- [x] Verify regeneration preserves surrounding prose and a second run changes nothing.
- [x] Run required checks and inspect task/template links separately.
- [x] Confirm records 001–003 are unchanged and inspect the diff.
- [x] Record actual results and remaining limitations.

## Result

Delivered all Output files and met the acceptance criteria. The summary has five tools, ten installation commands, and five uncovered-platform cells. All existing table contents and original surrounding guidance are preserved; the new maintenance section is appended after that guidance.

Verification on 2026-11-13, using Ubuntu 24.04.4 LTS on WSL2 and Python 3.12.3:

| Check | Result |
| --- | --- |
| `python3 -m unittest discover -s tests -p 'test_*.py' -v` | Passed: 22 tests (7 existing, 15 generator tests). Includes current coverage, null cells, shell quoting/pipes/backticks, prose/link escaping, invalid records, missing guide files, marker failures, deterministic output, LF/CRLF preservation, CLI exit codes, and read-only stale detection. |
| `python3 tests/check_docs.py` | Passed: 19 maintained Markdown files and 141 local links/anchors. |
| `python3 scripts/render_tool_index.py --check` | Passed: validated JSON and a fresh table; no writes. |
| Regeneration and preservation | Two default generator runs left all README bytes unchanged; the second also left its modification time unchanged. Generated table exactly equals the original committed table. Removing the added markers and maintenance section recovers all original README text. Fixture tests also verify that replacing stale content preserves surrounding prose. |
| Separate task/template links and structure | Passed: 56 local links/anchors across 5 task/template files. Template and task 004 use the seven sections in order. |
| Completed records and other preserved files | Records 001–003 match their committed contents byte for byte. Git diff confirms no changes to the five individual guides or reusable configurations. |
| `git diff --check` and diff inspection | Passed; also checked new files for trailing whitespace. Changes are limited to the listed outputs. |

Command comparison with the guides (text inspection only; no commands executed):

| Tool | Result |
| --- | --- |
| Neovim | Windows command matches exactly. Ubuntu summary combines the guide's two APT commands with `&&`. macOS remains uncovered. |
| tmux | Ubuntu/WSL command matches exactly; Windows and macOS remain uncovered. |
| uv | Both Windows and Ubuntu commands match exactly, with literal pipes in JSON. macOS remains uncovered. |
| zoxide | Both Windows and Ubuntu commands match exactly. macOS remains uncovered. |
| fzf | Windows and macOS commands match exactly. Ubuntu summary retains the existing tilde paths for the same clone destination and installer that the guide expresses with quoted `$HOME` paths. |

An initial test failed because its expected Markdown omitted the padding required around a command ending in backticks. Corrected the expectation; the full suite then passed. An initial broad byte comparison against Git blobs flagged the Neovim guide's existing CRLF checkout versus LF in Git; `git ls-files --eol` confirmed this distinction, and Git diff verified the guides/configurations are unchanged. Records 001–003 passed the byte comparison directly.

No tool installation, shell configuration, or real Windows/macOS/Ubuntu setup checks were run: this task changes the documentation workflow only. Python 3.10 was not separately exercised; the observed runtime was 3.12.3. External URLs were preserved but not revalidated. CI configuration was inspected and its commands passed locally; hosted CI has not been run here. Command alignment remains a maintenance review responsibility, not an automated generator check. No remaining task work or blockers.
