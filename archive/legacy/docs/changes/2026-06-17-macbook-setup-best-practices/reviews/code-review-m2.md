# Code Review M2: MacBook Terminal Baseline Guide

## Result

- Skill: code-review
- Status: completed
- Artifacts changed: `docs/changes/2026-06-17-macbook-setup-best-practices/reviews/code-review-m2.md`, `docs/changes/2026-06-17-macbook-setup-best-practices/review-log.md`, `docs/changes/2026-06-17-macbook-setup-best-practices/change.yaml`, `docs/plan.md`, `docs/plans/2026-06-17-macbook-setup-best-practices.md`
- Open blockers: CR-M2-001
- Next stage: review-resolution
- Review status: changes-requested
- Material findings: CR-M2-001
- Recording status: recorded
- Recording blocker: none
- Review record: `docs/changes/2026-06-17-macbook-setup-best-practices/reviews/code-review-m2.md`
- Review log: `docs/changes/2026-06-17-macbook-setup-best-practices/review-log.md`
- Review resolution: required
- Reviewed milestone: M2
- Milestone closeout: resolution-needed
- Remaining implementation milestones: M2, M3
- Required review-resolution: yes
- Finding IDs: CR-M2-001
- Verify readiness: not-claimed

## Review inputs

- Diff/review surface:
  - Companion repo commit `2a503a8 M2: add MacBook terminal baseline guide`
  - Current repo handoff commit `7f854ee Record MacBook M2 implementation handoff`
- Tracked governing branch state:
  - Current repo branch: `review-artifact-routing-macbook-proposal`
  - Companion repo branch: `macbook-setup-baseline`
- Governing artifacts:
  - Spec: `specs/macbook-setup-best-practices.md`
  - Test spec: `specs/macbook-setup-best-practices.test.md`
  - Plan: `docs/plans/2026-06-17-macbook-setup-best-practices.md`
  - Prior code review: `docs/changes/2026-06-17-macbook-setup-best-practices/reviews/code-review-m1.md`
- Validation evidence reviewed:
  - `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && bash tests/markdown/macbook-setup-best-practices.test.sh`
  - `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && git diff --check`
  - `cd /home/xiongxianfei/data/20260524-terminal-dev && git diff --check`

## Diff summary

M2 expands the companion guide from a scaffold into the personal developer MacBook terminal-baseline guide. It adds prerequisites, outcome, safety gates, ownership and managed-Mac routing, hardware and compatibility language, backup and Apple-owned system setup, Apple developer tooling, Homebrew boundaries, shell/Git/SSH/editor baseline, follow-up routing, and expanded static Markdown checks. Current-repo changes record the M2 implementation handoff and validation evidence.

## Findings

## Finding CR-M2-001

- Finding ID: CR-M2-001
- Severity: major
- Location: `/home/xiongxianfei/data/20260617-terminal-first-macos-dev/docs/guides/macbook-terminal-baseline.md:100`, `/home/xiongxianfei/data/20260617-terminal-first-macos-dev/docs/guides/macbook-terminal-baseline.md:118`, `/home/xiongxianfei/data/20260617-terminal-first-macos-dev/docs/guides/macbook-terminal-baseline.md:141`, `/home/xiongxianfei/data/20260617-terminal-first-macos-dev/tests/markdown/macbook-setup-best-practices.test.sh:97`
- Evidence: The M2 plan requires "Link checks for Apple and Homebrew source references." The guide names Apple's Software Update path, Apple Command Line Tools/Xcode tooling, and the Homebrew official site/install script in plain text, but it does not include source links. The proof script checks for terms such as `Software Update`, `Command Line Tools|Xcode`, `Homebrew`, and `install script`, but it does not require official Apple/Homebrew URLs or any local link check.
- Required outcome: M2 must include official Apple and Homebrew source references where setup guidance depends on those sources, and the M2 proof must validate those references or otherwise record why a link check is not applicable.
- Safe resolution path: Add source links near the Software Update, Command Line Tools/Xcode, and Homebrew setup guidance; extend `tests/markdown/macbook-setup-best-practices.test.sh` to assert those links or add an explicit local link-check command if one is adopted. Keep the guide documentation-only and do not add setup automation.
- needs-decision rationale: none

## Checklist coverage

| Check | Verdict | Evidence |
| --- | --- | --- |
| Spec alignment | concern | The guide covers most M2 requirements: ownership routing, Apple silicon default, Intel non-claim, backup gates, Software Update, FileVault, Apple Account, Privacy & Security, Command Line Tools, Homebrew boundaries, shell/Git/SSH/editor baseline, follow-up routing, and Windows repo boundary. CR-M2-001 remains because source references are not linked or checked as required by the plan. |
| Test coverage | concern | The proof script checks many M2 sections and ordering rules, and it passed. It does not check Apple/Homebrew source links despite the M2 plan calling for link checks. |
| Edge cases | pass | Managed Mac routing, restricted administrator rights, Intel unverified language, non-default Homebrew prefix, unavailable CLT/Xcode stop behavior, backup unknown stop behavior, deferred role stacks, and unverified claims are represented in the guide and/or static proof. |
| Error handling | pass | The guide stops on managed/corporate policy, unknown backup posture, unavailable admin privileges, unavailable CLT/Xcode, non-matching Homebrew prefix/health, and unsupported compatibility contexts. |
| Architecture boundaries | pass | No Brewfile, helper setup script, generated shell configuration, hidden bootstrap, or machine-changing automation was added. The shell script is static Markdown validation only. |
| Compatibility | pass | The guide keeps Apple silicon as the primary target only after evidence, marks Intel support unverified, and keeps macOS guide content in the companion repo. |
| Security/privacy | pass | The guide calls out FileVault recovery-key sensitivity, credential material, SSH policy, package-source trust, shell startup persistence, Privacy & Security permissions, and transcript scrubbing through the existing verification template. |
| Derived artifact currency | pass | Current-repo change metadata, plan index, active plan, and change explanation point at M2 and companion commit `2a503a8`. |
| Unrelated changes | pass | Companion changes are scoped to the guide, guide index, README status, and M2 proof script. Current-repo changes are scoped to lifecycle artifacts. |
| Validation evidence | pass | The companion proof script and both repository whitespace checks passed during implementation and were re-run during review. Passing validation does not cover CR-M2-001 because the selected proof omitted link checks. |

## No-finding rationale

Not applicable. This review has one material finding.

## Residual risks

- M3 still needs the manual verification evidence package and must not mark command-success or compatibility claims verified without a real Apple silicon walkthrough.
- This review does not claim branch readiness, PR readiness, CI success, final verification, or final closeout.

## Handoff

M2 requires review-resolution for CR-M2-001. No automatic downstream handoff occurs from this isolated review. The finding record exists before any fix is applied.
