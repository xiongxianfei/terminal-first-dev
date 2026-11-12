# Install WSL2 Ubuntu in the project storage location

**Prerequisites:** Windows host setup is complete, WSL is available from Windows PowerShell, and you are installing a new Ubuntu distro rather than moving an existing one.
**Time:** 15-30 minutes, depending on download speed and first-run Ubuntu setup.
**Outcome:** An explicit Ubuntu LTS distro is installed under `D:\Software\WSL\Ubuntu` and launches successfully.
**Verify:** `wsl --list --verbose` shows the installed distro, and `wsl -d <UbuntuLtsDistroName>` launches it.
**Scope:** Creates or uses `D:\Software\WSL\Ubuntu` for WSL distro storage. Shared data remains under `D:\Data`; Linux-heavy project code should live inside the WSL filesystem, such as `~/src`.
**Safety:** Stop if local WSL help does not show `--location` after update attempts. Do not silently install to a default location when the custom-location path is unsupported.

## Fast path

1. Confirm local WSL support for custom-location install.

   Run from Windows PowerShell:

   ```powershell
   wsl --version
   wsl --help
   ```

   Expected result: WSL prints version and help output. The help output includes `--install`, `--distribution`, and `--location`.

   If `--location` is missing, use [Unsupported fresh install-location command](wsl-troubleshooting.md#unsupported-fresh-install-location-command).

2. Choose an explicit Ubuntu LTS distro.

   Run from Windows PowerShell:

   ```powershell
   wsl --list --online
   ```

   Expected result: the output lists installable distributions. Choose a versioned Ubuntu LTS name and use it as `<UbuntuLtsDistroName>`.

3. Prepare the project WSL storage parent.

   Backup: not applicable for a new install when the target directory is absent or intentionally empty. Stop if `D:\Software\WSL\Ubuntu` already contains wanted data.

   Run from Windows PowerShell:

   ```powershell
   New-Item -ItemType Directory -Force "D:\Software\WSL"
   Test-Path "D:\Software\WSL\Ubuntu"
   Get-ChildItem "D:\Software\WSL\Ubuntu" -Force
   ```

   Expected result: the parent path exists. The target install directory is absent, empty, or intentionally disposable before installation.

4. Install Ubuntu into the project storage location.

   Run from Windows PowerShell:

   ```powershell
   wsl --install --distribution <UbuntuLtsDistroName> --location "D:\Software\WSL\Ubuntu"
   ```

   Expected result: WSL installs the selected distro into `D:\Software\WSL\Ubuntu` and launches first-run Ubuntu setup.

   If the install download hangs or Store delivery is blocked, use [WSL install download hangs](wsl-troubleshooting.md#wsl-install-download-hangs).

5. Verify launch and registration.

   Run from Windows PowerShell:

   ```powershell
   wsl --list --verbose
   wsl -d <UbuntuLtsDistroName>
   ```

   Expected result: the distro appears in the verbose list and launches successfully.

## Walkthrough

### 1. Confirm local WSL support for custom-location install

The project uses a custom WSL storage path: `D:\Software\WSL\Ubuntu`. Shared Windows/Linux data is separate under `D:\Data`, later exposed in Ubuntu as `/home/<user>/data`. Linux-heavy project code should stay in the WSL filesystem, for example `~/src`, unless you accept mounted-drive performance tradeoffs.

Run from Windows PowerShell:

```powershell
wsl --version
wsl --help
```

Expected result: WSL prints the installed WSL version and help output that includes `--install`, `--distribution`, and `--location`.

Verify:

```powershell
wsl --help
```

Expected result: the local WSL command documents the required install options.

If `--location` is missing, update WSL and re-check:

```powershell
wsl --update
wsl --shutdown
wsl --help
```

Expected result: WSL updates, restarts cleanly, and the help output includes `--location`.

If Microsoft Store delivery is blocked or unreliable, use the web-download update path:

```powershell
wsl --update --web-download
wsl --shutdown
wsl --version
```

Expected result: WSL updates through web download and reports the updated version.

If `--location` is still missing, stop the fresh custom-location path and use [Unsupported fresh install-location command](wsl-troubleshooting.md#unsupported-fresh-install-location-command). Do not publish or use an ambiguous positional install-location form as the primary command.

### 2. Choose an explicit Ubuntu LTS distro

Run from Windows PowerShell:

```powershell
wsl --list --online
```

Expected result: WSL lists installable distributions.

Use `<UbuntuLtsDistroName>` as the selected explicit Ubuntu LTS distro name from that output. Exact labels are examples only; prefer a versioned LTS package when one is available instead of relying only on a mutable `Ubuntu` label.

If distro installation hangs at download time or Store delivery is blocked later, the same selected name is used with the web-download install path.

### 3. Prepare the project WSL storage parent

Backup: not applicable when creating a new absent or intentionally empty install target. If `D:\Software\WSL\Ubuntu` exists and contains wanted data, stop and choose the migration guide or another recovery path.

Run from Windows PowerShell:

```powershell
New-Item -ItemType Directory -Force "D:\Software\WSL"
Test-Path "D:\Software\WSL\Ubuntu"
Get-ChildItem "D:\Software\WSL\Ubuntu" -Force
```

Expected result: the parent directory exists, and the target install directory is absent, empty, or intentionally disposable.

- Scope: this prepares WSL distro storage only.
- Backup: no backup is required for a new empty target; existing wanted data must be preserved outside this guide before continuing.
- Rollback: remove the new empty target only after confirming it contains no wanted data.

### 4. Install Ubuntu into the project storage location

Run from Windows PowerShell:

```powershell
wsl --install --distribution <UbuntuLtsDistroName> --location "D:\Software\WSL\Ubuntu"
```

Expected result: WSL installs the selected Ubuntu LTS distro into `D:\Software\WSL\Ubuntu` and launches first-run Ubuntu setup.

If Store delivery is blocked or the download hangs, retry with web download:

```powershell
wsl --install --web-download --distribution <UbuntuLtsDistroName> --location "D:\Software\WSL\Ubuntu"
```

Expected result: WSL uses the web-download path while preserving the same explicit distro and install location.

If this still fails, use [WSL install download hangs](wsl-troubleshooting.md#wsl-install-download-hangs).

### 5. Verify launch and registration

Run from Windows PowerShell:

```powershell
wsl --list --verbose
wsl -d <UbuntuLtsDistroName>
```

Expected result: the installed distro appears in the verbose list and launches successfully.

Record:

- WSL version from `wsl --version`;
- selected Ubuntu LTS distro name from `wsl --list --online`;
- `wsl --list --verbose` output;
- the best available non-destructive storage-location check for the current WSL version.

If storage is unclear, use [Storage path checks](wsl-troubleshooting.md#storage-path-checks).

## Rollback

- If install fails before a distro is registered, remove the incomplete `D:\Software\WSL\Ubuntu` directory only after confirming no wanted data is inside.
- If the distro installs but is wrong or incomplete, use the migration guide only after you have export or backup coverage for any wanted data.
- If the wrong distro becomes default, reset it from the migration guide's default-distro step after the intended distro exists.

## Troubleshooting

Use the targeted entry that matches the symptom:

- WSL help does not show `--location`: [Unsupported fresh install-location command](wsl-troubleshooting.md#unsupported-fresh-install-location-command)
- WSL update fails through Store delivery: [WSL update fails through Microsoft Store](wsl-troubleshooting.md#wsl-update-fails-through-microsoft-store)
- WSL install download hangs: [WSL install download hangs](wsl-troubleshooting.md#wsl-install-download-hangs)
- Storage path is unclear: [Storage path checks](wsl-troubleshooting.md#storage-path-checks)
