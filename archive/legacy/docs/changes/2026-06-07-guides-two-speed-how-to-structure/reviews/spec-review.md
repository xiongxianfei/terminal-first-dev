---
id: 2026-06-07-guides-two-speed-how-to-structure-spec-review
spec: specs/guides-two-speed-how-to-structure.md
review_status: approved
created: 2026-06-07
repo: xiongxianfei/terminal-first-windows-dev
---

# Spec Review: Two-Speed How-To Guide Structure

## Result

- Skill: spec-review
- Review status: approved
- Material findings: none
- Recording status: recorded
- Recording blocker: none
- Review record: `docs/changes/2026-06-07-guides-two-speed-how-to-structure/reviews/spec-review.md`
- Review log: `docs/changes/2026-06-07-guides-two-speed-how-to-structure/review-log.md`
- Review resolution: not-required
- Open blockers: none
- Immediate next stage: plan
- Eventual test-spec readiness: ready
- Stop condition: none

`Immediate next stage` is the routing field; allowed values exclude `test-spec`.
Use `Eventual test-spec readiness` to assess whether test-spec authoring will
be possible after required routing stages.

## Findings

None.

## Review Dimensions

| Review dimension | Verdict | Notes |
| --- | --- | --- |
| requirement clarity | pass | The spec defines reader-facing guides, router behavior, template placement, two-speed sections, troubleshooting ownership, pilot behavior, and validation boundaries with stable requirement IDs. |
| normative language | pass | `MUST`, `SHOULD`, and `MAY` are used for observable documentation contracts, review evidence, or explicitly deferred validation behavior. |
| completeness | pass | Normal, migration, boundary, troubleshooting, security-sensitive, optional-guide, and no-command-check paths are covered. |
| testability | pass | Requirements and acceptance criteria can be checked through file existence, section checks, link/anchor review, manual pilot evidence, and absence of command-execution CI requirements. |
| examples | pass | Examples cover router use, fast path, walkthrough, troubleshooting routing, template discovery, and pilot benefit validation. |
| compatibility | pass | Existing numbered guides are treated as pre-change format, with discoverability preserved during migration and command semantics delegated to the existing workstation setup spec. |
| observability | pass | Structure checks, link checks, pilot walkthrough evidence, and review checklist answers are defined. |
| security/privacy | pass | The spec keeps sensitive command impact near commands and excludes secrets, proxy credentials, tokens, private hostnames, and machine-specific secrets from guide examples and pilot evidence. |
| non-goals | pass | The spec excludes full guide rewrite, command-contract changes, generated docs tooling, command execution CI, broad proxy/certificate handling, and hidden automation. |
| acceptance criteria | pass | Acceptance criteria cover proposal settlement, template, router, proxy pilot, numbered steps, troubleshooting links, pilot benefit evidence, structure/link checks, no command-execution CI, migration discoverability, and troubleshooting separation. |

## Rationale

The spec is precise enough for downstream planning and test-spec authoring. It avoids redefining first-slice setup commands while still specifying the observable documentation shape and review evidence needed for the guide-structure change. No architecture gate is required before planning because this spec changes documentation information architecture and validation expectations, not scripts, generated files, data flow, or machine-changing automation.

## Residual Risks

- The exact migration mechanism for existing numbered guide paths is intentionally left to implementation planning; the spec constrains the outcome by requiring discoverability preservation.
- Troubleshooting anchor taxonomy may need same-slice work when the proxy pilot is written.
- Advisory command review remains a human process until a later accepted change justifies command-execution CI.

## Recommendation

Approved for planning. No automatic handoff occurs from this review-only invocation.
