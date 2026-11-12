# Tools

Installation commands from the maintained guides, one tool per row. Select the environment where the tool will run; Windows and WSL need separate installations. Tool names link to configuration, usage, verification, and rollback instructions. Platform coverage is optional per tool. `—` means “not covered by this guide,” not “unsupported by the tool.” Listed commands do not imply tested platform compatibility.

Before running:

- Windows requires PowerShell and WinGet for the WinGet commands; installers may request elevation. The uv command executes downloaded code and bypasses execution policy for its child PowerShell process; follow local policy.
- Ubuntu/WSL requires the prerequisites in each guide. APT commands require sudo and change system packages. The uv and zoxide commands execute remote scripts; fzf executes a cloned installer that offers to edit shell profiles; back up the profile first. Review upstream code and back up existing installations before updates. The fzf clone command requires `~/.fzf` not to exist; use its guide's update command for an existing checkout.
- macOS requires Homebrew already configured. Run it without sudo.

| Tool | Purpose | Windows (PowerShell) | Ubuntu/WSL (Bash) | macOS |
| --- | --- | --- | --- | --- |
| [Neovim](neovim.md) | Code editing | `winget install --id Neovim.Neovim --source winget` | `sudo apt update && sudo apt install -y neovim` | — |
| [tmux](tmux.md) | Terminal sessions and panes | — | `sudo apt update && sudo apt install -y tmux` | — |
| [uv](uv.md) | Python packages and projects | `powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 \| iex"` | `curl -LsSf https://astral.sh/uv/install.sh \| sh` | — |
| [zoxide](zoxide.md) | Jump to familiar directories | `winget install --id ajeetdsouza.zoxide --exact --source winget` | `curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh \| sh` | — |
| [fzf](fzf.md) | Interactive fuzzy selection | `winget install --id junegunn.fzf --exact --source winget` | `git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install` | `brew install fzf` |

APT versions may lag upstream; the [Neovim guide](neovim.md#3-use-the-ubuntu-release-tarball-fallback-when-needed) includes a release fallback. The zoxide and fzf installers above follow upstream releases rather than fixed versions. Keep these commands aligned with their tool guides when changing installation routes.

For interactive directory jumping, install fzf and zoxide, then add the direct [zoxide initialization](zoxide.md) and optional [fzf keybindings](fzf.md) to your profile. Installing the executables alone does not enable `z`, `zi`, or shell keybindings.

Reusable configurations: [Neovim](../../config/nvim/init.lua), [tmux](../../config/tmux/tmux.conf), and direct navigation configuration in the [zoxide](zoxide.md) and [fzf](fzf.md) guides. Check each guide's platform scope before using them.
