# zoxide

Jump to familiar directories with `z`; use [fzf](fzf.md) 0.51.0+ for `zi`. Platform walkthroughs below are unverified.

## Ubuntu 26.04

Requires Bash, `curl`, `tar`, `vim`, and CA certificates. Run inside Ubuntu, including when using WSL. Stop if installation fails.

**1. Run in terminal:**

```bash
# Install
# Executes the upstream installer. Back up existing zoxide files first.
# Writes ~/.local/bin and ~/.local/share/man; investigate unexpected sudo prompts.
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# Configure future sessions
# Back up ~/.bashrc, then open it in an editor.
cp --backup=numbered ~/.bashrc ~/.bashrc.bak
vim ~/.bashrc
```

**2. Add to `~/.bashrc`:** place these lines once at the end, after prompt setup. Reuse an existing PATH entry if it already includes `~/.local/bin`; remove duplicate zoxide/wrapper initialization. Save and quit Vim with `Esc`, then `:wq`.

```bash
export PATH="$HOME/.local/bin:$PATH"
eval "$(zoxide init bash)"
```

**3. Verify in a new Bash terminal:** `type z zi` should report shell functions. Then try navigation from an existing project directory.

```bash
# Verify
zoxide --version
type z zi

# Use
# Run from an existing project directory, not your home directory.
zoxide add "$PWD"
zoxide query --list
z "${PWD##*/}"
zi  # Requires fzf; Escape cancels.
```

### Upgrade

```bash
# Back up the binary and manpages before replacement. APT does not update this copy.
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
zoxide --version
# Open a fresh Bash terminal; restore saved files to roll back.
```

### Uninstall

```bash
# Deletes this installer's executable and manpages; directory history remains.
rm -f "$HOME/.local/bin/zoxide" "$HOME/.local/share/man/man1/"zoxide*.1

# Remove the zoxide init line; retain PATH entries needed by other tools.
vim ~/.bashrc
# Save and open a fresh Bash terminal.
```

To undo profile changes, compare `~/.bashrc` with `~/.bashrc.bak` (or its numbered backups) and restore only the intended changes.

## Win11

Requires PowerShell 7, WinGet, and Vim on PATH. Install separately from WSL; WinGet may request elevation. Stop if installation fails.

**1. Run in a PowerShell 7 terminal:**

```powershell
# Install
winget install --id ajeetdsouza.zoxide --exact --source winget
# Open a new PowerShell 7 terminal if zoxide is not yet on PATH.

# Configure future sessions
# Back up an existing profile, or create it without replacing an existing file.
if (Test-Path $PROFILE) { Copy-Item $PROFILE "$PROFILE.$(Get-Date -Format yyyyMMddHHmmssfff).bak" }
if (!(Test-Path $PROFILE)) { New-Item -ItemType File -Path $PROFILE -Force | Out-Null }
vim $PROFILE
```

**2. Add to `$PROFILE`:** place this line once at the end. Remove duplicate zoxide/wrapper initialization. Save and quit Vim with `Esc`, then `:wq`.

```powershell
Invoke-Expression (& { (zoxide init powershell | Out-String) })
```

**3. Verify in a new PowerShell 7 terminal:** `Get-Command z, zi` should find both commands. Then try navigation from an existing project directory.

```powershell
# Verify
zoxide --version
Get-Command z, zi

# Use
# Run from an existing project directory, not your home directory.
zoxide add (Get-Location).Path
zoxide query --list
z (Split-Path -Leaf (Get-Location).Path)
zi  # Requires fzf; Escape cancels.
```

### Upgrade

```powershell
# Record the current version; reinstall that version if available to roll back.
zoxide --version
winget upgrade --id ajeetdsouza.zoxide --exact --source winget
zoxide --version
```

### Uninstall

```powershell
winget uninstall --id ajeetdsouza.zoxide --exact

# Remove the zoxide initialization line, save, and restart PowerShell.
vim $PROFILE
# Directory history remains. Restore the saved profile to undo configuration changes.
```

Use trusted executables on PATH: initialization evaluates code they emit. If `z` is missing, check profile initialization; if `zi` fails, check `fzf --version`. Keep directory history and private paths out of Git.

[Official installation and configuration](https://github.com/ajeetdsouza/zoxide#installation), reviewed November 12, 2026. Documentation and syntax checks do not establish platform compatibility.
