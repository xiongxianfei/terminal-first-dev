# M2 Implementation Evidence: Windows Host Guide

- Milestone: M2
- Guide path: `docs/guides/01-windows-host.md`
- Reviewer: implementation pass before code-review
- Review mode: static diff review and proof-script validation
- Setup command execution: not executed

## Command inventory:

- Preserved PowerShell install and update commands through WinGet.
- Preserved host verification commands for `pwsh`, WinGet, Windows Terminal, and WSL.
- Preserved `wsl --status` fallback when `wsl --version` is unavailable.
- Preserved PowerShell profile inspection, creation, Notepad edit, PSReadLine Emacs-mode append, edit-mode verification, and WinGet uninstall rollback command.

## Fast-path/walkthrough parity:

- Result: pass.
- Evidence: both sections install or update PowerShell, verify host tooling, and keep the optional PSReadLine profile change separate from required host verification.

## Backup-before-edit coverage:

- Result: pass.
- Evidence: optional profile editing includes backup guidance before writing `$PROFILE`; install and verification commands do not edit user-owned files directly.

## Command-context coverage:

- Result: pass.
- Evidence: PowerShell commands are introduced with Windows PowerShell context, and manual verification/state recording is separated from commands.

## Expected-result coverage:

- Result: pass.
- Evidence: install, update, verification, profile, PSReadLine, and rollback commands have nearby expected-result text.

## Policy/elevation coverage:

- Result: pass.
- Evidence: the guide calls out package-manager prompts, administrator elevation, WinGet/Microsoft Store/App Installer policy, WSL availability policy, and enterprise package-source restrictions near the affected commands.

## Troubleshooting-anchor result:

- Result: pass.
- Evidence: introduced troubleshooting links target existing `enterprise-policy.md` and `wsl.md#wsl-update-fails-through-microsoft-store` anchors.

## Security/privacy result:

- Result: pass.
- Evidence: the guide warns against storing proxy credentials, tokens, private hostnames, or certificate material in the PowerShell profile and includes no credential-like examples.

## Follow-ups:

None for M2.
