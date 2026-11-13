# Tools

Choose tools that fit your workflow using the recommendations below. Tool names link to local setup, usage, verification, and rollback instructions; official resources provide deeper coverage.

Select the environment where the tool will run; Windows and WSL need separate installations. Platform coverage is optional per tool. `—` means “not covered by this guide,” not “unsupported by the tool.” Listed commands do not imply tested platform compatibility.

Before running:

- Windows requires PowerShell and WinGet for the WinGet commands; installers may request elevation. The uv command executes downloaded code and bypasses execution policy for its child PowerShell process; follow local policy.
- Ubuntu/WSL requires the prerequisites in each guide. APT commands require sudo and change system packages. The uv and zoxide commands execute remote scripts; fzf executes a cloned installer that offers to edit shell profiles; back up the profile first. Review upstream code and back up existing installations before updates. The fzf clone command requires `~/.fzf` not to exist; use its guide's update command for an existing checkout.
- macOS requires Homebrew already configured. Run it without sudo.

| Tool | Recommended when | Windows (PowerShell) | Ubuntu/WSL (Bash) | macOS | Official resources |
| --- | --- | --- | --- | --- | --- |
| [Neovim](neovim.md) | You want to edit code in the terminal | `winget install --id Neovim.Neovim --source winget` | `sudo apt update && sudo apt install -y neovim` | — | [Neovim website](https://neovim.io/) |
| [tmux](tmux.md) | You need persistent terminal sessions and multiple panes | — | `sudo apt update && sudo apt install -y tmux` | — | [tmux wiki](https://github.com/tmux/tmux/wiki) |
| [uv](uv.md) | You work with Python projects, packages, or environments | `powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 \| iex"` | `curl -LsSf https://astral.sh/uv/install.sh \| sh` | — | [uv documentation](https://docs.astral.sh/uv/) |
| [zoxide](zoxide.md) | You often return to the same directories | `winget install --id ajeetdsouza.zoxide --exact --source winget` | `curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh \| sh` | — | [zoxide repository](https://github.com/ajeetdsouza/zoxide) |
| [fzf](fzf.md) | You want interactive selection from files, history, or command output | `winget install --id junegunn.fzf --exact --source winget` | `git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install` | `brew install fzf` | [fzf repository](https://github.com/junegunn/fzf) |

APT versions may lag upstream; the [Neovim guide](neovim.md#3-use-the-ubuntu-release-tarball-fallback-when-needed) includes a release fallback. The zoxide and fzf installers above follow upstream releases rather than fixed versions. Keep these commands aligned with their tool guides when changing installation routes.

Pair zoxide with fzf for interactive directory jumping with `zi`. Follow the [zoxide initialization](zoxide.md) and, if useful, add [fzf keybindings](fzf.md) to your profile. Installing the executables alone does not enable `z`, `zi`, or shell keybindings.

Reusable configurations: [Neovim](../../config/nvim/init.lua), [tmux](../../config/tmux/tmux.conf), and direct navigation configuration in the [zoxide](zoxide.md) and [fzf](fzf.md) guides. Check each guide's platform scope before using them.
