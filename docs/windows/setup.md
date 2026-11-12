# Prepare the Windows host

**Prerequisites:** Windows 11 is available, and Windows PowerShell can open as the current user.
**Time:** 10-15 minutes, plus any organization approval time for blocked package sources.
**Outcome:** Windows Terminal, PowerShell, WinGet, and WSL availability are visible before WSL or Ubuntu setup continues.
**Verify:** `pwsh --version`, `winget --version`, `wt --version`, and `wsl --version` or `wsl --status` report the host state.
**Scope:** Windows host baseline for terminal-first setup.
**Safety:** Package-manager and WSL commands may prompt for administrator elevation or be blocked by enterprise policy. Do not run all install commands from an elevated shell by default.

## Fast path

1. Install or update PowerShell.

   Run from Windows PowerShell:

   ```powershell
   winget install --id Microsoft.PowerShell --source winget
   ```

   Expected result: WinGet installs PowerShell or reports that it is already installed. The command may prompt for elevation or be blocked by enterprise policy.

   If PowerShell is already installed with WinGet, update it through the same package path:

   ```powershell
   winget upgrade --id Microsoft.PowerShell --source winget
   ```

   Expected result: WinGet upgrades PowerShell or reports that no applicable update is available.

2. Verify host tooling.

   Run from Windows PowerShell:

   ```powershell
   pwsh --version
   winget --version
   wt --version
   wsl --version
   ```

   Expected result: PowerShell, WinGet, Windows Terminal, and WSL report versions.

   If `wsl --version` is unavailable, run:

   ```powershell
   wsl --status
   ```

   Expected result: WSL reports status information, or the failure can be recorded as `needs manual action`.

3. Optionally set PSReadLine to Emacs mode.

   Backup: if the PowerShell profile already exists, save a copy before editing it.

   Run from Windows PowerShell:

   ```powershell
   New-Item -ItemType File -Force $PROFILE
   Add-Content -Path $PROFILE -Value 'Set-PSReadLineOption -EditMode Emacs'
   ```

   Expected result: the current user's PowerShell profile contains the PSReadLine edit-mode setting.

   Verify in a new PowerShell session:

   ```powershell
   Get-PSReadLineOption | Select-Object -ExpandProperty EditMode
   ```

   Expected result: `Emacs`.

## Walkthrough

### 1. Install or update PowerShell

Use PowerShell as the Windows-side control shell for host setup, WSL commands, and Windows package checks. Use the latest stable `pwsh` for daily work, while keeping Windows PowerShell available for compatibility.

The primary path on unmanaged Windows 11 clients is WinGet. Package-manager commands may prompt for administrator elevation or be blocked by enterprise policy.

Run from Windows PowerShell:

```powershell
winget install --id Microsoft.PowerShell --source winget
```

Expected result: WinGet installs PowerShell or reports that it is already installed.

If PowerShell is already installed with WinGet, update it through the same package path:

```powershell
winget upgrade --id Microsoft.PowerShell --source winget
```

Expected result: WinGet upgrades PowerShell or reports that no applicable update is available.

If `winget` is unavailable or blocked, use the policy-approved manual package path for the machine and record the source used in verification notes. If package source or Store/App Installer policy blocks the command, use [Enterprise policy issues](#enterprise-policy-troubleshooting).

### 2. Verify host tooling

Run from Windows PowerShell:

```powershell
pwsh --version
winget --version
wt --version
wsl --version
```

Expected result:

- `pwsh --version` reports the installed PowerShell version.
- `winget --version` reports WinGet availability or identifies a policy/manual fallback.
- `wt --version` reports Windows Terminal availability.
- `wsl --version` reports WSL availability.

If `wsl --version` is unavailable, run:

```powershell
wsl --status
```

Expected result: WSL reports status information, or the failure can be recorded as `needs manual action` in the verification guide.

Record whether Windows Terminal, PowerShell, WinGet, and WSL are available. Mark blocked policy or missing package-source cases as `needs manual action` in the consolidated verification guide.

### 3. Keep the Windows-side shell posture reversible

Recommended posture:

- Start normal shells without elevation; open an elevated shell only when a command needs administrator rights.
- Keep execution policy unchanged unless an organization-approved installer or script explicitly requires a temporary bypass.
- Keep local profile files small, readable, and reversible.
- Put machine-specific aliases, functions, and environment variables in the user profile, not in project docs or committed files.
- Do not store proxy credentials, tokens, private hostnames, or certificate material in a PowerShell profile.

Check the current user's PowerShell profile path:

```powershell
$PROFILE
Test-Path $PROFILE
Get-ExecutionPolicy -List
```

Expected result: PowerShell prints the profile path, whether it exists, and the effective execution policies.

Open the current user's PowerShell profile:

```powershell
notepad $PROFILE
```

Expected result: Notepad opens the profile if it already exists.

Create it first if it does not exist:

```powershell
New-Item -ItemType File -Force $PROFILE
notepad $PROFILE
```

Expected result: PowerShell creates the profile file and opens it in Notepad.

### 4. Optionally set PSReadLine to Emacs mode

This optional profile change affects only the current user's PowerShell command-line editing behavior.

- Scope: writes the current user's PowerShell profile.
- Backup: if the PowerShell profile already exists, save a copy before editing it.
- Rollback: remove the `Set-PSReadLineOption -EditMode Emacs` line from `$PROFILE`, or replace `Emacs` with another PSReadLine edit mode such as `Windows` or `Vi`.

Run from Windows PowerShell:

```powershell
Add-Content -Path $PROFILE -Value 'Set-PSReadLineOption -EditMode Emacs'
```

Expected result: the profile contains the PSReadLine edit-mode setting.

Open a new PowerShell session and verify the active edit mode:

```powershell
Get-PSReadLineOption | Select-Object -ExpandProperty EditMode
```

Expected result: `Emacs`.

When testing a profile change, open a new PowerShell session and verify that `pwsh --version`, `winget --version`, and `wsl --version` still work.

### 5. Remove PowerShell only through the approved package path

This rollback command may prompt for elevation and may be blocked by enterprise policy.

Run from Windows PowerShell only if PowerShell was installed through WinGet and must be removed:

```powershell
winget uninstall --id Microsoft.PowerShell --source winget
```

Expected result: WinGet removes the package or reports that the package is not installed.

If a manual installer or enterprise-managed package path was used, use that same channel for rollback.

## Rollback

Rollback: this guide does not change execution policy or Windows Terminal settings.

- For optional profile changes, restore the backed-up profile or remove the added `Set-PSReadLineOption -EditMode Emacs` line.
- If PowerShell was installed through WinGet and must be removed, use `winget uninstall --id Microsoft.PowerShell --source winget`.
- If a manual installer or enterprise-managed package path was used, use that same channel for rollback.

## Troubleshooting

Use the targeted entry that matches the symptom:

- WinGet, Microsoft Store/App Installer, WSL availability, Windows Terminal, or package sources are blocked by policy: [Enterprise policy issues](#enterprise-policy-troubleshooting)
- WSL update or availability checks fail through network policy: [WSL update fails through Microsoft Store](wsl-troubleshooting.md#wsl-update-fails-through-microsoft-store)

## Enterprise Policy Troubleshooting

### Purpose

Track setup areas that may be blocked or changed by managed Windows policy.

### Current scope

M1 records this placeholder so the guide has a stable destination for policy caveats. Later milestones will add concrete notes for WinGet, App Installer, Store access, WSL feature availability, package sources, proxy behavior, corporate certificate trust, and elevation prompts.

### Safety notes

Do not work around organization policy without approval from the device owner or administrator.

If WSL HTTPS fails because Ubuntu does not trust a corporate root certificate, use the manual certificate export/import path in `docs/networking/proxy.md` only when the device owner or administrator allows copying Windows-managed trust roots into WSL.
