# Verification Target Inventory

## Purpose

Record which setup-guide paths `docs/guides/99-verification.md` actively references after the M4 conversion, and which verification targets remain unresolved follow-ups instead of active links.

## First smaller-guide sequencing

`docs/guides/99-verification.md` was not converted in M1. M1 converted only `docs/guides/05-tmux.md`, `docs/guides/04-neovim.md`, and `docs/guides/06-uv.md`.

## Active verification references

| Verification target | Referenced path | Exists after M4 | Converted or compatibility state | Notes |
| --- | --- | --- | --- | --- |
| Windows host | `docs/guides/01-windows-host.md` | yes | converted guide | Active verification link. |
| WSL Ubuntu fresh install | `docs/guides/wsl-ubuntu-install.md` | yes | converted guide | Active verification link. |
| WSL Ubuntu migration | `docs/guides/wsl-ubuntu-migration.md` | yes | converted guide | Active verification link. |
| Proxy setup | `docs/guides/proxy-setup.md` | yes | converted guide | Active verification link. |
| Neovim setup | `docs/guides/04-neovim.md` | yes | converted guide | Active verification link. |
| tmux setup | `docs/guides/05-tmux.md` | yes | converted guide | Active verification link. |
| uv setup | `docs/guides/06-uv.md` | yes | converted optional guide | Active verification link. |

## Compatibility paths

| Compatibility path | Exists after M4 | Verification handling |
| --- | --- | --- |
| `docs/guides/02-wsl2-ubuntu.md` | yes | Retained for old links only; verification uses the install and migration task guides instead. |

## Unresolved verification follow-ups

| Verification target | Path or future path | Reason | Current handling |
| --- | --- | --- | --- |
| Ubuntu baseline | `docs/guides/03-ubuntu-baseline.md` | Existing guide is not converted in this rollout slice. | Listed as an unresolved follow-up and not presented as an active converted-guide verification link. |
| WSL config | `docs/guides/03-ubuntu-baseline.md` or future task guide | Owned by the unconverted Ubuntu baseline area. | Listed as an unresolved follow-up in the verification matrix. |
| data mount | future `data-mount-setup.md` | Task-scoped guide not created yet. | Listed as an unresolved follow-up in the verification matrix. |
| locale | future Ubuntu baseline task guide | Task-scoped guide not created yet. | Listed as an unresolved follow-up in the verification matrix. |
| sudo | future Ubuntu baseline task guide | Task-scoped guide not created yet. | Listed as an unresolved follow-up in the verification matrix. |

## Static proof

`tests/markdown/remaining-guides-template-rollout.test.sh` checks that each active referenced guide path exists after M4, that `docs/guides/99-verification.md` preserves the result vocabulary, and that unresolved Ubuntu baseline targets are not active verification links.
