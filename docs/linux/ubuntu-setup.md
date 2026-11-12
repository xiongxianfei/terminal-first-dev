# Configure the Ubuntu baseline

> Applies to Ubuntu in WSL2. Windows drives, `.wslconfig`, and `/etc/wsl.conf` are not general native-Linux defaults.

**Prerequisites:** WSL2 Ubuntu is installed; you can open Windows PowerShell and Ubuntu; local policy allows you to review WSL, fstab, APT, locale, and sudo changes before running them.
**Time:** 30-45 minutes, depending on which optional sections apply.
**Outcome:** Ubuntu has reviewed proxy posture, WSL startup config, optional APT source posture, shared data access, UTF-8 locale readiness, and optional passwordless sudo status.
**Verify:** `locale charmap`, `apt-cache policy` when APT sources are changed, `findmnt "$HOME/data"` when shared data is configured, and `sudo -n true` only when passwordless sudo is intentionally enabled.
**Scope:** User-local Windows WSL config plus machine-wide Ubuntu files under `/etc` when those optional steps are applied.
**Safety:** This guide can affect WSL startup, package sources, mounts, proxy behavior, sudoers policy, and locale state. Review each backup and rollback note before editing.

## Fast path

1. Configure WSL automatic proxy mirroring when local policy supports it.

   Safety: this writes the current Windows user's WSL global config file.

   Scope: user-local WSL global configuration for the Windows account.

   Backup: if `%UserProfile%\.wslconfig` already exists, save a copy before editing it.

   Rollback: remove the project-owned `autoProxy=true` entry or restore the backup, then restart WSL.

   Run from Windows PowerShell:

   ```powershell
   notepad $env:USERPROFILE\.wslconfig
   ```

   Expected result: Notepad opens `%UserProfile%\.wslconfig`.

   Add or verify this configuration snippet in `%UserProfile%\.wslconfig`:

   ```ini
   [wsl2]
   autoProxy=true
   ```

   Expected result: `%UserProfile%\.wslconfig` contains `[wsl2]` and `autoProxy=true`.

   If automatic proxy mirroring is unavailable or blocked by enterprise policy, use [automatic proxy mirroring does not work](../networking/proxy.md#automatic-proxy-mirroring-does-not-work). If a manual proxy fallback would require credentials, read [manual proxy fallback cautions](../networking/proxy.md#manual-proxy-fallback-cautions) before entering anything in a shell.

2. Apply Ubuntu WSL startup posture.

   Safety: `/etc/wsl.conf` affects Ubuntu startup behavior.

   Scope: machine-wide inside the Ubuntu distro.

   Backup: back up `/etc/wsl.conf` before editing it.

   Rollback: restore the backup or remove the project-owned entries, then shut down and restart WSL from Windows PowerShell.

   Run from Ubuntu shell:

   ```bash
   sudo cp -a /etc/wsl.conf "/etc/wsl.conf.backup.$(date +%Y%m%d%H%M%S)" 2>/dev/null || true
   ```

   Expected result: an existing `/etc/wsl.conf` is copied to a timestamped backup, or the command exits successfully when no file exists.

   Edit `/etc/wsl.conf` from Ubuntu shell:

   ```ini
   [automount]
   enabled=false
   mountFsTab=true

   [interop]
   enabled=true
   appendWindowsPath=false
   ```

   Expected result: `/etc/wsl.conf` contains the project-owned automount and interop posture.

3. Optionally configure APT source posture.

   Safety: APT source changes affect package installation inside Ubuntu. Configure APT only when the default source is unsuitable.

   Scope: machine-wide inside the Ubuntu distro.

   Backup: back up current APT source files before editing them.

   Rollback: restore the backup or revert the `URIs:` value, then rerun `sudo apt update`.

   Run from Ubuntu shell:

   ```bash
   grep -RhvE '^\s*(#|$)' /etc/apt/sources.list /etc/apt/sources.list.d/*.list /etc/apt/sources.list.d/*.sources 2>/dev/null || true
   sudo mkdir -p /etc/apt/backup-terminal-first
   sudo cp -a /etc/apt/sources.list /etc/apt/sources.list.d /etc/apt/backup-terminal-first/ 2>/dev/null || true
   ```

   Expected result: current APT sources are visible for review, and current source files are copied to `/etc/apt/backup-terminal-first/` when they exist.

   On Ubuntu 24.04, prefer editing Deb822 source files under `/etc/apt/sources.list.d/` when they exist. Run from Ubuntu shell:

   ```bash
   sudoedit /etc/apt/sources.list.d/ubuntu.sources
   ```

   Expected result: the Ubuntu source file opens in a sudo-safe editor.

   Change only the `URIs:` value to the policy-approved mirror. Example:

   ```text
   URIs: https://archive.ubuntu.com/ubuntu/
   ```

   Expected result: the source file points to the selected policy-approved mirror.

   Run from Ubuntu shell:

   ```bash
   sudo apt update
   apt-cache policy
   ```

   Expected result: package indexes refresh successfully, and `apt-cache policy` shows the expected source priorities.

4. Configure shared data access if this machine uses `D:\Data`.

   Safety: `/etc/fstab` mistakes can affect mount behavior.

   Scope: machine-wide inside the Ubuntu distro.

   Backup: back up `/etc/fstab` before editing it.

   Rollback: remove the project-owned `D:/Data` entry or restore the backup, then run `sudo mount -a` again.

   Run from Ubuntu shell:

   ```bash
   sudo cp -a /etc/fstab "/etc/fstab.backup.$(date +%Y%m%d%H%M%S)"
   mkdir -p "$HOME/data"
   ```

   Expected result: `/etc/fstab` has a timestamped backup and `$HOME/data` exists.

   Add the fstab entry from Ubuntu shell, replacing `<user>` with the Ubuntu username before writing it:

   ```fstab
   D:/Data /home/<user>/data drvfs metadata,uid=1000,gid=1000,umask=022,fmask=011,case=off 0 0
   ```

   Expected result: `/etc/fstab` contains the project-owned `D:/Data` entry for the Ubuntu user.

   Run from Ubuntu shell:

   ```bash
   sudo mount -a
   findmnt "$HOME/data"
   ```

   Expected result: `findmnt` reports a mount for `$HOME/data`.

5. Verify locale readiness.

   Run from Ubuntu shell:

   ```bash
   locale
   locale charmap
   ```

   Expected result: `locale charmap` reports `UTF-8`, and `locale` output has no warnings.

   If repair is needed, run from Ubuntu shell:

   ```bash
   sudo update-locale LANG=C.UTF-8 LC_ALL=
   exec "$SHELL" -l
   locale
   locale charmap
   ```

   Expected result: a new login shell reports a warning-free UTF-8 locale.

6. Optionally enable passwordless sudo for a personal workstation.

   Safety: passwordless sudo weakens local safety because commands can elevate without an interactive password prompt. Skip this step unless the convenience tradeoff is intentional.

   Scope: machine-wide inside the Ubuntu distro for the named Ubuntu user.

   Backup: if `/etc/sudoers.d/terminal-first-windows-dev` already exists, save a copy before replacing it.

   Rollback: remove `/etc/sudoers.d/terminal-first-windows-dev`, validate with `visudo`, and verify that `sudo -n true` no longer succeeds unless another policy allows it.

   Run from Ubuntu shell:

   ```bash
   test ! -e /etc/sudoers.d/terminal-first-windows-dev || sudo cp -a /etc/sudoers.d/terminal-first-windows-dev "/etc/sudoers.d/terminal-first-windows-dev.backup.$(date +%Y%m%d%H%M%S)"
   printf '%s\n' "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/terminal-first-windows-dev >/dev/null
   sudo chmod 0440 /etc/sudoers.d/terminal-first-windows-dev
   sudo visudo -cf /etc/sudoers.d/terminal-first-windows-dev
   ```

   Expected result: `visudo` reports that the project-owned sudoers drop-in parses correctly.

   Run from Ubuntu shell:

   ```bash
   sudo -n true
   ```

   Expected result: the command exits successfully only when passwordless sudo is intentionally enabled.

7. Check doctor status expectations.

   Expected result: future doctor checks for this layer report only `pass`, `fail`, `skipped`, or `needs manual action` for WSL config, proxy, data mount, locale, and sudo.

## Walkthrough

### 1. Configure WSL automatic proxy mirroring

Use WSL automatic proxy mirroring as the primary proxy path when the installed WSL version and local policy support it. Manual proxy environment variables such as `http_proxy`, `https_proxy`, and `no_proxy` are fallback-only; do not paste proxy credentials into shell history.

Safety: `%UserProfile%\.wslconfig` affects WSL behavior for the current Windows user.

Target path: `%UserProfile%\.wslconfig`

Backup: if `%UserProfile%\.wslconfig` already exists, save a copy before editing it.

Rollback: remove the project-owned `autoProxy=true` entry or restore the backup, then restart WSL.

Scope: user-local WSL global configuration for the Windows account.

Run from Windows PowerShell:

```powershell
notepad $env:USERPROFILE\.wslconfig
```

Expected result: Notepad opens `%UserProfile%\.wslconfig`.

Add or verify this configuration snippet in `%UserProfile%\.wslconfig`:

```ini
[wsl2]
autoProxy=true
```

Expected result: `%UserProfile%\.wslconfig` contains `[wsl2]` and `autoProxy=true`.

Run from Windows PowerShell after changing `.wslconfig`:

```powershell
wsl --shutdown
```

Expected result: WSL shuts down without an error. Launch Ubuntu again before continuing.

If automatic proxy mirroring is unavailable or blocked by enterprise policy, use [automatic proxy mirroring does not work](../networking/proxy.md#automatic-proxy-mirroring-does-not-work). PAC files remain a known limitation for the first implementation slice. Corporate CA certificate installation is troubleshooting-only and manual; corporate CA recovery belongs in [WSL SSL certificate trust fails](../networking/proxy.md#wsl-ssl-certificate-trust-fails).

### 2. Apply Ubuntu WSL startup posture

Use `.wslconfig` for WSL 2 global settings owned by the Windows user. Use `/etc/wsl.conf` for Ubuntu-distro settings. Keep automatic Windows drive mounting disabled when this guide owns the shared-data path, and keep `appendWindowsPath=false` to avoid unexpected Windows command precedence inside Ubuntu.

Safety: `/etc/wsl.conf` affects Ubuntu startup behavior.

Target path: `/etc/wsl.conf`

Backup: back up `/etc/wsl.conf` before editing it.

Rollback: restore the backup or remove the project-owned entries, then shut down and restart WSL from Windows PowerShell.

Scope: machine-wide inside the Ubuntu distro.

Run from Ubuntu shell:

```bash
sudo cp -a /etc/wsl.conf "/etc/wsl.conf.backup.$(date +%Y%m%d%H%M%S)" 2>/dev/null || true
```

Expected result: an existing `/etc/wsl.conf` is copied to a timestamped backup, or the command exits successfully when no file exists.

Edit `/etc/wsl.conf` from Ubuntu shell:

```ini
[automount]
enabled=false
mountFsTab=true

[interop]
enabled=true
appendWindowsPath=false
```

Expected result: `/etc/wsl.conf` contains the project-owned automount and interop posture.

Run from Windows PowerShell:

```powershell
wsl --shutdown
```

Expected result: WSL shuts down without an error. Launch Ubuntu again before continuing.

### 3. Optionally configure APT source posture

Ubuntu package sources may be slow, blocked, or redirected by enterprise policy. Configure APT only when the default source is unsuitable. This is the APT source configuration step for the Ubuntu baseline. Do not commit private mirror hostnames.

Safety: APT source changes affect package installation inside Ubuntu.

Backup: back up current APT source files before editing them.

Rollback: restore the backup or revert the `URIs:` value, then rerun `sudo apt update`.

Scope: machine-wide inside the Ubuntu distro.

Run from Ubuntu shell:

```bash
grep -RhvE '^\s*(#|$)' /etc/apt/sources.list /etc/apt/sources.list.d/*.list /etc/apt/sources.list.d/*.sources 2>/dev/null || true
sudo mkdir -p /etc/apt/backup-terminal-first
sudo cp -a /etc/apt/sources.list /etc/apt/sources.list.d /etc/apt/backup-terminal-first/ 2>/dev/null || true
```

Expected result: current APT sources are visible for review, and current source files are copied to `/etc/apt/backup-terminal-first/` when they exist.

On Ubuntu 24.04, prefer editing Deb822 source files under `/etc/apt/sources.list.d/` when they exist. Run from Ubuntu shell:

```bash
sudoedit /etc/apt/sources.list.d/ubuntu.sources
```

Expected result: the Ubuntu source file opens in a sudo-safe editor.

Change only the `URIs:` value to the policy-approved mirror. Example:

```text
URIs: https://archive.ubuntu.com/ubuntu/
```

Expected result: the source file points to the selected policy-approved mirror.

Run from Ubuntu shell:

```bash
sudo apt update
apt-cache policy
```

Expected result: package indexes refresh successfully, and `apt-cache policy` shows the expected source priorities.

### 4. Configure shared data access

The documented shared data path is `D:\Data` on Windows and `/home/<user>/data` inside Ubuntu. Keep Linux-heavy project code in the WSL filesystem, for example `~/src`; treat `/home/<user>/data` as shared Windows/Linux data unless you accept mounted-drive performance tradeoffs.

If `D:\Data` does not exist, create, skip, or choose one of these paths before configuring fstab: create it on Windows, skip shared data setup, or choose a manually documented replacement path for this machine.

Safety: `/etc/fstab` mistakes can affect mount behavior.

Target path: `/etc/fstab`

Backup: back up `/etc/fstab` before editing it.

Rollback: remove the project-owned `D:/Data` entry or restore the backup, then run `sudo mount -a` again.

Scope: machine-wide inside the Ubuntu distro.

Run from Ubuntu shell:

```bash
sudo cp -a /etc/fstab "/etc/fstab.backup.$(date +%Y%m%d%H%M%S)"
mkdir -p "$HOME/data"
```

Expected result: `/etc/fstab` has a timestamped backup and `$HOME/data` exists.

Add this fstab entry from Ubuntu shell, replacing `<user>` with the Ubuntu username before writing it:

```fstab
D:/Data /home/<user>/data drvfs metadata,uid=1000,gid=1000,umask=022,fmask=011,case=off 0 0
```

Expected result: `/etc/fstab` contains the project-owned `D:/Data` entry for the Ubuntu user.

Run from Ubuntu shell:

```bash
sudo mount -a
findmnt "$HOME/data"
```

Expected result: `findmnt` reports a mount for `$HOME/data`.

If direct DrvFs subdirectory mounting is unreliable on the installed WSL version, use the fallback symlink path:

1. Mount `D:` through fstab at a documented mount point such as `/mnt/d`.
2. Verify `D:\Data` appears as `/mnt/d/Data`.
3. Run from Ubuntu shell:

   ```bash
   ln -sfn /mnt/d/Data "$HOME/data"
   ```

   Expected result: `$HOME/data` points to `/mnt/d/Data`.

### 5. Verify locale readiness

`C.UTF-8` is the healthy default locale for deterministic UTF-8 behavior. User-selected UTF-8 locales are also healthy when locale output is UTF-8 and warning-free.

Run from Ubuntu shell:

```bash
locale
locale charmap
```

Expected result:

- `locale charmap` reports `UTF-8`.
- `locale` output has no warnings.
- `LANG` or `LC_*` values are either `C.UTF-8` or another warning-free UTF-8 locale selected by the user.

If a repair is needed, prefer `C.UTF-8` unless the user intentionally chooses a regional UTF-8 locale.

Run from Ubuntu shell:

```bash
sudo update-locale LANG=C.UTF-8 LC_ALL=
exec "$SHELL" -l
locale
locale charmap
```

Expected result: a new login shell reports a warning-free UTF-8 locale.

If the output still shows warnings after starting a new shell, run from Ubuntu shell:

```bash
grep -nE '^(export )?(LANG|LC_[A-Z_]+)=' ~/.profile ~/.bashrc ~/.zshrc 2>/dev/null || true
```

Expected result: any user-level locale exports that may override the system default are listed for review.

Remove or comment stale `LANG` or `LC_*` lines that point to unavailable locales, then rerun:

```bash
sudo update-locale LANG=C.UTF-8 LC_ALL=
exec "$SHELL" -l
```

Expected result: the new shell uses the system UTF-8 locale without warnings.

If the user intentionally wants a regional UTF-8 locale, run from Ubuntu shell:

```bash
sudo apt update
sudo apt install -y locales
sudo locale-gen en_US.UTF-8
sudo update-locale LANG=en_US.UTF-8 LC_ALL=
exec "$SHELL" -l
```

Expected result: the selected UTF-8 locale is generated and active in a new login shell. Replace `en_US.UTF-8` with the chosen UTF-8 locale.

### 6. Optionally enable passwordless sudo

Passwordless sudo is optional. Skip this step if you do not want the personal-workstation convenience profile.

Safety: passwordless sudo weakens local safety because commands can elevate without an interactive password prompt.

Target path: `/etc/sudoers.d/terminal-first-windows-dev`

Backup: if `/etc/sudoers.d/terminal-first-windows-dev` already exists, save a copy before replacing it.

Rollback: remove `/etc/sudoers.d/terminal-first-windows-dev`, validate with `visudo`, and verify that `sudo -n true` no longer succeeds unless another policy allows it.

Scope: machine-wide inside the Ubuntu distro for the named Ubuntu user.

Run from Ubuntu shell:

```bash
test ! -e /etc/sudoers.d/terminal-first-windows-dev || sudo cp -a /etc/sudoers.d/terminal-first-windows-dev "/etc/sudoers.d/terminal-first-windows-dev.backup.$(date +%Y%m%d%H%M%S)"
printf '%s\n' "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/terminal-first-windows-dev >/dev/null
sudo chmod 0440 /etc/sudoers.d/terminal-first-windows-dev
sudo visudo -cf /etc/sudoers.d/terminal-first-windows-dev
```

Expected result: `visudo` reports that the project-owned sudoers drop-in parses correctly.

Run from Ubuntu shell:

```bash
sudo -n true
```

Expected result: the command exits successfully only when passwordless sudo is intentionally enabled.

If `visudo` validation fails, remove the drop-in and do not consider the profile applied.

### 7. Check doctor status expectations

Future doctor checks for this layer report only `pass`, `fail`, `skipped`, or `needs manual action`.

Expected layer names include WSL config, proxy, data mount, locale, and sudo.

Doctor checks are primarily verification and should avoid broad writes. Any future helper that writes files must show the target path, backup behavior, rollback behavior, and scope before writing.

## Rollback

- `.wslconfig`: remove the project-owned `autoProxy=true` entry or restore the backup, then run `wsl --shutdown` from Windows PowerShell.
- `/etc/wsl.conf`: restore the backup or remove project-owned entries, then restart WSL.
- APT sources: restore `/etc/apt/backup-terminal-first/` or revert the edited `URIs:` value, then run `sudo apt update`.
- `/etc/fstab`: remove the project-owned `D:/Data` entry or restore the backup, then run `sudo mount -a`.
- Data mount fallback: remove the fallback symlink at `/home/<user>/data` if it was created.
- Proxy fallback: unset shell-session variables or remove project-owned lines from the user-local profile where they were added.
- Sudoers: remove `/etc/sudoers.d/terminal-first-windows-dev`, run `sudo visudo -c`, and verify expected sudo behavior.

## Troubleshooting

Use the targeted troubleshooting entry that matches the symptom:

- Automatic proxy mirroring blocked or unavailable: [automatic proxy mirroring does not work](../networking/proxy.md#automatic-proxy-mirroring-does-not-work)
- Proxy credentials, private hostnames, or shell-history risk: [manual proxy fallback cautions](../networking/proxy.md#manual-proxy-fallback-cautions)
- HTTPS certificate or issuer errors: [WSL SSL certificate trust fails](../networking/proxy.md#wsl-ssl-certificate-trust-fails)

For fstab, locale, sudoers, or enterprise-policy failures without a matching troubleshooting anchor, stop at the failed step and use the local backup and rollback note for that step.

## Ubuntu Baseline Troubleshooting

### Purpose

Track Ubuntu-on-WSL baseline failures for WSL config, data mount, locale, sudo, and helper write safety.

### Safety notes

Do not keep broken sudoers or fstab changes in place. If validation fails, remove the project-owned change or restore the backup before continuing.

### WSL config changes do not apply

Confirm `/etc/wsl.conf` contains the intended entries:

```ini
[automount]
enabled=false
mountFsTab=true

[interop]
enabled=true
appendWindowsPath=false
```

After editing `/etc/wsl.conf`, restart WSL from Windows PowerShell:

```powershell
wsl --shutdown
```

If Ubuntu still sees unexpected Windows path behavior, review whether another local change has overwritten `/etc/wsl.conf`.

### Data mount fails

If `sudo mount -a` fails, do not proceed as if `/home/<user>/data` is ready.

Check:

- `D:\Data` exists on Windows, or the user intentionally chose create, skip, or choose another documented path.
- `/home/<user>/data` exists inside Ubuntu.
- `/etc/fstab` contains the project-owned `D:/Data` entry with the correct Ubuntu username.
- The installed WSL version supports direct DrvFs subdirectory mounting.

If direct subdirectory mounting is unreliable, remove the failing fstab entry and use the fallback symlink path documented in the Ubuntu baseline guide.

### Locale warnings appear

Run:

```bash
locale
locale charmap
```

Healthy output is UTF-8 and warning-free. `C.UTF-8` is the default healthy target, but user-selected UTF-8 locales are acceptable when they do not emit warnings.

Repair to the project default:

```bash
sudo update-locale LANG=C.UTF-8 LC_ALL=
exec "$SHELL" -l
locale
locale charmap
```

If warnings continue, check for user profile overrides:

```bash
grep -nE '^(export )?(LANG|LC_[A-Z_]+)=' ~/.profile ~/.bashrc ~/.zshrc 2>/dev/null || true
```

Remove stale overrides that reference unavailable locales. For a regional UTF-8 locale, install locale support, generate the locale, and then select it:

```bash
sudo apt update
sudo apt install -y locales
sudo locale-gen en_US.UTF-8
sudo update-locale LANG=en_US.UTF-8 LC_ALL=
exec "$SHELL" -l
```

### Sudoers validation fails

If `sudo visudo -cf /etc/sudoers.d/terminal-first-windows-dev` fails, remove the project-owned sudoers drop-in and do not treat passwordless sudo as enabled.

```bash
sudo rm -f /etc/sudoers.d/terminal-first-windows-dev
sudo visudo -c
```

Passwordless sudo is optional. Skipping it is a valid setup state and should be reported as `skipped` by future doctor checks.

### Helper write disclosure

Any future Ubuntu helper that writes files must show:

- target path;
- backup behavior;
- rollback behavior;
- whether the write is user-local or machine-wide.

Helpers must not silently edit `/etc/wsl.conf`, `/etc/fstab`, sudoers, proxy profile files, or shell startup files.
