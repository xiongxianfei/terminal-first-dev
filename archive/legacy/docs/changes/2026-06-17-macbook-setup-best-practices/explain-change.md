# MacBook Setup Best Practices Change Explanation

## Summary

This change created a documentation-only macOS companion setup slice in `../20260617-terminal-first-macos-dev` while keeping `terminal-first-windows-dev` Windows-first.

The companion repository now has:

- A `terminal-first-macos-dev` README and guide index.
- A personal developer MacBook terminal-baseline guide.
- A manual verification evidence template.
- A static Markdown proof script for the guide, safety boundaries, source links, and verification evidence.

The current repository changed only lifecycle artifacts: proposal/spec/test-spec/plan/review records, change metadata, plan index, and this explanation. No macOS reader-facing guide content was added to this Windows-first repository by default.

## Problem

The original request asked for MacBook setup best practices. That topic is useful, but it conflicts with this repository's durable identity as a concise, terminal-first Windows 11 setup guide.

The accepted direction was to preserve the Windows repository boundary and create a separate macOS companion surface. The companion guide needed to be practical enough to answer the MacBook setup request, but strict enough to avoid unsafe defaults around backup state, FileVault, privacy permissions, package-source trust, credentials, managed Macs, Apple silicon versus Intel compatibility, and unverified command success.

## Decision Trail

| Decision point | Outcome | Source |
| --- | --- | --- |
| Proposal direction | Use a separate macOS companion repository, recommended as `terminal-first-macos-dev`; do not add macOS setup content to this repository by default. | `docs/proposals/2026-06-17-macbook-setup-best-practices.md` |
| Spec contract | First slice is a personal developer MacBook terminal baseline with safety gates, Apple-owned tooling boundaries, Homebrew as third-party CLI tooling, Git/SSH/editor readiness, and manual verification evidence. | `specs/macbook-setup-best-practices.md` |
| Architecture decision | Architecture not required because the approved slice excludes Brewfiles, scripts, generated shell configuration, hidden dotfile bootstrap, and setup automation. | `docs/plans/2026-06-17-macbook-setup-best-practices.md` |
| Test strategy | Use a static companion Markdown proof script plus manual review and future real Apple silicon walkthrough evidence; do not execute setup commands in CI. | `specs/macbook-setup-best-practices.test.md` |
| Plan milestones | M1 establishes companion surfaces, M2 writes the guide, M3 adds verification evidence and claim guards. | `docs/plans/2026-06-17-macbook-setup-best-practices.md` |
| Review outcome | M1, M2, and M3 are closed by code-review. CR-M2-001 was resolved before M2 closure. | `docs/changes/2026-06-17-macbook-setup-best-practices/review-log.md` |

Requirement coverage:

- M1: R29, AC1, AC4, AC5.
- M2: R1-R23, R27-R29, AC2-AC5, AC7.
- M2 resolution: CR-M2-001 source-reference link coverage.
- M3: R24-R26, R4-R6, R7, R18, R21, R25, AC6, AC8.

## Diff Rationale By Area

| File or area | Change | Reason | Source artifact | Test/evidence |
| --- | --- | --- | --- | --- |
| `../20260617-terminal-first-macos-dev/README.md` | Replaced template content with companion repo identity, Windows-repo boundary, guide/verification links, and validation command. | Establish the companion surface without changing this repository's vision. | Proposal Option D; R29; AC4 | M1 proof and code-review M1 |
| `../20260617-terminal-first-macos-dev/docs/guides/README.md` | Added guide index and status text. | Give the companion repo a durable reader entry point for the first-slice guide. | M1 plan | M1/M2 proof |
| `../20260617-terminal-first-macos-dev/docs/guides/macbook-terminal-baseline.md` | Added guide scaffold in M1, full terminal-baseline content in M2, source links in CR-M2-001 resolution, and verification-status labels in M3. | Implement the personal MacBook terminal baseline while keeping commands evidence-bound and managed Macs policy-dependent. | R1-R23, R27-R29; T-MAC-001 through T-MAC-006, T-MAC-008, T-MAC-012 | Companion proof script; code-review M1, M2, M2 R2, M3 |
| `../20260617-terminal-first-macos-dev/docs/guides/macbook-terminal-baseline.md` | Removed stale workflow-milestone status found during final verification. | Keep reader-facing guide content independent of implementation milestone state after M3 closed. | Artifact lifecycle and drift-detection rules | Companion proof script; code-review M3 drift fix |
| `../20260617-terminal-first-macos-dev/docs/verification/macbook-terminal-baseline.md` | Added required evidence fields, manual walkthrough record, verification checklist, transcript-scrubbing guidance, and claim boundary. | Provide the only allowed path for future command-success or compatibility claims. | R24-R26; Observability; Security/privacy; T-MAC-007, T-MAC-010, T-MAC-011 | M3 proof and code-review M3 |
| `../20260617-terminal-first-macos-dev/tests/markdown/macbook-setup-best-practices.test.sh` | Added static checks for required files, guide sections, ordering, scope boundaries, managed-Mac routing, Apple/Homebrew source links, verification fields, and forbidden automation. | Make documentation regressions visible without executing setup commands or requiring a Mac. | Test spec T-MAC-001 through T-MAC-013 where automatable | Expected failing proofs and passing validation |
| `docs/changes/2026-06-17-macbook-setup-best-practices/*` | Recorded change metadata, review log, review-resolution, code-review records, and this explanation. | Preserve lifecycle evidence and make review decisions auditable in this repository. | Constitution workflow rules; code-review records | Current-repo `git diff --check` |
| `docs/plans/2026-06-17-macbook-setup-best-practices.md` and `docs/plan.md` | Tracked milestone states, validation notes, companion commits, and handoff state. | Keep the multi-repo workflow navigable and prevent ambiguous workdir commands. | Plan-review PR-001 and plan-review R2 | Current-repo `git diff --check` |

## Tests Added Or Changed

The primary test surface is:

```bash
cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && bash tests/markdown/macbook-setup-best-practices.test.sh
```

What it proves:

- T-MAC-001: macOS reader-facing guide content lives in the companion repository and preserves the Windows-repo boundary.
- T-MAC-002: ownership context and managed/corporate Mac routing appear before risky setup guidance.
- T-MAC-003: hardware/architecture and Intel non-claim language are present.
- T-MAC-004: backup, Software Update, FileVault, Apple Account, administrator, and Privacy & Security guidance exists.
- T-MAC-005: Apple developer tooling and Homebrew boundaries, source trust, prefix, update, health, and rollback guidance are present.
- T-MAC-006: shell, Git, SSH, credential, and minimal editor baseline coverage exists.
- T-MAC-007: verification evidence fields exist.
- T-MAC-008: command-success and compatibility claims remain unverified until evidence exists.
- T-MAC-011: transcript-scrubbing fields are present.
- T-MAC-012: first-slice automation and role-stack non-goals are preserved.
- T-MAC-013: proposal/spec/test-spec/plan traceability exists.

This level is appropriate because the slice is Markdown documentation and static proof. The test spec explicitly says setup commands must not be executed in CI; command success requires a real Mac walkthrough.

Expected failing proof points were recorded before implementation or fixes:

- M1: missing `docs/guides/README.md`.
- M2: missing `Prerequisites` section.
- CR-M2-001: missing official Apple Software Update source link.
- M3: missing manual walkthrough record section.
- Final verification drift fix: stale `Current milestone` reader-guide section removed and guarded against regression.

## Validation Evidence Available Before Final Verify

Validation recorded during implementation and review:

| Stage | Command | Result |
| --- | --- | --- |
| M1 | `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && bash tests/markdown/macbook-setup-best-practices.test.sh` | passed after M1 implementation |
| M1 | `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && git diff --check` | passed before companion commit |
| M1 | `cd /home/xiongxianfei/data/20260524-terminal-dev && git diff --check` | passed during review |
| M2 | `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && bash tests/markdown/macbook-setup-best-practices.test.sh` | passed after M2 implementation |
| M2 | `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && git diff --check` | passed before companion commit |
| CR-M2-001 | `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && bash tests/markdown/macbook-setup-best-practices.test.sh` | failed before fix for missing Apple Software Update link; passed after fix |
| CR-M2-001 | `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && git diff --check` | passed after fix |
| M3 | `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && bash tests/markdown/macbook-setup-best-practices.test.sh` | failed before implementation for missing manual walkthrough record; passed after M3 implementation |
| M3 | `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && git diff --check` | passed before companion commit and during review |
| Drift fix | `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && bash tests/markdown/macbook-setup-best-practices.test.sh` | passed after stale milestone note removal |
| Drift fix | `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && git diff --check cdd8b2d..HEAD` | passed after stale milestone note removal |
| Lifecycle docs | `cd /home/xiongxianfei/data/20260524-terminal-dev && git diff --check` | passed during implementation and review stages |

No hosted CI status is claimed. No setup command success is claimed. The real Apple silicon walkthrough has not been run.

## Review Resolution Summary

Review-resolution artifact: `docs/changes/2026-06-17-macbook-setup-best-practices/review-resolution.md`

Material findings:

- PR-001: closed by plan-review R2 after validation commands were revised to name the current-repo or companion-repo workdir explicitly.
- CR-M2-001: closed by code-review M2 R2 after official Apple/Homebrew source links were added near setup guidance and the proof script asserted those links.

Current review-log status: no open findings.

No review-resolution artifact was needed for M1 or M3 because both reviews were clean with no material findings.

## Alternatives Rejected

- Add MacBook setup content directly to `terminal-first-windows-dev`: rejected because it would blur the Windows-first vision without a vision revision.
- Make this repository cross-platform immediately: rejected because it would be a larger product-scope change than the request required.
- Keep the answer chat-only: rejected because the user wanted durable workflow artifacts and a companion repo was created.
- Add Brewfiles, scripts, generated dotfiles, one-command bootstrap, or hidden automation: rejected because the first slice is documentation-only and automation would require architecture work.
- Treat Homebrew as the mechanism for Apple-owned updates/security settings: rejected because the spec separates Apple-owned system tooling from third-party CLI tooling.
- Claim Intel compatibility or managed/corporate Mac safety from Apple silicon documentation work: rejected because both require separate evidence or policy-specific handling.
- Claim command success from static checks: rejected because the test spec reserves command-success claims for a real Apple silicon walkthrough.

## Scope Control

Preserved non-goals:

- No macOS guide content was added to this Windows-first repository by default.
- `VISION.md` was not revised to make this repository cross-platform.
- No Brewfile, script, generated config, dotfile bootstrap, or setup automation was added.
- No Mac App Store automation, `mas`, GUI app bundle checklist, web/Python/container/cloud stack, or full editor configuration was added to the first slice.
- Managed/corporate Macs are routed to policy-dependent handling instead of treated as the default path.
- Intel support remains unclaimed.
- Command-success, setup-completion, and compatibility claims remain unverified until real evidence exists.

## Risks And Follow-Ups

Remaining risks:

- A real Apple silicon MacBook walkthrough is still required before verified command-success, setup-completion, or compatibility wording can be published.
- The companion proof uses static text checks, so reviewers still need final verification to confirm artifact coherence and no drift across the two repositories.
- The companion repo has not adopted a network link-check command; source links are statically asserted, not fetched.
- Intel and managed/corporate Mac support remain out of scope until separate verification or policy-specific guidance exists.

Follow-ups before PR handoff:

- Run final `verify` for the two-repo artifact set.
- Keep the guide's command-success and compatibility language unverified unless the real Apple silicon walkthrough evidence is recorded first.
- Prepare PR handoff only after final verification produces its own evidence.

## Current Readiness

M1, M2, and M3 are closed by code-review. This explanation records the rationale needed before final verification.

Final verification is recorded separately in `docs/changes/2026-06-17-macbook-setup-best-practices/verify-report.md`. This explanation does not claim PR body readiness, PR open readiness, or hosted CI success.
