#!/usr/bin/env bash
set -euo pipefail

nvim_guide=docs/guides/04-neovim.md
tmux_guide=docs/guides/05-tmux.md
verification=docs/guides/99-verification.md
nvim_config=config/nvim/init.lua
tmux_config=config/tmux/tmux.conf

for path in "$nvim_guide" "$tmux_guide" "$verification" "$nvim_config" "$tmux_config"; do
  test -f "$path" || {
    echo "missing required file: $path" >&2
    exit 1
  }
done

if find config/nvim -mindepth 1 -type f ! -path 'config/nvim/init.lua' | grep -q .; then
  echo "Neovim config must stay in one file: config/nvim/init.lua" >&2
  exit 1
fi

grep -q 'Windows PowerShell' "$nvim_guide"
grep -q 'Ubuntu' "$nvim_guide"
grep -q 'nvim --version' "$nvim_guide"
grep -q 'nvim --clean' "$nvim_guide"
grep -q 'Ubuntu release-tarball fallback' "$nvim_guide"
grep -q 'neovim-releases/releases/download/v0.12.2/nvim-linux-x86_64.tar.gz' "$nvim_guide"
grep -q '/opt/nvim-linux-x86_64' "$nvim_guide"
grep -q '/usr/local/bin/nvim' "$nvim_guide"
grep -q 'fd-find' "$nvim_guide"
grep -q 'Lazy' "$nvim_guide"
grep -q ':checkhealth' "$nvim_guide"
grep -q 'single-file shared config' "$nvim_guide"
grep -q 'config/nvim/init.lua' "$nvim_guide"
grep -q 'Do not share plugin or runtime state through a Windows-mounted path' "$nvim_guide"
grep -q 'editing options, search behavior, splits, clipboard, and diagnostics keymaps' "$nvim_guide"
grep -q 'Git change indicators' "$nvim_guide"
grep -q 'LSP wiring' "$nvim_guide"
grep -q 'Markdown can use tools' "$nvim_guide"
grep -q 'Shell can use tools' "$nvim_guide"
grep -q 'PowerShell can use PowerShell Editor Services' "$nvim_guide"
grep -q 'JavaScript/TypeScript' "$nvim_guide"
grep -q 'Python' "$nvim_guide"
grep -q 'optional and user-installed' "$nvim_guide"

grep -q 'Simple, concise Neovim config' "$nvim_config"
grep -q 'lazy.nvim' "$nvim_config"
grep -q 'nvim-lspconfig' "$nvim_config"
grep -q 'telescope.nvim' "$nvim_config"
grep -q 'gitsigns.nvim' "$nvim_config"
grep -q 'lualine.nvim' "$nvim_config"
grep -q 'lua_ls' "$nvim_config"

grep -q 'tmux -V' "$tmux_guide"
grep -q 'tmux -f' "$tmux_guide"
grep -q 'Ubuntu only' "$tmux_guide"
grep -q 'Windows-host tmux is out of scope' "$tmux_guide"
grep -q 'prefix' "$tmux_guide"
grep -q 'pane' "$tmux_guide"
grep -q 'window' "$tmux_guide"
grep -q 'mouse' "$tmux_guide"
grep -q 'status' "$tmux_guide"
grep -q 'copy-mode' "$tmux_guide"
grep -q 'no tmux plugins' "$tmux_guide"
grep -q 'daily-use baseline' "$tmux_guide"
grep -q 'tmux new -s dev' "$tmux_guide"
grep -q 'tmux attach -t dev' "$tmux_guide"
grep -q 'prefix d' "$tmux_guide"

grep -q 'set -g mouse on' "$tmux_config"
grep -q 'split-window -h' "$tmux_config"
grep -q 'split-window -v' "$tmux_config"
grep -q 'copy-mode-vi' "$tmux_config"
grep -q 'status-left' "$tmux_config"

if grep -qi '@plugin\|tmux-plugins\|tpm' "$tmux_config"; then
  echo "tmux config must not contain plugin manager or plugin declarations" >&2
  exit 1
fi

grep -q 'Neovim Windows' "$verification"
grep -q 'Neovim Ubuntu' "$verification"
grep -q 'tmux Ubuntu' "$verification"
grep -q 'nvim --version' "$verification"
grep -q ':checkhealth' "$verification"
grep -q 'tmux -V' "$verification"
grep -q 'tmux -f' "$verification"

if grep -Rqi 'supports native Windows tmux\\|tmux works natively on Windows' README.md docs/guides docs/troubleshooting; then
  echo "native Windows tmux support must not be claimed" >&2
  exit 1
fi
