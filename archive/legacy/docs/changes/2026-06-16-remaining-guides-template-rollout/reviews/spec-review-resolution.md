# Review Resolution: Remaining Guides Template Rollout

## RGT-SR-001 - Verification guide sequencing is ambiguous

- Finding ID: RGT-SR-001
- Disposition: addressed
- Resolution date: 2026-06-16
- Changed artifact: `specs/remaining-guides-template-rollout.md`

### Resolution

Revised `R58` so `docs/guides/99-verification.md` is not converted in the first smaller-guide slice and is converted only when every active setup-guide path it references exists after the same change, or when missing or not-yet-converted targets are recorded as unresolved verification follow-ups instead of active references.

Added glossary definitions for active verification references, unresolved verification follow-ups, and verification target inventory.

Added `R75`, observability coverage, and `AC21` requiring a verification target inventory and static or review evidence for missing or not-yet-converted verification targets.

### Verification

- `R58` no longer contains `enough stable targets`.
- The spec defines active verification references, unresolved verification follow-ups, and verification target inventory evidence.
- Acceptance coverage makes `99-verification.md` sequencing observable.

### Status

addressed

Second-pass spec-review approved the disposition on 2026-06-16. No owner decision is needed.
