# MacBook Setup Best Practices Test Spec

## Status

approved

## Related spec and plan

- Spec: `specs/macbook-setup-best-practices.md`
- Spec review: `docs/changes/2026-06-17-macbook-setup-best-practices/reviews/spec-review-r1.md`
- Plan: `docs/plans/2026-06-17-macbook-setup-best-practices.md`
- Plan review: `docs/changes/2026-06-17-macbook-setup-best-practices/reviews/plan-review-r2.md`
- Architecture/ADRs: not applicable for this first slice; the approved spec and plan exclude Brewfiles, scripts, generated shell configuration, hidden dotfile bootstrap, and setup automation. Architecture becomes required if implementation adds those surfaces.

## Testing strategy

The proof surface is documentation-first, static-first, and evidence-bound.

- Unit strategy: not applicable; this first slice introduces Markdown guide, verification, and test artifacts rather than runtime units or functions.
- Integration strategy: create one companion-repo Markdown proof script that checks guide structure, required sections, safety gates, companion-surface boundaries, managed-Mac routing, compatibility claims, Homebrew boundaries, shell-boundary language, Git/SSH coverage, and verification evidence fields together.
- End-to-end strategy: do not execute setup commands in CI. The end-to-end proof is a documented manual walkthrough on one real Apple silicon MacBook before any command-success or compatibility claim is marked verified.
- Smoke strategy: file-existence checks prove the companion guide, guide index, verification template, and proof script exist in `../20260617-terminal-first-macos-dev`.
- Manual strategy: reviewer and walkthrough evidence cover judgment-heavy requirements: safety-gate ordering, source-trust clarity, FileVault/recovery-key sensitivity, credential handling, shell persistent-state wording, and whether command-success claims match recorded evidence.
- Contract strategy: static checks map requirement IDs to guide sections and reject out-of-scope claims, automation, managed-Mac defaulting, Intel support claims without evidence, and macOS guide placement inside this Windows repository.
- Migration strategy: check that macOS implementation stays in `../20260617-terminal-first-macos-dev` and that this repository remains Windows-first unless a later vision-revision proposal changes scope.

Primary companion-repo proof script after implementation begins:

```bash
cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && bash tests/markdown/macbook-setup-best-practices.test.sh
```

Whitespace checks:

```bash
cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && git diff --check
cd /home/xiongxianfei/data/20260524-terminal-dev && git diff --check -- specs/macbook-setup-best-practices.test.md docs/plans/2026-06-17-macbook-setup-best-practices.md docs/changes/2026-06-17-macbook-setup-best-practices/change.yaml
```

The proof script must not execute setup commands from guide code blocks and must not require macOS, Apple Account access, administrator privileges, Homebrew, network access, private keys, credentials, or private machine data. Manual walkthrough evidence is the only path for command-success or compatibility claims.

## Requirement coverage map

| Requirement ID | Covered by | Level | Notes |
| --- | --- | --- | --- |
| R1 | T-MAC-002, T-MAC-009 | contract | Ownership context must appear before state-changing setup sections. |
| R2 | T-MAC-002 | contract | Personal developer MacBook is checked as the default audience. |
| R3 | T-MAC-002, T-MAC-009 | contract | Corporate-managed Mac must not be the default path. |
| R4 | T-MAC-003 | contract | Hardware model and CPU architecture checks are required before compatibility-sensitive guidance. |
| R5 | T-MAC-003, T-MAC-010 | contract | Apple silicon is the only primary verified target unless evidence broadens support. |
| R6 | T-MAC-003, T-MAC-010 | contract | Intel claims are rejected without Intel evidence. |
| R7 | T-MAC-004, T-MAC-009 | contract | Backup posture must gate persistent setup changes. |
| R8 | T-MAC-004 | contract | macOS updates must use Apple's Software Update path. |
| R9 | T-MAC-004 | contract | Default path must reject beta macOS guidance. |
| R10 | T-MAC-004, T-MAC-011 | contract | FileVault and recovery-key handling must be visible and treated as sensitive. |
| R11 | T-MAC-004 | contract | Apple Account and administrator assumptions must be visible before dependent steps. |
| R12 | T-MAC-004, T-MAC-011 | contract | Privacy & Security review must cover developer-tool permissions. |
| R13 | T-MAC-005 | contract | Command Line Tools or Xcode tooling must be verified before package-manager-dependent setup. |
| R14 | T-MAC-005 | contract | Apple-owned tooling and third-party CLI tooling must be distinguished. |
| R15 | T-MAC-005 | contract | Homebrew must be the first-slice third-party CLI package manager. |
| R16 | T-MAC-005 | contract | Homebrew must not be used for Apple-owned system updates or security settings. |
| R17 | T-MAC-012 | contract | Mac App Store automation and `mas` must be deferred. |
| R18 | T-MAC-005, T-MAC-011 | contract | Homebrew trust, install-script review, prefix, update, and rollback notes must be checked. |
| R19 | T-MAC-006, T-MAC-009 | contract | Shell profile, PATH, and Homebrew environment changes must be explained before edits. |
| R20 | T-MAC-012 | contract | Opaque dotfile bootstrap must be absent. |
| R21 | T-MAC-006, T-MAC-011 | contract | Git identity, SSH key handling, and credential-storage expectations must be covered without exposing secrets. |
| R22 | T-MAC-006 | contract | Only minimal editor availability is allowed in the first slice. |
| R23 | T-MAC-012 | contract | Role stacks and full editor configuration must route to follow-up modules. |
| R24 | T-MAC-007 | contract | Terminal verification checks must cover macOS version, architecture, CLT path, Git, SSH, Homebrew prefix, Homebrew health, and editor launch. |
| R25 | T-MAC-007, T-MAC-010 | manual | Manual evidence must record exact required fields. |
| R26 | T-MAC-008, T-MAC-010 | contract | Command-success and compatibility claims must remain unverified until evidence exists. |
| R27 | T-MAC-009 | manual | Persistent state changes should state inspect/reverse behavior; review evidence checks sufficiency. |
| R28 | T-MAC-002, T-MAC-009 | contract | Managed/corporate Mac concerns must route to policy-dependent notes or a separate proposal. |
| R29 | T-MAC-001, T-MAC-012 | contract | The guide must state this slice does not change the Windows repo vision or add macOS guides here by default. |
| Error behavior | T-MAC-002, T-MAC-004, T-MAC-005, T-MAC-008, T-MAC-009 | contract | Stop conditions and policy-dependent routing are checked by static proof and review. |
| Compatibility/migration | T-MAC-001, T-MAC-003, T-MAC-010, T-MAC-012 | migration | Companion-repo boundary, Apple-silicon-only verified target, and Windows-repo non-migration are checked. |
| AC1 | T-MAC-000, T-MAC-013 | smoke | Traceability to proposal, review, spec, and plan is checked. |
| AC2 | T-MAC-013 | contract | Stable requirement coverage is checked in this test spec and proof script mapping. |
| AC3 | T-MAC-003, T-MAC-010 | contract | Personal Apple silicon default is checked. |
| AC4 | T-MAC-001, T-MAC-012 | migration | macOS guide content is not added to this Windows repo by default. |
| AC5 | T-MAC-012 | contract | Scripts, Brewfiles, generated config, and hidden automation are rejected. |
| AC6 | T-MAC-007, T-MAC-010 | manual | Manual verification evidence is required before success claims. |
| AC7 | T-MAC-002 | contract | Managed/corporate Mac behavior is routed out of the default path. |
| AC8 | T-MAC-000 | smoke | This approved test spec exists after approved plan-review. |

## Example coverage map

| Example | Covered by | Notes |
| --- | --- | --- |
| E1 | T-MAC-002, T-MAC-003, T-MAC-004, T-MAC-005, T-MAC-006, T-MAC-007, T-MAC-010 | Personal Apple silicon terminal-baseline flow is covered by static guide checks plus manual walkthrough evidence. |
| E2 | T-MAC-002, T-MAC-009 | Managed Mac stop condition and policy routing are checked. |
| E3 | T-MAC-003, T-MAC-010 | Intel non-claim language and evidence requirements are checked. |
| E4 | T-MAC-005, T-MAC-011 | Homebrew auditability and trust assumptions are checked. |

## Edge case coverage

| Edge case | Covered by | Level | Notes |
| --- | --- | --- | --- |
| EC1 | T-MAC-002, T-MAC-004 | contract | No-admin Apple silicon path must identify blocked admin-dependent steps. |
| EC2 | T-MAC-002, T-MAC-009 | contract | Corporate certificates/proxy route to policy-dependent guidance. |
| EC3 | T-MAC-003, T-MAC-010 | contract | Intel support remains unverified without evidence. |
| EC4 | T-MAC-005, T-MAC-009 | contract | Non-default Homebrew prefix requires troubleshooting before assumptions. |
| EC5 | T-MAC-005 | contract | Existing Command Line Tools are verified, not blindly reinstalled. |
| EC6 | T-MAC-004, T-MAC-011 | contract | FileVault enabled path confirms recovery-key handling without exposing keys. |
| EC7 | T-MAC-004, T-MAC-009 | contract | Unknown backup status stops persistent changes. |
| EC8 | T-MAC-012 | contract | Python, containers, cloud CLIs, GUI apps, and full editor setup route to follow-ups. |
| EC9 | T-MAC-004 | contract | macOS beta behavior is not used as the default contract. |
| EC10 | T-MAC-011 | contract | Verification transcripts must be scrubbed before publication. |

## Test cases

### T-MAC-000. Test spec traceability exists

- Covers: AC1, AC8
- Level: smoke
- Fixture/setup: This repository after test-spec authoring.
- Steps: Confirm `specs/macbook-setup-best-practices.test.md` exists and references the approved spec, approved spec review, approved plan, and plan review.
- Expected result: The MacBook setup slice has an active proof-planning artifact before implementation.
- Failure proves: Implementation could begin without traceable proof design.
- Automation location: manual inspection before implementation.

### T-MAC-001. Companion repository boundary

- Covers: R29, AC4, compatibility/migration
- Level: migration
- Fixture/setup: Current repo and companion repo after M1.
- Steps: Check implementation guide, verification, and test files are under `/home/xiongxianfei/data/20260617-terminal-first-macos-dev`. Check this Windows repo only changes lifecycle artifacts such as specs, plans, reviews, and metadata. Check companion guide text states it does not change `terminal-first-windows-dev` vision or add macOS guide content there.
- Expected result: macOS reader-facing implementation stays in the companion repo while this repo remains Windows-first.
- Failure proves: The implementation blurred repository scope or silently made this repo cross-platform.
- Automation location: `cd /home/xiongxianfei/data/20260617-terminal-first-macos-dev && bash tests/markdown/macbook-setup-best-practices.test.sh` plus current-repo diff review.

### T-MAC-002. Ownership context and managed-Mac routing

- Covers: R1-R3, R28, E2, EC1-EC2, AC7
- Level: contract
- Fixture/setup: Companion guide after M2.
- Steps: Check ownership-context section appears before package-manager, shell, credential, privacy, encryption, or machine-wide setup sections. Check personal developer MacBook is the default path. Check MDM, endpoint security, certificates, proxy, FileVault policy, and restricted admin rights route to policy-dependent notes or a future managed-Mac proposal before state-changing commands.
- Expected result: Managed/corporate Macs are not treated as the default and are stopped before risky generic setup.
- Failure proves: The guide can give unsafe default advice to policy-managed devices.
- Automation location: `tests/markdown/macbook-setup-best-practices.test.sh`

### T-MAC-003. Hardware, architecture, and compatibility claims

- Covers: R4-R6, E3, EC3, AC3
- Level: contract
- Fixture/setup: Companion guide after M2.
- Steps: Check hardware model and CPU architecture inspection appears before compatibility-sensitive guidance. Check Apple silicon is named as the primary verified target. Reject Intel support claims unless an Intel verification evidence file is present and linked.
- Expected result: Compatibility language is evidence-bound and Apple-silicon-first.
- Failure proves: The guide overstates hardware compatibility.
- Automation location: `tests/markdown/macbook-setup-best-practices.test.sh`

### T-MAC-004. System safety gates

- Covers: R7-R12, EC1, EC6-EC7, EC9
- Level: contract
- Fixture/setup: Companion guide after M2.
- Steps: Check backup posture appears before system updates, Homebrew install, shell edits, credentials, or other persistent changes. Check default update path is Apple's Software Update and beta releases are excluded from default guidance. Check FileVault, recovery-key handling, Apple Account, administrator assumptions, and Privacy & Security review are present before dependent steps.
- Expected result: Safety and Apple-owned system setup concerns are visible before persistent setup changes.
- Failure proves: The guide can lead readers into persistent changes without backup/security context.
- Automation location: `tests/markdown/macbook-setup-best-practices.test.sh`

### T-MAC-005. Apple tooling and Homebrew boundaries

- Covers: R13-R18, E4, EC4-EC5
- Level: contract
- Fixture/setup: Companion guide after M2.
- Steps: Check Command Line Tools or Xcode tooling is installed or verified before package-manager-dependent setup. Check Apple-owned tooling is separated from third-party CLI tooling. Check Homebrew is scoped to third-party CLI package management and not macOS updates or Apple security settings. Check Homebrew trust assumptions, install-script review, default prefix, update behavior, health check, troubleshooting, and uninstall or rollback notes are present.
- Expected result: Homebrew setup is auditable and correctly scoped.
- Failure proves: Package-source trust or Apple/Homebrew boundaries are misleading.
- Automation location: `tests/markdown/macbook-setup-best-practices.test.sh`

### T-MAC-006. Shell, Git, SSH, and editor baseline

- Covers: R19, R21-R22
- Level: contract
- Fixture/setup: Companion guide after M2.
- Steps: Check shell boundary section explains zsh profile files, PATH changes, and Homebrew shell environment before profile edits. Check Git identity readiness, SSH key handling, and credential-storage expectations are covered. Check editor coverage is limited to a minimal launch/availability check.
- Expected result: The terminal baseline is useful without becoming dotfiles or full editor setup.
- Failure proves: Persistent shell or credential guidance is underexplained, or editor scope has expanded.
- Automation location: `tests/markdown/macbook-setup-best-practices.test.sh`

### T-MAC-007. Verification template and required evidence fields

- Covers: R24-R25, AC6
- Level: contract
- Fixture/setup: Companion verification template after M3.
- Steps: Check verification template includes `sw_vers`, hardware model, CPU architecture, Command Line Tools state, Homebrew prefix, Homebrew health, Git availability, SSH readiness, minimal editor launch, verification date, verifier context, and whether the Mac was personal or managed.
- Expected result: Manual verification evidence can prove or limit command-success and compatibility claims.
- Failure proves: Verification evidence is too weak to support published claims.
- Automation location: `tests/markdown/macbook-setup-best-practices.test.sh`

### T-MAC-008. Command-success claim guard

- Covers: R26
- Level: contract
- Fixture/setup: Companion guide and verification template after M3.
- Steps: Check command-success, compatibility, and setup-completion wording is labeled unverified until a real manual walkthrough evidence file exists. Check any verified wording links to exact recorded evidence.
- Expected result: The guide does not claim success before proof exists.
- Failure proves: Published guidance overclaims unverified command behavior.
- Automation location: `tests/markdown/macbook-setup-best-practices.test.sh`

### T-MAC-009. Stop conditions and persistent-state auditability

- Covers: R1, R7, R19, R27-R28, error behavior, EC4, EC7
- Level: manual
- Fixture/setup: Companion guide after M2 and M3.
- Steps: Manually review state-changing sections for stop conditions before package-manager, credential, certificate, proxy, FileVault, shell, or package-source changes. Confirm each persistent change states what changes, how to inspect it, and how to reverse or troubleshoot it.
- Expected result: Risky paths are auditable and stop before unsafe assumptions.
- Failure proves: Static checks missed unsafe sequencing or vague recovery language.
- Automation location: manual milestone review evidence in `docs/changes/2026-06-17-macbook-setup-best-practices/review-log.md`

### T-MAC-010. Real Apple silicon manual walkthrough

- Covers: R5-R6, R24-R26, E1, E3, AC3, AC6
- Level: manual
- Fixture/setup: One real Apple silicon MacBook running the latest stable macOS offered by Software Update for that device.
- Steps: Complete the verification checklist. Record exact `sw_vers`, hardware model, CPU architecture, Command Line Tools state, Homebrew prefix, Homebrew health, Git availability, SSH readiness, minimal editor launch, verification date, verifier context, and personal/managed status. Record skipped, blocked, or policy-dependent steps explicitly.
- Expected result: Verified claims are bounded to the recorded Apple silicon context; Intel and managed-Mac support remain unclaimed unless separately verified.
- Failure proves: The guide lacks real evidence for command-success or compatibility claims.
- Automation location: manual verification record in `/home/xiongxianfei/data/20260617-terminal-first-macos-dev/docs/verification/macbook-terminal-baseline.md`

### T-MAC-011. Security and privacy guardrails

- Covers: R10, R12, R18, R21, EC6, EC10
- Level: contract
- Fixture/setup: Companion guide, verification template, and examples after M2 and M3.
- Steps: Check encryption, recovery keys, credentials, SSH keys, package sources, shell startup files, developer-tool permissions, network access, and automation permissions are identified where relevant. Reject examples or transcripts containing secrets, tokens, private keys, recovery keys, unnecessary usernames, private paths, machine names, or organization identifiers.
- Expected result: Sensitive setup areas are visible and published artifacts are scrubbed.
- Failure proves: The guide or evidence can leak sensitive data or hide security-sensitive impacts.
- Automation location: `tests/markdown/macbook-setup-best-practices.test.sh` plus manual review for transcript scrubbing.

### T-MAC-012. Non-goal and automation guardrails

- Covers: R17, R20, R23, R29, AC4-AC5, EC8
- Level: contract
- Fixture/setup: Current repo and companion repo after each milestone.
- Steps: Reject Mac App Store automation, `mas`, opaque dotfile bootstrap, Brewfiles, generated dotfiles, helper scripts, one-command bootstrap, hidden automation, role-specific stacks, GUI app bundles, cloud tooling, Python/container setup, full editor configuration, and macOS guide content in this Windows repo unless a later approved artifact changes scope.
- Expected result: The first slice remains terminal-baseline-only and documentation-first.
- Failure proves: Implementation exceeded the approved spec or triggered architecture without returning upstream.
- Automation location: `tests/markdown/macbook-setup-best-practices.test.sh` plus current-repo diff review.

### T-MAC-013. Coverage and traceability proof

- Covers: AC1-AC2
- Level: smoke
- Fixture/setup: Companion repo after M1 and this repo after test-spec authoring.
- Steps: Check companion guide or README references the approved proposal/spec lineage without copying Windows setup scope. Check this test spec maps all R1-R29, E1-E4, EC1-EC10, and AC1-AC8 to proof surfaces.
- Expected result: Reviewers can trace the implementation back to approved requirements and proof obligations.
- Failure proves: The implementation or test plan has untraceable behavior.
- Automation location: `tests/markdown/macbook-setup-best-practices.test.sh` plus manual inspection of this test spec.

## Fixtures and data

- Current repository: `/home/xiongxianfei/data/20260524-terminal-dev`
- Companion repository: `/home/xiongxianfei/data/20260617-terminal-first-macos-dev`
- Source spec: `specs/macbook-setup-best-practices.md`
- Approved plan: `docs/plans/2026-06-17-macbook-setup-best-practices.md`
- Planned companion guide: `/home/xiongxianfei/data/20260617-terminal-first-macos-dev/docs/guides/macbook-terminal-baseline.md`
- Planned companion guide index: `/home/xiongxianfei/data/20260617-terminal-first-macos-dev/docs/guides/README.md`
- Planned companion verification evidence/template: `/home/xiongxianfei/data/20260617-terminal-first-macos-dev/docs/verification/macbook-terminal-baseline.md`
- Planned companion proof script: `/home/xiongxianfei/data/20260617-terminal-first-macos-dev/tests/markdown/macbook-setup-best-practices.test.sh`
- Manual verification fixture: one real Apple silicon MacBook running the latest stable macOS offered by Software Update for that device.

No secrets, recovery keys, tokens, private keys, private machine names, organization identifiers, or private paths may be committed as fixtures.

## Mocking/stubbing policy

- Static tests may use fixture text only for generated temporary files inside the test harness; they must not replace the real guide files when validating implementation.
- Manual verification evidence may redact usernames, machine names, private paths, keys, tokens, organization identifiers, and recovery-key material.
- Tests must not mock command success for `sw_vers`, Command Line Tools, Homebrew, Git, SSH, or editor launch. Those claims are manual evidence only.
- Managed/corporate Mac behavior is verified through text routing and review evidence, not simulated MDM policy.

## Migration or compatibility tests

- T-MAC-001 verifies the migration from chat-only MacBook advice to a separate companion repo rather than this Windows repo.
- T-MAC-003 and T-MAC-010 verify Apple silicon is the only verified default unless extra evidence exists.
- T-MAC-003 rejects Intel compatibility claims unless separate Intel verification evidence is added.
- T-MAC-002 rejects managed/corporate Mac defaulting and routes those cases to policy-dependent guidance.
- T-MAC-012 rejects adding macOS guide content to this Windows-first repository by default.

## Observability verification

- T-MAC-007 verifies the companion verification template contains every required evidence field.
- T-MAC-008 verifies guide claims remain tied to recorded verification evidence.
- T-MAC-010 supplies the manual walkthrough evidence path for command-success and compatibility claims.
- Review evidence must distinguish verified, manually checked, skipped, blocked, and policy-dependent steps.

## Security/privacy verification

- T-MAC-004 checks FileVault, recovery-key, Apple Account, administrator-account, and Privacy & Security coverage.
- T-MAC-005 checks Homebrew source-trust and install-script review wording.
- T-MAC-006 checks Git/SSH credential-storage coverage.
- T-MAC-011 checks sensitive topics and rejects secrets, tokens, private keys, recovery keys, private paths, private machine names, and organization identifiers in examples or transcripts.

## Performance checks

Runtime performance is not applicable. The first slice is Markdown documentation and static proof.

Contributor workflow performance is checked qualitatively:

- The companion static proof script should run locally without requiring a macOS machine.
- Manual walkthrough duration should be recorded as observed evidence, not asserted as a guarantee.

## Manual QA checklist

- Confirm the companion repo exists and is the only reader-facing macOS guide surface.
- Review ownership-context placement before any state-changing setup sections.
- Review managed/corporate Mac routing for MDM, endpoint security, certificates, proxy, FileVault policy, and restricted admin rights.
- Review backup, Software Update, FileVault, Apple Account, administrator-account, and Privacy & Security sections before persistent setup steps.
- Review Command Line Tools and Homebrew ordering, Homebrew trust assumptions, prefix behavior, update behavior, health check, and uninstall or rollback notes.
- Review shell, Git, SSH, credential-storage, and editor baseline sections for persistence and scope discipline.
- Complete the real Apple silicon manual walkthrough before any verified command-success or compatibility language is published.
- Scrub verification transcripts for usernames where unnecessary, machine names, private paths, tokens, keys, recovery keys, and organization identifiers before publication.

## What not to test and why

- Do not execute setup commands in CI; command success requires real Mac walkthrough evidence and many steps depend on local machine state.
- Do not test enterprise MDM, certificate deployment, proxy configuration, endpoint security, or restricted admin behavior; managed/corporate Macs are out of the default path and policy-dependent.
- Do not test Intel compatibility until Intel support is intentionally claimed and separate evidence exists.
- Do not test Mac App Store automation, `mas`, GUI app bundles, Python, containers, cloud tooling, or full editor configuration; those are deferred follow-up modules.
- Do not test Brewfiles, scripts, generated dotfiles, one-command bootstrap, or hidden automation in this first slice; adding them would require upstream architecture work.
- Do not verify Apple Account, FileVault recovery keys, SSH private keys, or credentials by collecting secrets; only scrubbed state/evidence fields are allowed.

## Uncovered gaps

None requiring spec or architecture return for the approved first slice.

Known downstream proof gaps:

- A real Apple silicon MacBook is still required before verified command-success or compatibility claims can be published.
- Intel support remains unclaimed until a separate Intel verification path exists.
- The companion repo's exact link-check command must be selected during implementation or review if the repo adopts a preferred checker.

## Next artifacts

- Implement M1 in `../20260617-terminal-first-macos-dev`: create companion guide, verification, and test directories plus the first static proof script.
- Run milestone implementation through `implement`, then `code-review`.
- Author architecture before implementation only if Brewfiles, scripts, generated shell configuration, dotfile bootstrap, setup automation, or other machine-changing automation is introduced.

## Follow-on artifacts

None yet.

## Readiness

Approved for implementation of M1. Readiness is not Done; implementation, code-review, any review-resolution, later milestone work, explanation, final verification, and PR handoff remain.
