# Two-Speed How-To Guide Structure Test Spec

## Status

active

## Related spec and plan

- Spec: `specs/guides-two-speed-how-to-structure.md`
- Spec review: `docs/changes/2026-06-07-guides-two-speed-how-to-structure/reviews/spec-review.md`
- Plan: `docs/changes/2026-06-07-guides-two-speed-how-to-structure/plan.md`
- Plan review: `docs/changes/2026-06-07-guides-two-speed-how-to-structure/reviews/plan-review-r2.md`
- Architecture/ADRs: not applicable for this slice; architecture was reviewed as not required because the change is documentation structure and validation only.

## Testing strategy

The proof surface is documentation-first and static.

- Unit strategy: not applicable; there are no units, functions, or runtime modules.
- Integration strategy: use one repository-level Markdown proof script to check router, template, pilot guide, troubleshooting links, and validation-boundary contracts together.
- End-to-end strategy: use manual pilot walkthrough evidence to check whether `proxy-setup.md` can be completed from the fast path without reading the walkthrough.
- Smoke strategy: file-existence and required-heading checks prove the expected guide/template/router artifacts exist.
- Manual strategy: author attestation and pilot evidence cover command-review and reader-benefit claims that cannot be safely automated from this Linux workspace.
- Contract strategy: static checks map to spec requirement IDs and acceptance criteria, especially guide shape, link boundaries, migration discoverability, and command-execution CI exclusion.
- Migration strategy: check that current numbered guide content remains discoverable while new task-scoped guide paths are introduced.

The implementation proof script should be:

```bash
bash tests/markdown/guides-two-speed-how-to-structure.test.sh
```

The script should not execute setup commands from guide code blocks.

## Requirement coverage map

| Requirement ID | Covered by | Level | Notes |
| --- | --- | --- | --- |
| R1 | T1 | contract | Router and guide directory are checked as reader-facing how-to surfaces. |
| R2 | T1, T8 | contract | Template is under `docs/templates/`; guides are checked for absence of template-only skeleton content. |
| R3 | T1 | contract | Router must include reader-intent language rather than only filenames. |
| R4 | T1 | contract | Router must include fresh setup and targeted task paths. |
| R5 | T1, T3 | contract | Router preserves separate troubleshooting mode. |
| R6 | T6 | migration | New task-scoped guide filenames are checked for unnumbered stable names. |
| R7 | T1, T6 | migration | Sequence lives in router or `fresh-setup.md`, not numeric prefixes on task guides. |
| R8 | T6 | migration | Existing numbered guide discoverability is checked. |
| R9 | T1 | smoke | Template file exists at `docs/templates/how-to-guide.md`. |
| R10 | T1 | contract | Template location outside `docs/guides/` is checked. |
| R11 | T1 | contract | Template includes required metadata and sections. |
| R12 | T2 | contract | Pilot guide title is outcome-oriented. |
| R13 | T2 | contract | Pilot guide includes prerequisites near the top. |
| R14 | T2 | contract | Pilot guide includes estimated time near the top. |
| R15 | T2 | contract | Pilot guide includes expected outcome near the top. |
| R16 | T2 | contract | Pilot guide includes top-level verification near the top. |
| R17 | T2 | contract | Pilot guide includes `Fast path`. |
| R18 | T2, T9 | manual | Fast path structure is checked statically; command minimality is reviewed manually. |
| R19 | T2 | contract | Pilot guide includes `Walkthrough`. |
| R20 | T2, T9 | manual | Numbered flow exists in both sections; parity is manually reviewed. |
| R21 | T2, T9 | manual | Walkthrough context and safety value are checked by review checklist. |
| R22 | T2 | contract | Numbered steps are checked in both sections. |
| R23 | T2, T9 | manual | Verification text is checked statically and meaningful placement is reviewed manually. |
| R24 | T2, T7 | contract | Command/code fences and advisory command review are checked. |
| R25 | T3 | contract | Inline troubleshooting links are checked in the pilot guide. |
| R26 | T3 | contract | Links must target `docs/troubleshooting/*.md#anchor`. |
| R27 | T3 | contract | Deep recovery ownership remains under troubleshooting docs. |
| R28 | T3 | contract | Guide rationale stays brief and links out where needed. |
| R29 | T4 | smoke | `docs/guides/proxy-setup.md` exists as pilot. |
| R30 | T4 | contract | Proxy pilot checks prerequisites, variance/failure symptoms, verification, and links. |
| R31 | T4, T9 | manual | Pilot fast-path completion is captured in walkthrough evidence. |
| R32 | T4, T9 | manual | Pilot evidence records starting state, completion result, time, and defects. |
| R33 | T7 | contract | Static checks prioritize stable shape and links. |
| R34 | T7, T9 | manual | Advisory command review is documented and manually attested. |
| R35 | T7 | contract | Test proof checks that command-execution CI is not required. |
| R36 | T7 | contract | Deferred command-execution CI criteria are preserved in docs. |
| R37 | T8 | contract | Static-site generation, docs wizard, and generated flows remain absent. |
| R38 | T8 | contract | Opaque installer and hidden automation remain absent. |
| R39 | T8 | contract | Test checks this slice does not redefine setup command contracts. |
| R40 | T3, T9 | manual | Sensitive command impacts are checked near affected commands during manual review. |
| R41 | T1 | contract | Router names the first task-scoped guide targets. |
| R42 | T1 | contract | Optional guide routing policy is visible in router/template expectations. |

## Example coverage map

| Example | Covered by | Notes |
| --- | --- | --- |
| E1 | T1 | Router intent path to proxy setup. |
| E2 | T2, T9 | Fast path has required commands, expected result, and verification; completion is manually checked. |
| E3 | T2, T9 | Walkthrough has same numbered flow plus context and troubleshooting. |
| E4 | T3 | Failed verification routes to troubleshooting anchors. |
| E5 | T1 | Contributor template discovery under `docs/templates/`. |
| E6 | T4, T9 | Pilot benefit evidence records fast-path completion result. |

## Edge case coverage

| Edge case | Covered by | Level | Notes |
| --- | --- | --- | --- |
| EC1 | T1, T2 | contract | Template allows rollback to be marked not applicable while keeping fast path/walkthrough. |
| EC2 | T2 | contract | Numbered steps required even for short guides. |
| EC3 | T2, T9 | manual | Branch defaults are reviewed in proxy pilot. |
| EC4 | T3 | contract | Missing anchors are treated as same-slice dependencies or file-only links. |
| EC5 | T3, T9 | manual | Sensitive proxy/WSL impact warning is reviewed near commands. |
| EC6 | T6 | migration | Existing numbered guides remain discoverable. |
| EC7 | T1 | contract | Optional guides such as `uv` are included in router/template policy. |
| EC8 | T2, T9 | manual | Prerequisites and local policy assumptions are reviewed. |
| EC9 | T7, T9 | manual | Illustrative command blocks must be labeled and not treated as executable setup. |
| EC10 | T3 | contract | Rationale links out to ADR/architecture instead of becoming guide-local deep rationale. |

## Test cases

### T1. Router and template contract

- Covers: R1-R5, R9-R11, R41-R42, E1, E5, EC1, EC7
- Level: integration
- Fixture/setup: Repository after M1 implementation.
- Steps: Check `docs/guides/README.md` and `docs/templates/how-to-guide.md` exist. Verify the router includes reader-intent wording, fresh setup, targeted task names, troubleshooting routing, existing numbered guide discoverability, and optional-guide policy. Verify the template includes title, prerequisites, time, outcome, verify, fast path, walkthrough, rollback, and troubleshooting placeholders.
- Expected result: Router and template satisfy the guide information architecture contract without placing template-only content under `docs/guides/`.
- Failure proves: The guide set cannot reliably route readers or contributors before guide conversion.
- Automation location: `tests/markdown/guides-two-speed-how-to-structure.test.sh`

### T2. Task guide two-speed structure

- Covers: R12-R24, E2, E3, EC1-EC3, EC8
- Level: integration
- Fixture/setup: Repository after `docs/guides/proxy-setup.md` exists.
- Steps: Check the proxy guide has an outcome-oriented H1, top metadata, `## Fast path`, `## Walkthrough`, numbered steps in both sections, expected result text, verification text, and fenced command/config blocks.
- Expected result: The pilot guide has the required two-speed shape and can be reviewed step-by-step.
- Failure proves: The pilot did not implement the guide template contract.
- Automation location: `tests/markdown/guides-two-speed-how-to-structure.test.sh`

### T3. Troubleshooting boundary and anchor links

- Covers: R5, R25-R28, R40, E4, EC4, EC5, EC10
- Level: integration
- Fixture/setup: Repository after proxy pilot and proxy troubleshooting anchor updates.
- Steps: Check the proxy guide links inline to `../troubleshooting/proxy.md#...` anchors. Check the target troubleshooting file exists and contains matching headings or anchors. Check the guide does not contain a long troubleshooting deep-dive section and uses external links for deeper recovery/rationale.
- Expected result: Failure-point routing exists without moving deep recovery into the guide.
- Failure proves: The guide/troubleshooting boundary or anchor integrity is broken.
- Automation location: `tests/markdown/guides-two-speed-how-to-structure.test.sh`

### T4. Proxy pilot benefit evidence

- Covers: R29-R32, E6
- Level: manual
- Fixture/setup: `docs/guides/proxy-setup.md` exists and `docs/changes/2026-06-07-guides-two-speed-how-to-structure/pilot-review.md` is prepared.
- Steps: A maintainer runs or manually walks through the fast path from a documented starting state. Record guide path, starting state, approximate time, whether the task was completable without reading walkthrough, and any missing safety or verification context.
- Expected result: `pilot-review.md` contains enough evidence to judge whether the fast path serves the intended reader benefit.
- Failure proves: The proposal's quick-configuration user benefit was not validated.
- Automation location: manual record at `docs/changes/2026-06-07-guides-two-speed-how-to-structure/pilot-review.md`

### T5. Acceptance criteria proof

- Covers: AC1-AC12
- Level: integration
- Fixture/setup: Repository after M1-M3 implementation.
- Steps: Check accepted proposal status, template, router, proxy pilot, numbered steps, troubleshooting links, pilot evidence, structure proof, link proof, no command-execution CI requirement, migration discoverability, and troubleshooting separation.
- Expected result: Every acceptance criterion has an observable artifact or manual evidence record.
- Failure proves: The change is not ready for implementation closeout even if individual files exist.
- Automation location: `tests/markdown/guides-two-speed-how-to-structure.test.sh`

### T6. Migration and filename compatibility

- Covers: R6-R8, EC6
- Level: migration
- Fixture/setup: Repository with current numbered guides and new router.
- Steps: Check task-scoped guide names introduced by this change are unnumbered. Check current numbered guides are still discoverable from the router or documented migration notes.
- Expected result: Reader discoverability is preserved while task-scoped filenames stay stable and unnumbered.
- Failure proves: Migration could break existing reader paths or encode order into task filenames.
- Automation location: `tests/markdown/guides-two-speed-how-to-structure.test.sh`

### T7. Validation and CI boundary

- Covers: R33-R36, R24, R34-R35, EC9
- Level: contract
- Fixture/setup: Repository after M3 implementation.
- Steps: Check the proof script exists, checks shape and links, and does not run setup commands. Check docs preserve advisory command review language and deferred command-execution CI criteria.
- Expected result: Validation is lightweight and respects the no-command-execution boundary.
- Failure proves: Validation either undercovers guide shape or oversteps into premature setup command execution.
- Automation location: `tests/markdown/guides-two-speed-how-to-structure.test.sh`

### T8. Non-goal and automation guardrails

- Covers: R2, R37-R39
- Level: contract
- Fixture/setup: Repository after M1-M3 implementation.
- Steps: Check changed docs do not introduce static-site generation, generated docs wizard, one-command installer, hidden automation, or new setup command semantics for PowerShell, WSL, Neovim, tmux, proxy, sudoers, fstab, mount, or package sources.
- Expected result: The change remains documentation-structure work only.
- Failure proves: The implementation expanded beyond the approved spec.
- Automation location: `tests/markdown/guides-two-speed-how-to-structure.test.sh` plus manual review for semantic command-contract drift.

### T9. Manual review checklist

- Covers: R18, R20-R23, R31-R32, R34, R40, E2, E3, E6, EC3, EC5, EC8, EC9
- Level: manual
- Fixture/setup: Router, template, proxy pilot, troubleshooting links, and pilot-review record exist.
- Steps: Reviewer answers these questions: Is this guide for my task? What will be true when I finish? What commands do I run first? How do I know it worked? Where do I go if this exact step fails? Reviewer also checks fast path/walkthrough parity, safety warning placement, illustrative command labeling, and advisory command-review attestation.
- Expected result: Manual review confirms the qualitative parts that static grep cannot prove.
- Failure proves: The guide may pass shape checks while failing reader value or safety review.
- Automation location: manual checklist in milestone review notes or `pilot-review.md`

## Fixtures and data

- Existing numbered guides under `docs/guides/`.
- Existing troubleshooting docs under `docs/troubleshooting/`.
- New router: `docs/guides/README.md`.
- New template: `docs/templates/how-to-guide.md`.
- New pilot guide: `docs/guides/proxy-setup.md`.
- New pilot evidence: `docs/changes/2026-06-07-guides-two-speed-how-to-structure/pilot-review.md`.
- New proof script: `tests/markdown/guides-two-speed-how-to-structure.test.sh`.

No external services, credentials, private proxy data, or Windows/WSL execution environment are required for the automated proof.

## Mocking/stubbing policy

No mocks or stubs are needed. Static tests inspect repository files directly. Manual pilot evidence may simulate command execution when a real Windows/WSL/proxy environment is unavailable, but it must label that as manual review rather than executed proof.

## Migration or compatibility tests

Migration coverage is T6. It verifies that existing numbered guide content remains discoverable during the task-scoped migration and that newly introduced task-scoped filenames do not use global numeric prefixes.

The test spec does not require redirect files specifically; the plan may choose router links, migration notes, or retained numbered files as the compatibility mechanism.

## Observability verification

The proof script should print actionable failures that name the missing file, heading, link target, or contract phrase. Link/anchor failures should include both the source guide and the missing target.

Manual pilot evidence must record:

- guide path;
- documented starting state;
- completion result;
- approximate time;
- whether walkthrough text was needed;
- missing safety or verification context, if any.

## Security/privacy verification

Automated checks should look for guardrail language around proxy credentials, internal hostnames, generated command flows, and one-command installers where practical. Manual review must confirm pilot evidence does not contain proxy credentials, tokens, private hostnames, private certificate material, or machine-specific secrets.

The tests must not execute setup commands that affect WSL config, proxy behavior, trust stores, sudoers, fstab, package sources, execution policy, or machine-wide state.

## Performance checks

The proof script should run as a lightweight local Markdown/static check. It should use shell builtins, `test`, `grep`, and `rg` where practical, matching the existing `tests/markdown/*.test.sh` style.

No timing benchmark is required for the automated proof. The only timing-related evidence is the manual approximate completion time recorded in `pilot-review.md`.

## Manual QA checklist

- Confirm `docs/guides/README.md` routes by reader intent, not only filename taxonomy.
- Confirm `docs/templates/how-to-guide.md` is copyable and does not look like a reader guide.
- Confirm `docs/guides/proxy-setup.md` can be understood from the fast path by an experienced reader.
- Confirm the walkthrough adds useful safety/context rather than duplicating the fast path without value.
- Confirm inline troubleshooting links appear at likely failure points.
- Confirm proxy troubleshooting anchors are stable enough for the pilot.
- Confirm no private proxy, certificate, host, or credential material appears in guide or pilot evidence.
- Confirm command semantics still defer to `specs/terminal-first-workstation-setup.md`.

## What not to test and why

- Do not execute setup commands from the guides; the approved spec defers command-execution CI.
- Do not validate actual Windows proxy, VPN, PAC, or corporate CA behavior; those are environment-specific and outside this slice.
- Do not require a static-site build; the project is plain Markdown on GitHub.
- Do not test full conversion of every first-slice guide; the plan covers router/template, proxy pilot, and validation only.
- Do not test exact PowerShell, WSL, Neovim, tmux, sudoers, fstab, or package-source command correctness in this test spec; those belong to `specs/terminal-first-workstation-setup.md` and its tests.

## Uncovered gaps

None that must return to spec or architecture.

Known manual limits:

- Fast-path usefulness is partly qualitative and requires reviewer judgment.
- Advisory command review cannot prove command correctness in CI.
- Troubleshooting taxonomy may need later expansion after the proxy pilot.

## Next artifacts

- Implement M1 using the M1 checks in this test spec.
- Implement M2 using the proxy pilot and manual pilot evidence checks.
- Implement M3 by adding `tests/markdown/guides-two-speed-how-to-structure.test.sh`.
- Record milestone validation in `docs/changes/2026-06-07-guides-two-speed-how-to-structure/plan.md`.

## Follow-on artifacts

None yet

## Readiness

Ready for implementation.

Implementation must start with failing or initially unmet proof for each milestone where feasible, then update the relevant docs and rerun the specified checks. This test spec does not claim implementation completion, code-review approval, final verification, branch readiness, or PR readiness.
