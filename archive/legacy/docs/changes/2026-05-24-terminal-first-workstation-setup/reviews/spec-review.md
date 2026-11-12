# Spec Review: Terminal-First Workstation Setup

## Result

- Skill: spec-review
- Review status: approved
- Material findings: none
- Recording status: recorded
- Recording blocker: none
- Review record: `docs/changes/2026-05-24-terminal-first-workstation-setup/reviews/spec-review.md`
- Review log: `docs/changes/2026-05-24-terminal-first-workstation-setup/reviews/spec-review.md`
- Review resolution: `docs/changes/2026-05-24-terminal-first-workstation-setup/reviews/spec-review-resolution.md`
- Open blockers: none
- Immediate next stage: architecture

Latest review round: 2026-05-24 second pass.

The spec is approved for architecture authoring. SR-001 is addressed by the spec revision and review-resolution record. Before downstream architecture, test-spec, plan, or implementation relies on the spec, normalize `specs/terminal-first-workstation-setup.md` status from `draft` to `approved`.

## Review Log

| Round | Date | Status | Findings | Notes |
| --- | --- | --- | --- | --- |
| 1 | 2026-05-24 | changes-requested | SR-001 | Fresh WSL install-location command contract was unresolved. |
| 2 | 2026-05-24 | approved | none | SR-001 resolved; spec is ready for architecture after status normalization. |

## Prior Finding Resolution

| Finding ID | Disposition | Evidence |
| --- | --- | --- |
| SR-001 | addressed | R9 now defines `wsl --install --distribution <UbuntuLtsDistroName> --location "D:\Software\WSL\Ubuntu"` as the primary fresh-install command contract. R14 now requires official-doc and `wsl --help` validation, negative checks for unresolved/positional command forms, and post-install verification. `docs/changes/2026-05-24-terminal-first-workstation-setup/reviews/spec-review-resolution.md` records the disposition. |

## Second-Pass Review Dimensions

| Review dimension | Verdict | Notes |
| --- | --- | --- |
| requirement clarity | pass | Requirements now define the WSL fresh-install command contract, migration path, safety gates, and verification behavior clearly. |
| normative language | pass | MUST and SHOULD statements are testable or manually verifiable. |
| completeness | pass | The spec covers host, WSL storage, Ubuntu baseline, proxy, data mount, locale, sudo, Neovim, tmux, rollback, and README orientation. |
| testability | pass | Requirements expose static, manual, negative-path, and doctor-check assertions. |
| examples | pass | Examples cover fresh install, migration, shared data, sudo, and doctor checks. |
| compatibility | pass | Windows 11, WSL2, WSL version gating, unsupported `--location`, enterprise policy, and distro-name adaptation are covered. |
| observability | pass | Doctor layers, status values, remediation hints, version records, and verification commands are specified. |
| security/privacy | pass | Secrets, proxy credentials, sudo, fstab, WSL config, data loss, and state-changing command warnings are covered. |
| non-goals | pass | Scope excludes older Windows, arbitrary storage roots, full dotfiles, language runtimes, native Windows tmux, and full corporate proxy/CA support. |
| acceptance criteria | pass | Acceptance criteria are observable and now include a testable fresh install-location path. |

## Approved Review Recommendation

- Normalize spec status from `draft` to `approved` before downstream artifacts rely on it.
- Carry `SR-001` test IDs into `specs/terminal-first-workstation-setup.test.md`.
- Proceed to architecture next because the spec includes machine-changing boundaries: WSL relocation, WSL config, fstab, sudoers, proxy behavior, helper scripts, and config deployment.

## Original Review Result

- Review status: changes-requested
- Material findings: SR-001
- Recording status: recorded
- Recording blocker: none
- Review record: `docs/changes/2026-05-24-terminal-first-workstation-setup/reviews/spec-review.md`
- Review log: `docs/changes/2026-05-24-terminal-first-workstation-setup/reviews/spec-review.md`
- Review resolution: not-required until findings are addressed
- Open blockers: SR-001
- Immediate next stage: spec revision

## Findings

None in the latest review round.

## Original Finding

## Finding SR-001

- Finding ID: SR-001
- Severity: blocking
- Location: `specs/terminal-first-workstation-setup.md` R9, R14, Open questions
- Evidence: R9 requires fresh Ubuntu installation under `D:\Software\WSL\Ubuntu` using WSL's install-location option. R14 requires validating exact WSL command syntax before publication. The Open questions section says the exact fresh-install command form remains unresolved: `wsl --install Ubuntu --location ...` versus `wsl --install --distribution Ubuntu --location ...`. This is not just an implementation detail; it is the user-facing command contract for a core setup path.
- Required outcome: The spec must define the accepted fresh-install command contract or explicitly define a version-gated command selection rule that is testable.
- Safe resolution path: Update R9 and Open questions so the spec states a primary command form and fallback. A safe contract would be: the guide must list available distros with `wsl --list --online`; choose the explicit Ubuntu LTS distro name; use the target WSL version's documented install-location form; and the implementation/test-spec must verify the exact command with `wsl --help` or official docs before publishing. If the owner wants a single command, choose it now and remove the open question.
- needs-decision rationale: none

## Review Dimensions

| Review dimension | Verdict | Notes |
| --- | --- | --- |
| requirement clarity | block | Most requirements are clear, but the unresolved WSL fresh-install command leaves a core command contract ambiguous. |
| normative language | pass | Requirements use testable MUST/SHOULD language. |
| completeness | concern | Coverage is broad and mostly complete; exact WSL fresh-install command selection remains incomplete. |
| testability | block | Tests cannot be written for the fresh-install path without knowing the command contract or version-gated selection rule. |
| examples | pass | Examples cover fresh install, migration, data mount, sudo, and verification. |
| compatibility | concern | Compatibility is handled well overall, but WSL version gating for `--location` needs a concrete contract. |
| observability | pass | Doctor layers, status values, remediation hints, and version recording are specified. |
| security/privacy | pass | Data-loss, sudo, proxy credentials, secrets, and state-changing commands are covered. |
| non-goals | pass | Non-goals preserve scope. |
| acceptance criteria | concern | Acceptance criteria are good, but AC3 depends on the unresolved fresh-install command contract. |

## Eventual test-spec readiness

ready after architecture records the machine-changing boundaries.

The test spec can map requirements to validation checks for Windows host, WSL storage, migration safety, Ubuntu baseline, proxy, data mount, locale, sudo, Neovim, tmux, rollback, and the SR-001 fresh-install command contract.

## Stop condition

None for spec content. Status normalization to `approved` should happen before architecture or later artifacts rely on the spec.
