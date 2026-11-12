# Set up Neovim on Windows and Ubuntu

**Prerequisites:** Windows PowerShell and Ubuntu are available, and this repository is available in the environment where you deploy the config.
**Time:** 10-20 minutes.
**Outcome:** Neovim is installed in Windows PowerShell and/or Ubuntu, with separate environment-local runtime state.
**Verify:** `nvim --version`, startup without config errors, plugin manager status, and `:checkhealth` complete in the environment under test.
**Scope:** User-local Neovim setup for Windows PowerShell and Ubuntu.
**Safety:** Replacing `%LocalAppData%\nvim` or `~/.config/nvim` changes editor behavior for that user.

## Fast path

1. Install Neovim where you need it.

   Run from Windows PowerShell:

   ```powershell
   winget install --id Neovim.Neovim --source winget
   ```

   Expected result: WinGet installs Neovim or reports that it is already installed.

   Run from Ubuntu:

   ```bash
   sudo apt update
   sudo apt install -y neovim
   ```

   Expected result: APT installs Neovim or reports that it is already installed.

2. Deploy the shared config separately per environment.

   Backup: if `%LocalAppData%\nvim` already exists, save a copy before replacing it.

   Backup: if `~/.config/nvim` already exists, save a copy before replacing it.

   Expected result: `config/nvim/init.lua` is available as the Neovim config in each environment you choose to configure.

3. Verify Neovim startup and health.

   Run from Windows PowerShell:

   ```powershell
   nvim --version
   ```

   Expected result: Windows Neovim prints its installed version.

   Run from Ubuntu:

   ```bash
   nvim --version
   nvim --clean +'quit'
   ```

   Expected result: Ubuntu Neovim prints its installed version and starts without user config errors.

   Run inside Neovim after deploying the config:

   ```vim
   :Lazy
   ```

   ```vim
   :checkhealth
   ```

   Expected result: plugin manager status is readable and health checks report missing optional tools without blocking startup.

## Walkthrough

### 1. Install Neovim on Windows

Run from Windows PowerShell:

```powershell
winget install --id Neovim.Neovim --source winget
```

Expected result: WinGet installs Neovim or reports that it is already installed.

Verify:

```powershell
nvim --version
```

Expected result: Windows Neovim prints its installed version.

If WinGet or Microsoft Store/App Installer access is blocked by policy, use [Enterprise policy issues](../windows/setup.md#enterprise-policy-troubleshooting).

### 2. Install Neovim on Ubuntu

Run from Ubuntu:

```bash
sudo apt update
sudo apt install -y neovim
```

Expected result: APT installs Neovim or reports that it is already installed.

Verify:

```bash
nvim --version
```

Expected result: Ubuntu Neovim prints its installed version.

If the Ubuntu package is older than your needs, use an official Neovim release channel and record the source in verification notes. If HTTPS package access fails, use [WSL SSL certificate trust fails](../networking/proxy.md#wsl-ssl-certificate-trust-fails).

### 3. Use the Ubuntu release-tarball fallback when needed

Use this fallback when Ubuntu 24.04 package sources, enterprise mirrors, or distro policy cannot provide the needed stable Neovim version.

This path installs Neovim under `/opt/nvim-linux-x86_64` and exposes it as `/usr/local/bin/nvim`. It does not remove the distro `neovim` package, but `/usr/local/bin` normally has priority over `/usr/bin`.

Run from Ubuntu to install prerequisites:

```bash
sudo apt update
sudo apt install -y curl tar gzip git ripgrep fd-find
```

Expected result: prerequisite tools install without errors.

Run from Ubuntu to download and install the tested stable release:

```bash
cd /tmp
curl -LO https://github.com/neovim/neovim-releases/releases/download/v0.12.2/nvim-linux-x86_64.tar.gz

sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
```

Expected result: `/usr/local/bin/nvim` points to the release tarball binary.

Verify the selected binary:

```bash
command -v nvim
nvim --version
```

Expected result:

- `command -v nvim` resolves to `/usr/local/bin/nvim`.
- `nvim --version` reports the installed stable release.

Rollback for the fallback install:

```bash
sudo rm -f /usr/local/bin/nvim
sudo rm -rf /opt/nvim-linux-x86_64
hash -r
command -v nvim || true
```

Expected result: the fallback binary and symlink are removed. If the distro package is still installed, `command -v nvim` may fall back to `/usr/bin/nvim`.

### 4. Deploy the config per environment

The source config lives in one file:

- `config/nvim/init.lua`: single-file shared config for Windows and Ubuntu.

Deploy or sync the same source config separately into each environment:

- Windows target: `%LocalAppData%\nvim`
- Ubuntu target: `~/.config/nvim`

- Scope: writes user-local Neovim config in the selected environment.
- Backup: if `%LocalAppData%\nvim` already exists, save a copy before replacing it.
- Backup: if `~/.config/nvim` already exists, save a copy before replacing it.
- Rollback: restore the backed-up config directory or remove the project-owned files.

Expected result: each configured environment has the shared `init.lua` while keeping plugin and runtime state environment-local.

Do not share plugin or runtime state through a Windows-mounted path. Do not put plugin or runtime state on `D:\Data`, `/home/<user>/data`, or another Windows-mounted path. Let each environment keep its own plugin cache and runtime state.

### 5. Keep the editing profile minimal

Core profile:

- editing options, search behavior, splits, clipboard, and diagnostics keymaps;
- file and text navigation through Telescope;
- Git change indicators through Gitsigns;
- a compact statusline through Lualine;
- LSP wiring with Lua enabled by default when `lua-language-server` is installed.

Additional language support is optional and user-installed:

- Markdown can use tools such as Marksman, markdownlint, or Prettier.
- Shell can use tools such as Bash language server, ShellCheck, or shfmt.
- PowerShell can use PowerShell Editor Services.
- JavaScript/TypeScript can use TypeScript, ESLint, and Prettier tools.
- Python can use Pyright and Ruff tools.

The config stays concise and enables only the tools you have installed. Installing language servers, formatters, and linters is outside the broad runtime setup scope for this first slice; missing tools should be reported clearly by Neovim health checks or future doctor checks.

### 6. Verify startup, plugins, and health

Run separately in Windows PowerShell and Ubuntu:

```powershell
nvim --version
```

```bash
nvim --version
```

Expected result: Windows and Ubuntu each report `nvim --version`.

Check startup without user config errors:

```bash
nvim --clean +'quit'
```

Expected result: Neovim starts and exits without user config errors.

After deploying this config, check plugin manager status with the installed plugin manager. For Lazy, use the Neovim command:

```vim
:Lazy
```

Expected result: plugin manager status shows the baseline plugins installed or clearly reports missing installation steps.

Run health checks:

```vim
:checkhealth
```

Expected result: `:checkhealth` identifies missing language tools without blocking unrelated editor startup.

The minimal plugin baseline is intentionally small:

- `neovim/nvim-lspconfig` for LSP diagnostics.
- `nvim-telescope/telescope.nvim` for file and text navigation.
- `lewis6991/gitsigns.nvim` for Git change indicators.
- `nvim-lualine/lualine.nvim` for a compact statusline.
- `folke/tokyonight.nvim` for a predictable colorscheme.

Keep plugin manager lockfiles environment-local or intentionally copied. Do not share plugin or runtime state through a Windows-mounted path.

## Rollback

- Windows: restore the backed-up `%LocalAppData%\nvim` directory or remove the project-owned files.
- Ubuntu: restore the backed-up `~/.config/nvim` directory or remove the project-owned files.
- Ubuntu release-tarball fallback: remove `/usr/local/bin/nvim` and `/opt/nvim-linux-x86_64` with the fallback rollback commands above.
- Remove environment-local plugin manager cache or lockfiles only after confirming no wanted editor state is inside.

## Troubleshooting

Use the targeted entry that matches the symptom:

- WinGet, Microsoft Store/App Installer, or package source is blocked: [Enterprise policy issues](../windows/setup.md#enterprise-policy-troubleshooting)
- Ubuntu HTTPS package or plugin download fails: [WSL SSL certificate trust fails](../networking/proxy.md#wsl-ssl-certificate-trust-fails)
