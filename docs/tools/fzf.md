# fzf: fuzzy selection and shell integration

Optional fuzzy selection for Windows PowerShell 7, Ubuntu/WSL Bash, and macOS Zsh. fzf selects from input; [zoxide](zoxide.md) learns directory history. Installing either executable is separate from enabling shell integration.

## Install and check the version

| Environment | Command |
| --- | --- |
| Windows, PowerShell 7 | `winget install --id junegunn.fzf --exact --source winget` |
| Ubuntu/WSL | `sudo apt update` followed by `sudo apt install fzf` |
| macOS, Homebrew already configured | `brew install fzf` |

APT requires sudo; WinGet may request elevation. Follow local policy. Do not install Windows executables as a substitute for Linux packages inside WSL, or run Homebrew with sudo.

Run `fzf --version`. For the complete zoxide/fzf workflow, use **fzf 0.51.0 or newer**, matching current zoxide's documented minimum. The shared Bash/Zsh snippets use the executable's `--bash`/`--zsh` integration output; an unsupported option produces a warning and leaves standalone fzf available.

**Ubuntu 24.04:** its distribution package is from the 0.44.1 series, so `apt install fzf` alone does not meet that workflow baseline. Check the local candidate with `apt-cache policy fzf`. Either keep standalone fzf and ordinary `z` for now, or obtain a suitable stable binary from the [official fzf releases](https://github.com/junegunn/fzf/releases). Choose the Linux architecture matching `uname -m`, review the release, and verify its published checksum when provided.

For a manually downloaded and extracted Linux binary, back up an existing destination before replacing it, then adapt this source path:

```bash
mkdir -p "$HOME/.local/bin"
install -m 0755 /path/to/extracted/fzf "$HOME/.local/bin/fzf"
export PATH="$HOME/.local/bin:$PATH"
fzf --version
```

Keep that PATH entry before the snippet in the shell profile. Verify `command -v fzf` resolves the intended binary; a later APT upgrade does not update a manually installed binary. To undo this override, remove only that user-installed binary or restore its backup and start a fresh shell. No remote installer is executed by this repository.

## Enable the shared shell snippet

Back up the relevant profile before editing. Review the snippet first: it evaluates initialization code emitted by your locally installed tools. Trust and inspect the binaries resolved through PATH. Source from an absolute, trusted checkout path, adapting the examples below; moving the checkout requires updating the profile. Future changes to a sourced snippet take effect in new shells, so review updates before pulling them.

Use one integration route, not this snippet plus an existing plugin/framework initialization for the same tools. Successful loads are guarded within the session; failures can be retried. No snippet changes execution policy, installs packages, replaces `cd`, or overwrites `FZF_*` settings. Loading fzf integration can change shell keybindings.

### Bash: Ubuntu or WSL

Add at the end of `~/.bashrc`, after existing prompt and completion setup:

```bash
source "$HOME/src/terminal-first-dev/config/shell/navigation.bash"
```

Canonical configuration: [navigation.bash](../../config/shell/navigation.bash). It does nothing in noninteractive Bash. The example assumes the repository is cloned under `~/src`; substitute your actual path.

### Zsh: macOS or Ubuntu

Add at the end of `~/.zshrc`, after your framework's completion and prompt setup:

```zsh
source "$HOME/src/terminal-first-dev/config/shell/navigation.zsh"
```

Canonical configuration: [navigation.zsh](../../config/shell/navigation.zsh). It does nothing in noninteractive Zsh. On plain Zsh with no completion framework, initialize completion before that source line:

```zsh
autoload -Uz compinit
compinit
```

Do not add a second `compinit` when your framework already runs it. The snippet does not create or clear completion caches itself.

### PowerShell 7: Windows

Edit the profile reported by `$PROFILE` **inside PowerShell 7**, not Windows PowerShell 5.1. Back up an existing file; create it and its parent directory only when absent. Add after prompt customization and PSReadLine edit-mode settings:

```powershell
. 'C:\src\terminal-first-dev\config\shell\navigation.ps1'
```

Canonical configuration: [navigation.ps1](../../config/shell/navigation.ps1). The dot and following space are required to load into the current session. The path is an example, not a required checkout location. This enables zoxide when installed; raw fzf pipelines and `zi` do not need a module.

**Optional PowerShell keybindings:** review [PSFzf](https://github.com/kelleyma49/PSFzf) and its [PowerShell Gallery package](https://www.powershellgallery.com/packages/PSFzf), then install manually:

```powershell
Install-Module -Name PSFzf -Repository PSGallery -Scope CurrentUser
```

This adds third-party module code to your user profile; review trust prompts rather than bypassing them. No administrator shell or execution-policy relaxation is prescribed. Replace the single source line above with:

```powershell
$TerminalFirstEnableFzfKeys = $true
. 'C:\src\terminal-first-dev\config\shell\navigation.ps1'
```

The snippet imports PSReadLine before PSFzf and explicitly binds Ctrl+T (paths) and Ctrl+R (history). Module defaults may add other bindings; ordinary Tab is not explicitly replaced by this snippet. Import failures warn without preventing zoxide initialization. Leave the opt-in unset/false to keep this snippet from loading PSFzf.

## Use and verify

Noninteractive smoke check; expected output is `beta`:

```bash
# Bash or Zsh
printf '%s\n' alpha beta | fzf --filter=beta
```

```powershell
# PowerShell
'alpha', 'beta' | fzf --filter=beta
```

Then open a new interactive shell. Check `zoxide --version` and `fzf --version`; inspect `type z zi` (Bash/Zsh) or `Get-Command z, zi` (PowerShell). Use [zoxide's seed/check steps](zoxide.md#use-and-verify), then try `zi` and cancel with Escape.

Bash/Zsh's native fzf integration supplies Ctrl+R for history, Ctrl+T for file/path selection, and Alt+C for directory selection. PowerShell Ctrl+T/Ctrl+R require the optional PSFzf route above. Test in your actual terminal: terminal shortcuts, macOS Option-key settings, shell editing modes, or later profile code can intercept or replace keys.

## Troubleshooting and rollback

| Symptom | Action |
| --- | --- |
| Executable not found | Open a new shell; inspect `command -v fzf zoxide` or `Get-Command fzf,zoxide`. Windows and WSL are separate. |
| `unknown option: --bash` / `--zsh` | Upgrade fzf as described above. Do not evaluate failed command output or assume old distribution packages support native integration. |
| `z` works but `zi` fails | Check the fzf version and executable path. PSFzf is unrelated to zoxide's picker. |
| PowerShell keys do nothing | Check the opt-in, `Get-Module -ListAvailable PSFzf`, warnings, and `Get-PSReadLineKeyHandler -Chord Ctrl+r,Ctrl+t`. |
| Duplicate hooks or unexpected keys | Remove duplicate init lines; configure edit mode before integration; restart after changes. |

Remove the source line and PowerShell opt-in, restore any backed-up profile, then start a **fresh shell** to discard loaded functions, hooks, and keybindings. For profile recovery, use `pwsh -NoProfile`, `bash --noprofile --norc`, or `zsh -f`. Removing a line does not unload an already running shell.

Remove packages only through the channel used: `winget uninstall --id junegunn.fzf --exact`, `sudo apt remove fzf`, or `brew uninstall fzf`; remove optional PSFzf with `Uninstall-Module PSFzf`. Keep local history and zoxide data private; history pickers can display secrets previously entered at the prompt. Do not pipe untrusted selections directly into command execution.

## Sources and verification boundary

References reviewed November 12, 2026: [fzf installation and shell integration](https://github.com/junegunn/fzf#installation), [zoxide's fzf requirement](https://github.com/ajeetdsouza/zoxide#installation), [Ubuntu 24.04 package](https://packages.ubuntu.com/noble/fzf), and [PSFzf integration](https://github.com/kelleyma49/PSFzf#psreadline-integration).

Automated checks use mocked executables/modules to test safe missing-tool behavior, failed initialization, independent loading, and repeated sourcing. They do not prove package installation, real interactive picker behavior, or every terminal's keybindings. Record real platform, shell/tool versions, date, and outcomes separately.
