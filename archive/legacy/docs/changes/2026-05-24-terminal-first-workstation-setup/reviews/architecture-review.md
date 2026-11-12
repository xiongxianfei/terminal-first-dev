# Architecture Review: Terminal-First Workstation Setup Boundaries

## Result

- Review surface: canonical-architecture-update
- Review status: approved
- Material findings: none in latest pass
- Recording status: recorded
- Recording blocker: none
- Review record: `docs/changes/2026-05-24-terminal-first-workstation-setup/reviews/architecture-review.md`
- Review log: `docs/changes/2026-05-24-terminal-first-workstation-setup/reviews/architecture-review.md`
- Review resolution: `docs/changes/2026-05-24-terminal-first-workstation-setup/reviews/architecture-review-resolution.md`
- Open blockers: none
- Required canonical updates: none from this review; normalize architecture status to `approved` before downstream planning relies on it
- Required ADR updates: none
- Next stage: architecture status normalization, then downstream planning/test-spec as the workflow directs

Latest review round: 2026-05-24 second pass.

Reviewed artifacts:

- `docs/architecture/system/architecture.md`
- `docs/architecture/system/diagrams/context.mmd`
- `docs/architecture/system/diagrams/container.mmd`
- `docs/adr/2026-05-24-version-and-package-policy.md`
- `docs/adr/2026-05-24-wsl-storage-and-data-mount-policy.md`
- `docs/adr/2026-05-24-proxy-strategy.md`
- `docs/adr/2026-05-24-neovim-plugin-baseline.md`
- `specs/terminal-first-workstation-setup.md`
- `docs/changes/2026-05-24-terminal-first-workstation-setup/reviews/spec-review.md`
- `docs/proposals/2026-05-24-bootstrap-terminal-first-windows-dev.md`
- `docs/workflows.md`
- `docs/project-map.md`
- `CONSTITUTION.md`
- `AGENTS.md`

## Review Log

| Round | Date | Status | Findings | Notes |
| --- | --- | --- | --- | --- |
| 1 | 2026-05-24 | changes-requested | AR-001, AR-002 | arc42 section heading and workflow architecture path needed correction. |
| 2 | 2026-05-24 | approved | none | AR-001 and AR-002 are addressed by the review-resolution patch. |

## Prior Finding Resolution

| Finding ID | Disposition | Evidence |
| --- | --- | --- |
| AR-001 | addressed | `docs/architecture/system/architecture.md` now uses `## 2. Architecture Constraints`. |
| AR-002 | addressed | `docs/workflows.md` now identifies `docs/architecture/system/architecture.md` as the canonical architecture package and keeps dated architecture review records documented separately. |

## Second-Pass Review Dimensions

| Review dimension | Verdict | Notes |
| --- | --- | --- |
| Spec alignment | pass | The architecture remains aligned with the approved spec's WSL storage, migration, proxy, fstab, sudoers, Neovim, tmux, helper, validation, and rollback boundaries. |
| Package shape | pass | The canonical package has lifecycle metadata and the required arc42 section sequence; the prior section 2 heading issue is resolved. |
| Boundary clarity | pass | C4 context and container diagrams plus Building Block View remain sufficient for the repository, guide, helper, config, spec/test, and ADR boundaries. |
| Data ownership | pass | WSL distro storage, shared data, Linux project code, generated files, and modified user-machine state remain explicit. |
| Interface safety | pass | Fresh install command contract, WSL version gating, migration fallback, and unsupported-option behavior still match R9 and R14. |
| Runtime and failure handling | pass | Failure paths stop before destructive or sensitive steps when export, `--location`, `visudo`, or `sudo mount -a` checks fail. |
| Deployment and execution boundaries | pass | Deployment View identifies Windows PowerShell, Ubuntu shell under WSL2, Neovim runtime, and modified machine/user state. |
| Security/privacy | pass | Destructive migration, sudoers, fstab, proxy fallback, and machine/user state risks are visible. |
| Quality and operations | pass | Validation, safety, portability, observability, quality requirements, and known risks are explicit enough for planning. |
| Testing feasibility | pass | Test-spec can map the design to static docs checks, doctor checks, manual verification, and negative-path checks. |
| Complexity discipline | pass | The design remains documentation-first with small helpers and no one-command unattended installer. |
| ADR quality | pass | Durable decisions have accepted ADRs with context, decision, alternatives, consequences, and follow-up. |
| Plan readiness | pass | No architecture-review findings remain. Normalize the architecture status before downstream planning relies on it. |

## Latest Findings

None.

## Original Findings

### AR-001 - arc42 section 2 uses a shortened heading

Finding: The architecture package does not preserve the official arc42 section name for section 2.

Location: `docs/architecture/system/architecture.md:22`

Severity: material

Evidence: The architecture method requires lifecycle metadata before all 12 official arc42 sections and says not to remove or rename official sections. The reviewed package uses `## 2. Constraints`; the required section name for the method is `## 2. Architecture Constraints`.

Required outcome: The canonical architecture package must use the project architecture method's official arc42 section heading for section 2 while preserving the current constraint content.

Safe resolution path: Rename `## 2. Constraints` to `## 2. Architecture Constraints`. No owner decision is needed.

Recommendation: Apply the heading-only correction and re-run architecture-review. No ADR change is required.

### AR-002 - canonical architecture path is not reflected in the workflow artifact map

Finding: The canonical architecture package location conflicts with the workflow guide's default architecture artifact location.

Location: `docs/workflows.md` Artifact Locations; `docs/architecture/system/architecture.md`

Severity: material

Evidence: At the time of this review, the workflow guide listed dated architecture and architecture-review paths instead of the canonical architecture package path. The architecture skill uses the canonical package default `docs/architecture/system/architecture.md`, and the reviewed architecture was authored there. Without a workflow-map update, future agents may look for a dated architecture document instead of the canonical package before planning.

Required outcome: The workflow guide must clearly identify `docs/architecture/system/architecture.md` as the canonical architecture package path, while preserving the dated architecture-review record path if that remains the intended review-record convention.

Safe resolution path: Update `docs/workflows.md` so the Architecture row points to `docs/architecture/system/architecture.md`, or add an explicit "Canonical architecture package" row with that path and clarify whether dated files are review records, deltas, or legacy artifacts. No owner decision is needed unless the project owner wants dated architecture documents to be the canonical design surface instead.

Recommendation: Treat `docs/architecture/system/architecture.md` as canonical because the architecture skill and current package already use that convention. Keep this review record at the dated review path from the existing workflow guide.

## Review Dimensions

| Review dimension | Verdict | Notes |
| --- | --- | --- |
| Spec alignment | pass | The architecture covers the approved spec's major machine-changing boundaries: WSL storage, migration, proxy, fstab, sudoers, Neovim, tmux, helpers, validation, and rollback. |
| Package shape | concern | AR-001 requires an arc42 heading correction. |
| Boundary clarity | pass | The Building Block View and C4 container diagram distinguish guides, helpers, config examples, specs/tests, and architecture/ADRs. |
| Data ownership | pass | WSL distro storage, shared data, Linux project code, and generated or modified user-machine state are separated. |
| Interface safety | pass | Fresh install command contract, WSL version gating, migration fallback, and unsupported-option behavior align with R9 and R14. |
| Runtime and failure handling | pass | Runtime flow stops before destructive steps when export, `--location`, `visudo`, or `sudo mount -a` checks fail. |
| Deployment and execution boundaries | pass | Deployment View identifies Windows PowerShell, Ubuntu shell, Neovim runtime, and modified user-machine state. |
| Security/privacy | pass | The architecture calls out destructive migration, sudoers, fstab, proxy fallback, and machine/user state boundaries. |
| Quality and operations | pass | Validation, safety, portability, observability, quality requirements, and risks are present. |
| Testing feasibility | pass | The design gives test-spec enough surfaces for static docs checks, doctor checks, and manual verification. |
| Complexity discipline | pass | The design stays documentation-first with small helpers and avoids a one-command unattended installer. |
| ADR quality | pass | ADRs record status, context, decision, alternatives, consequences, and follow-up for durable decisions. |
| Plan readiness | concern | Planning should wait until AR-001 and AR-002 are resolved and the architecture status can be normalized after re-review. |

## C4, arc42, and ADR Notes

- C4 context and container diagrams exist as separate Mermaid source files.
- Component and deployment diagrams are not required for this first package because section 7 explains execution and modified-state boundaries clearly enough.
- ADR links in the architecture are relevant and resolve to accepted ADRs.
- No ADR update is required for the findings in this review.

## Readiness

Approved for downstream workflow after the canonical architecture status is normalized from `draft` to `approved`. This isolated review does not automatically hand off to planning.
