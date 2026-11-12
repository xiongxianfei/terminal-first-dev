# Proposal Review: Best-Practice How-To Guide Template

## Result

- Skill: proposal-review
- Review status: approved
- Material findings: none
- Recording status: recorded
- Recording blocker: none
- Review record: `docs/changes/2026-06-15-how-to-guide-template-best-practices/reviews/proposal-review.md`
- Review log: not-required; this proposal review is the stage-owned review record under the change pack
- Review resolution: not-required
- Open blockers: none
- Immediate next stage: isolated stop; next valid lifecycle stage is `spec` if the owner accepts the proposal direction

## Material Findings

None.

## Review Dimensions

- Problem clarity: pass. The proposal frames the concrete authoring drift problem before recommending a template, especially around shell context, expected results, rollback, and troubleshooting placement.
- User value: pass. The value is specific to quick, auditable Windows + WSL setup guidance and preserving safe command execution.
- Option diversity: pass. The proposal compares reviewer judgment, headings-only template, strict template, conditional template, generated tooling, and exemplar-only guidance.
- Decision rationale: pass. Option D follows from the stated need to balance consistency with lightweight authoring.
- Scope control: pass. Non-goals keep guide rewrites, command contracts, generated tooling, command execution CI, and tutorials out of this proposal.
- Architecture awareness: pass. The proposal limits impact to documentation architecture and names the template, guide, troubleshooting, spec, and test boundaries.
- Testability: pass. Static checks, review checks, reference exemplar review, portability pilot, and fast-path-only validation are defined at proposal depth.
- Risk honesty: pass. The risk table covers template weight, drift, shell ambiguity, vague expected results, broken troubleshooting links, security-sensitive examples, and premature CI.
- Rollout realism: pass. The rollout uses proposal review, downstream spec, template update, exemplar review, portability pilot, then broader application.
- Readiness for spec: pass. Open questions do not block specification; the downstream spec has clear subjects to define.

## Scope Preservation Review

- Scope-preservation result: pass.
- The proposal preserves the initial direction to continue from the accepted two-speed guide proposal, use the changed `proxy-setup.md` as evidence, improve the reusable template, keep troubleshooting separate, optimize for quick configuration, avoid tutorials, and defer heavyweight validation.
- The later review concerns are also preserved: `proxy-setup.md` is now a reference exemplar, `docs/guides/03-ubuntu-baseline.md` is the portability pilot, exemplar-only guidance is an explicit rejected option, and fast-path-only validation has reviewer, environment, and success criteria.
- Scope budget is present and clear for core work, first-slice candidates, separate implementation slices, deferable follow-ups, and out-of-scope work.

## Recommended Proposal Edits

- Recommended edits: none required before spec.

## Recommendation

- Recommendation: approved for downstream specification. The proposal is ready to normalize from `draft` to `accepted` if the owner accepts the direction; no automatic handoff is performed by this review.
