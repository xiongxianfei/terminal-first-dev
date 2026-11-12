---
id: 2026-06-15-how-to-guide-template-best-practices-spec-review
spec: specs/how-to-guide-template-best-practices.md
review_status: approved
created: 2026-06-15
repo: xiongxianfei/terminal-first-windows-dev
---

# Spec Review: How-To Guide Template Best Practices

## Result

- Skill: spec-review
- Review status: approved
- Material findings: none
- Recording status: recorded
- Recording blocker: none
- Review record: `docs/changes/2026-06-15-how-to-guide-template-best-practices/reviews/spec-review.md`
- Review log: `docs/changes/2026-06-15-how-to-guide-template-best-practices/reviews/spec-review.md`
- Review resolution: `docs/changes/2026-06-15-how-to-guide-template-best-practices/reviews/spec-review-resolution.md`
- Open blockers: none
- Immediate next stage: plan
- Eventual test-spec readiness: ready
- Stop condition: none

Latest review round: 2026-06-15 second pass.

The spec is approved for planning. HGT-SR-001 is addressed by the spec revision and review-resolution record. Before downstream plan, test-spec, or implementation relies on the spec, normalize `specs/how-to-guide-template-best-practices.md` status from `draft` to `approved`.

## Review Log

| Round | Date | Status | Findings | Notes |
| --- | --- | --- | --- | --- |
| 1 | 2026-06-15 | changes-requested | HGT-SR-001 | Backup guidance was not testable for published file-editing guides. |
| 2 | 2026-06-15 | approved | none | HGT-SR-001 resolved; spec is ready for planning after status normalization. |

## Prior Finding Resolution

| Finding ID | Disposition | Evidence |
| --- | --- | --- |
| HGT-SR-001 | addressed | The spec now defines backup guidance, revises R18, adds R35a, adds boundary behavior for missing or late backup guidance, updates AC2, AC9, and AC10, and records the disposition in `docs/changes/2026-06-15-how-to-guide-template-best-practices/reviews/spec-review-resolution.md`. The proxy exemplar fast path now includes backup guidance before editing `%UserProfile%\.wslconfig`. |

## Second-Pass Review Dimensions

| Review dimension | Verdict | Notes |
| --- | --- | --- |
| requirement clarity | pass | Requirements now define template, published-guide, pilot, and validation contracts clearly, including backup guidance for file edits and hard-to-undo state changes. |
| normative language | pass | MUST and SHOULD statements are testable through static checks, review evidence, or manually verifiable guide conformance. |
| completeness | pass | Normal, boundary, migration, validation, rollback, backup, troubleshooting, security, and no-command-execution paths are covered. |
| testability | pass | Requirements map to static checks for template structure, command context, links, anchors, backup placement, pilot evidence, and absence of command execution. |
| examples | pass | Examples cover template copy, fast path, walkthrough, state-changing recovery, troubleshooting separation, and portability validation. |
| compatibility | pass | The spec extends the existing two-speed structure spec, preserves current guide paths, and avoids setup command semantic changes. |
| observability | pass | Structure checks, link checks, review checklists, exemplar review, portability pilot evidence, backup coverage, and completion notes are observable. |
| security/privacy | pass | The spec excludes secrets, credentials, private hostnames, private certificate material, telemetry, and hidden command execution; sensitive command impacts remain visible. |
| non-goals | pass | Non-goals preserve scope around broad guide rewrites, command contracts, generated tooling, command-execution CI, hidden automation, and tutorials. |
| acceptance criteria | pass | Acceptance criteria now cover template structure, backup safety modules, pilots, validation boundaries, security-sensitive examples, and upstream status settlement. |

## Approved Review Recommendation

- Normalize spec status from `draft` to `approved` before downstream artifacts rely on it.
- Proceed to planning next. No architecture gate is required first because this spec changes documentation structure and validation expectations, not scripts, generated files, data flow, or machine-changing automation.
- Carry the backup guidance checks into `specs/how-to-guide-template-best-practices.test.md`.

## Findings

None in the latest review round.

## Original Finding HGT-SR-001

- Finding ID: HGT-SR-001
- Severity: major
- Location: `specs/how-to-guide-template-best-practices.md` R18, R35, Error and boundary behavior, AC2, AC9-AC10
- Evidence: The accepted proposal treats backup as part of the conditional safety module for state-changing or environment-sensitive guides: it calls for "backup guidance before editing user-owned or system-owned files" and says state-changing guides should expose "scope, safety, backup, and rollback information early." The spec captures backup in examples and glossary, and R18 requires the template to show optional step-level `Backup`, but published guide conformance only requires "scope and rollback guidance" in R35. The boundary behavior rejects missing rollback but does not reject missing backup where a guide edits user-owned or system-owned files. The acceptance criteria do not require backup coverage for the template, published guides, or pilot evidence.
- Required outcome: The spec must make backup guidance testable for the cases where the proposal requires it: at minimum, guides that edit user-owned or system-owned files must include backup guidance before the edit, or must explicitly state why backup is not applicable.
- Safe resolution path: Add or revise requirements so published guide conformance includes backup guidance for file-editing or hard-to-undo state changes. Add matching boundary behavior for missing backup guidance, and add acceptance criteria or pilot evidence fields that make backup coverage observable. A narrow safe wording would be: "A published guide that edits user-owned or system-owned files MUST include backup guidance before the edit or explicitly state why backup is not applicable." Then update AC2, AC9, or AC10 to cover backup checks.
- needs-decision rationale: none

## Review Dimensions

| Review dimension | Verdict | Notes |
| --- | --- | --- |
| requirement clarity | concern | Most requirements are clear and testable. HGT-SR-001 leaves backup obligations ambiguous for published guides. |
| normative language | concern | The spec uses testable MUST language overall, but backup appears as optional template content while the proposal requires backup guidance for relevant file edits. |
| completeness | concern | Normal, boundary, migration, validation, security, and pilot behavior are covered; backup conformance is the missing safety module. |
| testability | concern | Structure, link, anchor, pilot, and validation boundaries are testable. Backup cannot be reliably tested because no published-guide requirement or acceptance criterion requires it. |
| examples | pass | Examples cover template copy, fast path, walkthrough, recovery, troubleshooting separation, and portability validation. |
| compatibility | pass | The spec extends the earlier two-speed structure spec, preserves existing numbered guide paths, and avoids setup command semantic changes. |
| observability | concern | Review evidence fields are good, but backup is absent from required pilot evidence and acceptance checks. |
| security/privacy | pass | Secrets, proxy credentials, private hostnames, private certificate material, and sensitive command impacts are covered. |
| non-goals | pass | Non-goals preserve scope around broad guide rewrites, command contracts, generated docs, command execution CI, hidden automation, and tutorials. |
| acceptance criteria | concern | Acceptance criteria are mostly observable but do not cover backup guidance despite the proposal making it part of conditional safety modules. |

## Exact Wording Suggestions

Add a requirement after R35:

```text
R35a. A published guide that edits user-owned or system-owned files MUST include backup guidance before the edit or explicitly state why backup is not applicable.
```

Add boundary behavior:

```text
- If a guide edits user-owned or system-owned files without backup guidance or an explicit not-applicable statement, review MUST treat the guide as non-conformant.
```

Add acceptance coverage:

```text
AC15. Template, exemplar, portability pilot, or documented review checks cover backup guidance for user-owned or system-owned file edits.
```

Renumbering is optional; stable IDs can use the next available requirement and acceptance numbers if preferred.

## Eventual test-spec readiness

Ready.

The test spec can map requirements to static checks for template structure, guide metadata, command context, expected results, troubleshooting links and anchors, no command execution, exemplar review, portability pilot evidence, and conditional backup, safety, and rollback coverage.

## Stop condition

None. No automatic downstream handoff occurs from this review.
