# M3 Implementation Evidence: WSL Install and Migration Split

## Milestone

Milestone: M3

## Command inventory:

Fresh-install commands moved from `docs/guides/02-wsl2-ubuntu.md` to `docs/guides/wsl-ubuntu-install.md`:

- `wsl --version`
- `wsl --help`
- `wsl --list --online`
- `New-Item -ItemType Directory -Force "D:\Software\WSL"`
- `Test-Path "D:\Software\WSL\Ubuntu"`
- `Get-ChildItem "D:\Software\WSL\Ubuntu" -Force`
- `wsl --install --distribution <UbuntuLtsDistroName> --location "D:\Software\WSL\Ubuntu"`
- `wsl --update`
- `wsl --shutdown`
- `wsl --update --web-download`
- `wsl --install --web-download --distribution <UbuntuLtsDistroName> --location "D:\Software\WSL\Ubuntu"`
- `wsl --list --verbose`
- `wsl -d <UbuntuLtsDistroName>`

Migration commands moved from `docs/guides/02-wsl2-ubuntu.md` to `docs/guides/wsl-ubuntu-migration.md`:

- `wsl --list --verbose`
- `wsl --shutdown`
- `New-Item -ItemType Directory -Force "D:\Software\WSL\Ubuntu"`
- `wsl --export Ubuntu D:\Software\WSL\Ubuntu\ext4.vhdx --vhd`
- `Test-Path "D:\Software\WSL\Ubuntu\ext4.vhdx"`
- `Get-Item "D:\Software\WSL\Ubuntu\ext4.vhdx"`
- `wsl --unregister Ubuntu`
- `wsl --import-in-place Ubuntu D:\Software\WSL\Ubuntu\ext4.vhdx`
- `wsl --set-default Ubuntu`
- `wsl -d Ubuntu`

## Fast-path/walkthrough parity:

Fresh install and migration both keep the same high-level order in fast path and walkthrough. The walkthrough adds context, fallback, backup/export, and verification detail without introducing a different task flow.

## Backup/export-before-unregister coverage:

`docs/guides/wsl-ubuntu-migration.md` places backup/export guidance before the unregister step in both fast path and walkthrough. The unregister step is labelled destructive before the first literal unregister command appears.

## Command-context coverage:

Every WSL command block in both task guides is introduced with Windows PowerShell context. The compatibility stub contains no setup command blocks.

## Expected-result coverage:

Meaningful command groups in both task guides include nearby `Expected result:` text. Verification steps include the expected registration, default-distro, and launch signals.

## Compatibility-stub result:

`docs/guides/02-wsl2-ubuntu.md` remains present as a compatibility path. It routes by starting state to `wsl-ubuntu-install.md` or `wsl-ubuntu-migration.md` and does not duplicate setup, install, import, export, unregister, or migration commands.

## Router result:

`docs/guides/README.md` routes fresh workstation setup to `wsl-ubuntu-install.md`, exposes `wsl-ubuntu-migration.md` as the migration task guide, and retains `02-wsl2-ubuntu.md` as the old-link compatibility path.

## Troubleshooting-anchor result:

New WSL task guides link to existing WSL troubleshooting anchors for unsupported install-location support, update/download failure, migration/import-in-place recovery, and storage path checks. The rollout proof validates those anchors.

## High-risk command review:

Reviewed the WSL fresh-install and migration command contracts against `specs/terminal-first-workstation-setup.md`. The primary fresh-install command remains the explicit long-option form, the positional install-location form is not published as the primary command, migration still shuts down before export, and unregister remains gated behind successful export verification.

## Setup command execution: not executed

No WSL setup, install, unregister, import, export, package installation, or machine-changing command was executed during M3 implementation. Validation was static and review-based.
