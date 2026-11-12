# zoxide: jump to familiar directories

Optional directory navigation for Windows PowerShell 7, Ubuntu/WSL Bash, and macOS Zsh. `z` ranks previously visited directories; `zi` uses [fzf](fzf.md) for interactive selection. This does not replace `cd` or install anything automatically.

## Install

Use the package manager for the environment where the shell runs. Windows and WSL need separate installations and keep separate directory histories.

| Environment | Command |
| --- | --- |
| Windows, PowerShell 7 | `winget install --id ajeetdsouza.zoxide --exact --source winget` |
| Ubuntu/WSL | `sudo apt update` followed by `sudo apt install zoxide` |
| macOS, Homebrew already configured | `brew install zoxide` |

APT changes system packages and requires sudo; WinGet may request elevation. Follow local policy, and do not run Homebrew with sudo. Open a new terminal after PATH changes.

Check `zoxide --version`. For `zi`, also install fzf: current upstream zoxide documents **fzf 0.51.0 or newer** as its minimum. Ubuntu 24.04's packaged fzf is older; follow the [fzf version guidance](fzf.md#install-and-check-the-version) rather than assuming APT provides every integration feature.

## Enable shell integration

Review and load the matching shared snippet using the [activation instructions](fzf.md#enable-the-shared-shell-snippet):

| Shell | Reusable snippet |
| --- | --- |
| PowerShell 7 | [navigation.ps1](../../config/shell/navigation.ps1) |
| Bash | [navigation.bash](../../config/shell/navigation.bash) |
| Zsh | [navigation.zsh](../../config/shell/navigation.zsh) |

The snippets initialize each installed tool independently, keep `cd` unchanged, and avoid repeating successful initialization when sourced again. Zsh initialization belongs after `compinit`; prompt/framework setup belongs before these snippets. Existing `z`/`zi` aliases may conflict: inspect them before opting in.

fzf shell keybindings and the PowerShell PSFzf module are **not required by `zi`**; the compatible fzf executable is sufficient.

## Use and verify

First visit a real directory normally and let the next prompt appear, or explicitly seed the database:

```bash
# Bash or Zsh
cd "$HOME"
zoxide add "$PWD"
zoxide query --list
z "$HOME"
```

For learned navigation, use a distinctive fragment of an actual path shown by `zoxide query --list`, then confirm the resulting working directory. The project names below are examples, not directories created by this guide.

PowerShell seed example:

```powershell
Set-Location $HOME
zoxide add (Get-Location).Path
zoxide query --list
```

Use `z project` to jump by a directory-name fragment, `z project api` to narrow the match, and `zi` to select from learned directories. Press Escape to cancel the picker. An empty database is not an installation failure.

## Troubleshooting and rollback

| Symptom | Check |
| --- | --- |
| `zoxide` works but `z` is unknown | Confirm the correct shell profile sources the snippet; restart the shell. |
| `zi` fails but `z` works | Run `fzf --version`; inspect PATH for an old binary and check the minimum above. |
| A directory never appears | Visit it and reach another prompt, or use `zoxide add` with its actual path. |
| Existing `z` or prompt behavior changes | Remove duplicate initialization or the conflicting alias; restore the backed-up profile and start a fresh shell. |

Remove the snippet's source line and restart to undo integration. Uninstall through the original channel: `winget uninstall --id ajeetdsouza.zoxide --exact`, `sudo apt remove zoxide`, or `brew uninstall zoxide`. Uninstalling is not a promise that local history is erased.

zoxide stores directory history locally. Do not commit its database, private directory listings, or shell history. Configure exclusions using upstream options before visiting sensitive locations; exclusions are not a retroactive data wipe.

## Sources and verification boundary

Reference reviewed November 12, 2026: [upstream installation, initialization, usage, and configuration](https://github.com/ajeetdsouza/zoxide#installation). Automated repository tests exercise snippet logic with mocked tools, not package installation or a real `zi` picker. Record tool versions, shell, platform, date, and manual outcomes when testing on your workstation.
