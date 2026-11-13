# uv

Manage Python packages, environments, and projects. uv is optional for this workstation setup; installing Python is not a prerequisite for the core terminal setup. Install uv separately in Ubuntu and Windows. Platform instructions below are unverified.

**Official resources:** [uv documentation](https://docs.astral.sh/uv/).

## Ubuntu 26.04

Requires Bash, `curl`, and CA certificates. Run inside native Ubuntu or the Ubuntu WSL distribution where you want uv. Stop if installation fails.

**1. Run in terminal:**

```bash
# Back up existing Bash profiles before the installer can edit them.
for uv_profile in ~/.bashrc ~/.profile ~/.bash_profile; do
    if [ -f "$uv_profile" ]; then cp --backup=numbered "$uv_profile" "$uv_profile.bak"; fi
done
# Executes downloaded upstream code; installs for this user without sudo.
# Review the installer and back up existing uv executables before replacement.
curl -LsSf https://astral.sh/uv/install.sh | sh
```

**2. Verify in a new Bash terminal:** follow the installer's PATH instructions. Check any installer-created entries before adding your own; keep each entry once.

```bash
command -v uv
uv --version
uv python list
```

Expect the intended executable, a version, and a list of installed or downloadable Python versions. Listing does not install Python. Continue with [first use](#first-use).

## Win11

Requires Windows PowerShell and HTTPS access to the installer. Run as the current user; an administrator terminal is not needed. Stop if installation fails.

**1. Run in a PowerShell terminal:** record the current user PATH before the installer updates it.

```powershell
[Environment]::GetEnvironmentVariable('Path', 'User') | Set-Content "$HOME\uv-user-path.$(Get-Date -Format yyyyMMddHHmmssfff).bak"
# Executes downloaded upstream code; back up existing uv executables first.
# ByPass applies to this child PowerShell process. Follow local execution policy.
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
```

**2. Verify in a new PowerShell terminal:** restart the terminal application if it still inherits the old PATH. Check installer-created PATH entries before adding any duplicates.

```powershell
Get-Command uv
uv --version
uv python list
```

Expect the intended executable, a version, and a list of installed or downloadable Python versions.

## First use

Run in either Ubuntu Bash or Windows PowerShell from a scratch directory outside an existing project. Choose an unused name instead of `uv-demo` if it already exists. Stop on errors. These commands create a project, a `.venv`, and a lockfile; uv may download Python when a suitable interpreter is missing.

```text
uv init --bare --no-package uv-demo
cd uv-demo
uv run python -c "print('Hello from uv')"
```

Expect `Hello from uv`. See [working on projects](https://docs.astral.sh/uv/guides/projects/) for adding dependencies and running project commands.

## Optional package-index configuration

Use a project setting when the package source is part of the project contract, or a user setting for workstation defaults. Requires Vim installed and available on PATH. Back up before editing; keep backup files out of Git. `https://example.org/simple` below is a placeholder: replace it with your approved index URL before verification.

Setting `default = true` replaces PyPI as the default source. Retain the default `first-index` strategy unless you deliberately accept dependency-confusion risk. Keep credentials out of TOML, committed files, and shell history; use policy-approved credential storage, keyring, or securely supplied environment variables. See [package indexes](https://docs.astral.sh/uv/concepts/indexes/).

### Project configuration

**1. Run in terminal:** from an existing project's root (for example, `uv-demo`), back up and open `pyproject.toml`. If a `uv.toml` already exists alongside it, substitute `uv.toml` for `pyproject.toml` in the backup/editor commands and use the `[[index]]` table shown under [user configuration](#user-configuration). That file takes precedence over `pyproject.toml`.

Ubuntu Bash:

```bash
cp --backup=numbered pyproject.toml pyproject.toml.bak
vim pyproject.toml
```

Windows PowerShell:

```powershell
Copy-Item pyproject.toml "pyproject.toml.$(Get-Date -Format yyyyMMddHHmmssfff).bak"
vim pyproject.toml
```

**2. Add to `pyproject.toml`:** append this table at the end, outside any multiline value. If the same index already exists, edit it in place. Keep index names unique and only one default index; replace an existing default rather than adding a second one. Preserve other project settings. Press `i` to edit; save and quit with `Esc`, then `:wq`.

```toml
[[tool.uv.index]]
name = "project-mirror"
url = "https://example.org/simple"
default = true
```

**3. Verify in a new terminal:** return to this project root and follow [verify index configuration](#verify-index-configuration).

### User configuration

**1. Run in terminal:** create the user config directory, back up an existing file, and open it. This setting applies across projects for the current user.

Ubuntu Bash — destination: `$XDG_CONFIG_HOME/uv/uv.toml`, or `~/.config/uv/uv.toml` when unset:

```bash
uv_config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/uv"
mkdir -p "$uv_config_dir"
if [ -f "$uv_config_dir/uv.toml" ]; then cp --backup=numbered "$uv_config_dir/uv.toml" "$uv_config_dir/uv.toml.bak"; fi
vim "$uv_config_dir/uv.toml"
```

Windows PowerShell — destination: `%APPDATA%\uv\uv.toml`:

```powershell
$uvConfigDir = Join-Path $env:APPDATA 'uv'
New-Item -ItemType Directory -Force -Path $uvConfigDir | Out-Null
$uvConfigFile = Join-Path $uvConfigDir 'uv.toml'
if (Test-Path $uvConfigFile) { Copy-Item $uvConfigFile "$uvConfigFile.$(Get-Date -Format yyyyMMddHHmmssfff).bak" }
vim $uvConfigFile
```

**2. Add to the user `uv.toml`:** append this table at the end. Edit an existing matching index instead of duplicating it, and keep only one default. Preserve unrelated settings. Press `i` to edit; save and quit with `Esc`, then `:wq`.

```toml
[[index]]
name = "workstation-default"
url = "https://example.org/simple"
default = true
```

**3. Verify in a new terminal:** use a scratch directory outside a project so project settings cannot override this default, then follow the check below. See [configuration discovery and precedence](https://docs.astral.sh/uv/concepts/configuration-files/).

### Verify index configuration

Replace `APPROVED_PACKAGE` with a package available from the intended source. Run in the directory specified above. Use an unused `.uv-index-check` directory name: creating an environment over an existing one can replace it. uv may download Python if needed; stop if environment creation fails.

Ubuntu Bash:

```bash
uv venv .uv-index-check
uv pip install --dry-run --python .uv-index-check/bin/python --verbose APPROVED_PACKAGE
```

Windows PowerShell:

```powershell
uv venv .uv-index-check
uv pip install --dry-run --python .uv-index-check\Scripts\python.exe --verbose APPROVED_PACKAGE
```

The dry run resolves packages without installing them; it can access the network and cache. Expect a successful resolution plan and inspect verbose output for the intended index. Add `--refresh` if cached metadata prevents checking source access. Do not share logs containing credentials or private hostnames. Afterward, remove only the disposable `.uv-index-check` directory created here; keep it out of Git.

Do not pass `--default-index` during this check: that would override the file being tested. Environment settings such as `UV_INDEX`, `UV_DEFAULT_INDEX`, or `UV_CONFIG_FILE` can also override it; check for these and for pip-specific settings if the result is unexpected.

### Temporary override

For a temporary, credential-free override in Ubuntu Bash, replace the example URL first. This affects only the current shell and its child processes; it is separate from verifying saved configuration.

```bash
export UV_DEFAULT_INDEX="https://example.org/simple"
# Run the intended uv command, then remove the override.
unset UV_DEFAULT_INDEX
```

### Configuration rollback

Reopen the same file with Vim, remove only the index table you added, or restore the prior table from its backup. Save with `Esc`, then `:wq`. Restore an entire backup only if no later edits would be lost. If this guide created a user `uv.toml` containing only that table, remove the file. Repeat verification in a new terminal using the restored source. Configuration rollback does not undo package installations or existing lockfile changes.

## Upgrade

Run in the environment that owns this standalone installation. Back up the executables and installer-modified profiles/PATH first: self-update reruns the installer and may change shell setup. Record the version so you can reinstall that version from the official installer if rollback is needed.

```text
uv --version
uv self update
uv --version
```

Expect an update or an already-current result. If installed through another package manager, update through that manager instead.

## Uninstall

For the standalone installs above, check the executable location first. The removal commands below permanently delete binaries at the default location; adjust only after confirming a custom or older install path. If another package manager installed uv, uninstall through that manager instead.

Ubuntu Bash:

```bash
command -v uv uvx
# Deletes only the standalone executables at the default location.
rm -f -- "$HOME/.local/bin/uv" "$HOME/.local/bin/uvx"
```

Windows PowerShell:

```powershell
Get-Command uv, uvx
# Deletes standalone executables; uvw.exe is present in newer releases.
Remove-Item "$HOME\.local\bin\uv.exe", "$HOME\.local\bin\uvx.exe"
if (Test-Path "$HOME\.local\bin\uvw.exe") { Remove-Item "$HOME\.local\bin\uvw.exe" }
```

Compare installer-modified profiles or user PATH with your backups and remove only uv-owned entries; retain shared directories needed by other tools. Use Vim for profile edits, save with `Esc`, then `:wq`, and verify in a new terminal with `command -v uv` or `Get-Command uv` that this installation is gone. Another copy on PATH may still be found.

Project environments, managed Python installations, tools, caches, and index configuration remain. Follow [configuration rollback](#configuration-rollback) for index edits; consult [upstream uninstallation](https://docs.astral.sh/uv/getting-started/installation/#uninstallation) before deleting stored data that other projects may need.

## Troubleshooting

- **uv missing or wrong version:** reopen the terminal application, then check `command -v uv` or `Get-Command uv`. Inspect installer PATH changes and older installations before adding entries.
- **Index ignored:** check file location, duplicate defaults, environment overrides, and the precedence rules linked above. Do not test the placeholder URL.
- Windows installer or package source blocked by policy: [Enterprise policy issues](../windows/setup.md#enterprise-policy-troubleshooting).
- Ubuntu HTTPS package access fails: [WSL SSL certificate trust fails](../networking/proxy.md#wsl-ssl-certificate-trust-fails).

[Official installation/update instructions](https://docs.astral.sh/uv/getting-started/installation/) and [CLI reference](https://docs.astral.sh/uv/reference/cli/), reviewed November 13, 2026. Documentation checks do not establish platform compatibility.
