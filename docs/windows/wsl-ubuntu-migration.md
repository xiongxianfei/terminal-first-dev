# Migrate WSL2 Ubuntu to the project storage location

**Prerequisites:** An existing WSL2 Ubuntu distro named `Ubuntu` contains wanted state, Windows PowerShell can run WSL commands, and `D:\Software\WSL\Ubuntu` has enough free space for the exported VHDX.
**Time:** 20-45 minutes, depending on distro size and disk speed.
**Outcome:** The existing Ubuntu distro is exported, re-registered from `D:\Software\WSL\Ubuntu\ext4.vhdx`, set as default, and launches successfully.
**Verify:** `wsl --list --verbose`, `wsl --set-default Ubuntu`, and `wsl -d Ubuntu` confirm the imported distro, default selection, and launch.
**Scope:** Changes WSL registration for the `Ubuntu` distro and stores the imported VHDX under `D:\Software\WSL\Ubuntu`. Shared data remains under `D:\Data`; Linux-heavy project code should live in the WSL filesystem, such as `~/src`.
**Safety:** `wsl --unregister` is destructive. Do not run it until shutdown, successful backup or export, and export-file verification have succeeded.

## Fast path

1. Confirm the current distro and shut down WSL.

   Run from Windows PowerShell:

   ```powershell
   wsl --list --verbose
   wsl --shutdown
   ```

   Expected result: the `Ubuntu` distro is listed, and WSL shuts down before export.

2. Create the target directory and export the distro.

   Backup/export: the export file is the required recovery source before unregistering the existing distro.

   Run from Windows PowerShell:

   ```powershell
   New-Item -ItemType Directory -Force "D:\Software\WSL\Ubuntu"
   wsl --export Ubuntu D:\Software\WSL\Ubuntu\ext4.vhdx --vhd
   Test-Path "D:\Software\WSL\Ubuntu\ext4.vhdx"
   Get-Item "D:\Software\WSL\Ubuntu\ext4.vhdx"
   ```

   Expected result: export succeeds, and the VHDX exists at `D:\Software\WSL\Ubuntu\ext4.vhdx`.

   If export fails, stop and use [Migration/import-in-place recovery](wsl-troubleshooting.md#migration-import-in-place-recovery).

3. Unregister the old distro only after export verification.

   Backup/export: continue only if the export command succeeded and the VHDX was verified in the previous step. This is the successful backup or export gate for the destructive step.

   Destructive step: the unregister command removes the registered distro and can cause data loss if backup or import verification fails.

   Run from Windows PowerShell:

   ```powershell
   wsl --unregister Ubuntu
   ```

   Expected result: WSL removes the old registration for `Ubuntu`.

4. Import in place, reset the default distro, and launch.

   Run from Windows PowerShell:

   ```powershell
   wsl --import-in-place Ubuntu D:\Software\WSL\Ubuntu\ext4.vhdx
   wsl --set-default Ubuntu
   wsl --list --verbose
   wsl -d Ubuntu
   ```

   Expected result: the imported distro appears in the verbose list, is available as the default Ubuntu distro, and launches successfully.

   If import or launch fails, use [Migration/import-in-place recovery](wsl-troubleshooting.md#migration-import-in-place-recovery).

## Walkthrough

### 1. Confirm the current distro and shut down WSL

This migration/import path is for an existing distro named `Ubuntu`. If the existing distro uses a different name, adapt the distro name only after the owner explicitly chooses that path.

Run from Windows PowerShell:

```powershell
wsl --list --verbose
wsl --shutdown
```

Expected result: the current `Ubuntu` distro appears in the verbose list, and WSL stops before export.

Verify:

```powershell
wsl --list --verbose
```

Expected result: the distro name you intend to migrate is clear before any destructive action.

### 2. Create the target directory and export the distro

Backup/export: the VHDX export is the required backup gate for this guide. Do not proceed to unregister until the export command succeeds and the export file is present.

Run from Windows PowerShell:

```powershell
New-Item -ItemType Directory -Force "D:\Software\WSL\Ubuntu"
wsl --export Ubuntu D:\Software\WSL\Ubuntu\ext4.vhdx --vhd
Test-Path "D:\Software\WSL\Ubuntu\ext4.vhdx"
Get-Item "D:\Software\WSL\Ubuntu\ext4.vhdx"
```

Expected result: `D:\Software\WSL\Ubuntu\ext4.vhdx` exists and has a size consistent with the exported distro.

- Scope: creates or replaces the exported VHDX used for import-in-place recovery.
- Backup: the verified VHDX is the backup/export artifact for this migration.
- Rollback: if export fails, keep the existing registered distro and do not unregister it.

If export fails, use [Migration/import-in-place recovery](wsl-troubleshooting.md#migration-import-in-place-recovery).

### 3. Unregister the old distro only after export verification

Backup/export: continue only after the previous step produced a verified VHDX at `D:\Software\WSL\Ubuntu\ext4.vhdx`.

Destructive step: the unregister command removes the registered distro and can cause data loss if backup or import verification fails.

Run from Windows PowerShell:

```powershell
wsl --unregister Ubuntu
```

Expected result: the old `Ubuntu` registration is removed.

- Scope: changes WSL registration for the `Ubuntu` distro.
- Backup: the verified VHDX remains the recovery source.
- Rollback: preserve the VHDX and use the import step again if registration needs to be recreated.

### 4. Import in place, reset the default distro, and launch

Run from Windows PowerShell:

```powershell
wsl --import-in-place Ubuntu D:\Software\WSL\Ubuntu\ext4.vhdx
wsl --set-default Ubuntu
wsl --list --verbose
wsl -d Ubuntu
```

Expected result: WSL imports the VHDX in place, resets the default distro to `Ubuntu`, lists the imported distro, and launches it.

Verify:

```powershell
wsl --list --verbose
wsl -d Ubuntu
```

Expected result: the imported distro appears in `wsl --list --verbose`, launches successfully, and is the intended default distro after `wsl --set-default Ubuntu`.

If import-in-place fails, preserve `D:\Software\WSL\Ubuntu\ext4.vhdx` and use [Migration/import-in-place recovery](wsl-troubleshooting.md#migration-import-in-place-recovery).

## Rollback

- If export fails, keep the existing registered distro and do not unregister it.
- If unregister has not run, stop and keep the original distro registered.
- If import-in-place fails after unregister, preserve `D:\Software\WSL\Ubuntu\ext4.vhdx`; it is the recovery source.
- If the wrong default distro is selected, reset it with `wsl --set-default <DistroName>` after confirming the intended distro exists.
- If the migrated distro fails to launch, preserve the VHDX and review WSL troubleshooting before another unregister/import cycle.

## Troubleshooting

Use the targeted entry that matches the symptom:

- Export fails or the VHDX is missing: [Migration/import-in-place recovery](wsl-troubleshooting.md#migration-import-in-place-recovery)
- Import-in-place fails: [Migration/import-in-place recovery](wsl-troubleshooting.md#migration-import-in-place-recovery)
- Storage path is unclear: [Storage path checks](wsl-troubleshooting.md#storage-path-checks)
