# Tested Versions: Terminal-First Workstation Setup First Slice

## Status

draft

## Version policy

Use latest stable at setup time, not preview or nightly. Record tested versions for each publication. Pin only where reproducibility matters, such as Neovim plugin lockfiles.

## Tested version record

| Component | Version or evidence | Status | Notes |
| --- | --- | --- | --- |
| PowerShell | `pwsh --version` | unrun | manual Windows check required |
| WinGet | `winget --version` | unrun | manual Windows check required |
| Windows Terminal | `wt --version` | unrun | manual Windows check required |
| WSL version | `wsl --version` or `wsl --status` | unrun | manual Windows check required |
| WSL help | `wsl --help` excerpt with `--install`, `--distribution`, and `--location` | unrun | required before publication |
| Ubuntu distro | selected value from `wsl --list --online` | unrun | must be explicit Ubuntu LTS distro name |
| Neovim Windows | `nvim --version` | unrun | manual Windows check required |
| Neovim Ubuntu | `nvim --version`; fallback source `https://github.com/neovim/neovim-releases/releases/download/v0.12.2/nvim-linux-x86_64.tar.gz` | observed locally where available | local Linux workspace reported Neovim availability during M4 validation; Ubuntu fallback installs under `/opt/nvim-linux-x86_64` with `/usr/local/bin/nvim` symlink |
| tmux | `tmux -V` | observed locally where available | local Linux workspace reported tmux availability during M4 validation |
| uv | `uv --version` | unrun | optional tool; verify separately on Windows and Ubuntu if installed |
| optional language tools | language server, formatter, and linter versions when installed | unrun | record only installed tools; missing optional tools must not be treated as passing |

## WSL command-contract publication evidence

Official documentation evidence:

- Microsoft Learn, Basic commands for WSL: `https://learn.microsoft.com/en-us/windows/wsl/basic-commands`

Before publication, capture local or release-machine evidence for:

```powershell
wsl --help
wsl --list --online
wsl --list --verbose
```

The captured `wsl --help` excerpt must show support for:

- `wsl --install`
- `--distribution`
- `--location`

The published fresh install command must remain:

```powershell
wsl --install --distribution <UbuntuLtsDistroName> --location "D:\Software\WSL\Ubuntu"
```

Do not publish the ambiguous positional command as the primary path:

```powershell
wsl --install Ubuntu --location "D:\Software\WSL\Ubuntu"
```

## Manual Windows checklist

Manual Windows evidence is still required for:

- Windows host checks;
- WSL fresh custom-location install;
- WSL existing-distro migration/import-in-place;
- Windows Neovim install and startup;
- Windows Terminal profile behavior.

Record unrun checks honestly as `unrun` or `needs manual action`. Do not mark manual Windows checks as passed from this Linux workspace.
