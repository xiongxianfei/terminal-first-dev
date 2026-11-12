# fzf

Select items interactively from files, history, or command output. Use fzf 0.51.0+ with [zoxide](zoxide.md) for `zi`. Platform walkthroughs below are unverified.

## Ubuntu 26.04

Requires Bash, Git, `curl` or `wget`, `tar`, Vim, and CA certificates. Run inside Ubuntu, including WSL. Use the upgrade section if `~/.fzf` already exists. Stop if installation fails.

**1. Run in terminal:** back up the profile before the installer can change it.

```bash
cp --backup=numbered ~/.bashrc ~/.bashrc.bak
# Executes upstream code; no sudo. Accept Bash completion/keybindings and profile setup.
git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf" && "$HOME/.fzf/install"

# Confirm the installer generated this file before editing the profile.
ls -l ~/.fzf.bash
vim ~/.bashrc
```

**2. Check `~/.bashrc`:** the installer normally adds this line. Keep it once, near the end; add it only if missing. Remove duplicate fzf initialization such as `eval "$(fzf --bash)"`. Save and quit Vim with `Esc`, then `:wq`.

```bash
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
```

**3. Verify in a new Bash terminal:** `command -v fzf` should resolve to `~/.fzf/bin/fzf`. If `~/.fzf.bash` was missing, rerun the installer first; the source line alone cannot generate it.

```bash
command -v fzf
fzf --version
printf '%s\n' alpha beta | fzf --filter=beta  # Expected: beta.

# Use
printf '%s\n' alpha beta | fzf  # Enter selects; Escape cancels.
# Ctrl+R: history; Ctrl+T: files; Alt+C: directories.
```

### Upgrade

```bash
# Back up ~/.bashrc and ~/.fzf.bash as well as the binary before updating.
cp --backup=numbered ~/.fzf/bin/fzf ~/.fzf/bin/fzf.bak
git -C "$HOME/.fzf" rev-parse HEAD
# Fetch and execute the updated installer. APT does not update this copy.
git -C "$HOME/.fzf" pull --ff-only && "$HOME/.fzf/install"
fzf --version
# Open a fresh Bash terminal; restore the saved binary to roll back.
```

### Uninstall

```bash
# Permanently deletes this checkout. Save backups or other needed files elsewhere first.
rm -rf -- "$HOME/.fzf"

# Remove the fzf source line; preserve configuration for other tools.
# Remove the generated Bash configuration after saving any customizations.
rm -f -- "$HOME/.fzf.bash"
vim ~/.bashrc
# Save and open a fresh Bash terminal.
```

To undo profile changes, compare `~/.bashrc` with `~/.bashrc.bak` (or its numbered backups) and restore only the intended changes.

## Win11

Requires PowerShell 7 and WinGet. WinGet may request elevation; install separately from WSL. Basic fzf use and zoxide's `zi` do not require PSFzf.

```powershell
# Install
winget install --id junegunn.fzf --exact --source winget
# Open a new PowerShell 7 terminal if fzf is not yet on PATH.

# Configure
# No profile changes are needed for basic selection.

# Verify
Get-Command fzf
fzf --version
'alpha', 'beta' | fzf --filter=beta  # Expected: beta.

# Use
'alpha', 'beta' | fzf  # Enter selects; Escape cancels.
```

### Optional keybindings

Requires Vim on PATH. This installs third-party module code; review trust prompts. No execution-policy change is needed.

**1. Run in a PowerShell 7 terminal:**

```powershell
# Install optional PowerShell integration.
Install-Module -Name PSFzf -Repository PSGallery -Scope CurrentUser

# Back up or create the PowerShell 7 profile, then edit it.
if (Test-Path $PROFILE) { Copy-Item $PROFILE "$PROFILE.$(Get-Date -Format yyyyMMddHHmmssfff).bak" }
if (!(Test-Path $PROFILE)) { New-Item -ItemType File -Path $PROFILE -Force | Out-Null }
vim $PROFILE
```

**2. Add to `$PROFILE`:** place these lines once after prompt/PSReadLine setup. Remove duplicate PSFzf configuration. Save and quit Vim with `Esc`, then `:wq`.

```powershell
Import-Module PSReadLine
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
```

**3. Verify in a new PowerShell 7 terminal:** check the registered handlers, then try Ctrl+T for files and Ctrl+R for history.

```powershell
Get-Module PSFzf
Get-PSReadLineKeyHandler -Chord Ctrl+t,Ctrl+r
```

### Upgrade

```powershell
# Record the current version; reinstall that version if available to roll back.
fzf --version
winget upgrade --id junegunn.fzf --exact --source winget
fzf --version
# Only if PSFzf was installed through PowerShell Gallery:
# Update-Module PSFzf
```

### Uninstall

```powershell
winget uninstall --id junegunn.fzf --exact
# If you enabled PSFzf, remove its Import-Module and Set-PsFzfOption lines.
# Preserve PSReadLine if other features use it. Save and restart PowerShell.
# vim $PROFILE
# Uninstall-Module PSFzf
```

Restore the saved profile to roll back configuration changes, accounting for later edits.

## macOS

Requires Homebrew, Zsh, and Vim on PATH. Do not run Homebrew with sudo.

**1. Run in terminal:**

```zsh
brew install fzf
# Back up an existing profile without replacing an earlier backup.
if [[ -f ~/.zshrc ]]; then cp -p ~/.zshrc "$(mktemp "$HOME/.zshrc.backup.XXXXXX")"; fi
vim ~/.zshrc
```

**2. Add to `~/.zshrc`:** place this line once after completion/prompt setup. Remove duplicate fzf initialization. On plain Zsh, initialize `compinit` first; do not duplicate framework setup. Save and quit Vim with `Esc`, then `:wq`.

```zsh
source <(fzf --zsh)
```

**3. Verify in a new Zsh terminal:** fzf should resolve to the Homebrew installation and filtering should print `beta`.

```zsh
command -v fzf
fzf --version
printf '%s\n' alpha beta | fzf --filter=beta  # Expected: beta.

# Use
printf '%s\n' alpha beta | fzf
# Ctrl+R: history; Ctrl+T: files; Alt+C: directories (terminal settings may intercept).
```

### Upgrade

```zsh
brew upgrade fzf
fzf --version
```

### Uninstall

```zsh
brew uninstall fzf
# Remove the fzf source line, save, and restart Zsh.
vim ~/.zshrc
```

Restore the saved profile to undo configuration changes.

## Troubleshooting

- **Missing `~/.fzf.bash`:** `install --bin` does not generate it. Run `~/.fzf/install`, accept Bash setup, then open a new terminal. The guarded source line silently skips a missing file.
- **Wrong or missing binary:** check `command -v fzf` or `Get-Command fzf`; an old APT/manual copy may still be on PATH.
- **Unknown `--bash` / `--zsh` option:** upgrade fzf before evaluating its initialization output.
- **Missing keybindings:** check profile initialization or PSFzf imports, remove duplicates, and open a fresh terminal.
- **`zi` fails:** check `fzf --version` and [zoxide configuration](zoxide.md); PSFzf is not required.

Initialization evaluates code from the executable on PATH. Use trusted installations; history pickers can reveal secrets. Do not pipe untrusted selections into command execution.

[Official installation and shell integration](https://github.com/junegunn/fzf#installation) and [PSFzf configuration](https://github.com/kelleyma49/PSFzf#psreadline-integration), reviewed November 12, 2026. Documentation and syntax checks do not establish platform compatibility.
