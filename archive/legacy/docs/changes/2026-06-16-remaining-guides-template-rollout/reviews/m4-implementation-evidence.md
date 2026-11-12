# M4 Implementation Evidence: Verification Guide and Router Proof Surface

## Milestone

Milestone: M4

## Verification target inventory:

Created `docs/changes/2026-06-16-remaining-guides-template-rollout/verification-target-inventory.md` with active verification references, compatibility paths, unresolved verification follow-ups, and first smaller-guide sequencing evidence.

## Active-reference result:

`docs/guides/99-verification.md` actively links only to guide paths that exist after M4: Windows host, WSL install, WSL migration, proxy setup, Neovim, tmux, and uv.

## Unresolved-follow-up result:

Ubuntu baseline, WSL config, data mount, locale, and sudo targets remain unresolved follow-ups because their task-scoped or converted guide paths are not active in this slice. The verification matrix names them as unresolved follow-ups instead of active converted-guide links.

## First-slice sequencing result:

The inventory records that `docs/guides/99-verification.md` was not converted in M1. M1 converted only tmux, Neovim, and uv.

## Result-vocabulary coverage:

The converted verification guide preserves `pass`, `fail`, `skipped`, and `needs manual action` in both prose and the verification matrix.

## Command-context coverage:

Verification command blocks are introduced with their execution context: Ubuntu, Windows PowerShell, inside Neovim, or availability-limited local checks.

## Expected-result coverage:

Each major verification command group includes nearby `Expected result:` text.

## Static-link result:

The rollout proof checks active guide paths, converted-guide structure, troubleshooting links, inventory presence, and unresolved-follow-up handling.

## Setup command execution: not executed

No workstation setup command blocks were executed during M4 implementation. Validation was static and review-based.
