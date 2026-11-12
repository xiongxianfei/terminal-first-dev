# Install optional uv tooling

**Prerequisites:** Windows PowerShell and/or Ubuntu are available, depending on where you want `uv`.
**Time:** 5-10 minutes per environment.
**Outcome:** `uv` is installed where you need it and package-index configuration stays credential-free.
**Verify:** `uv --version` succeeds in the environment where you installed `uv`.
**Scope:** Optional Python package and project tooling for Windows PowerShell and Ubuntu.
**Safety:** Package-index configuration can affect dependency resolution. Keep credentials out of committed files and shell history.

## Fast path

1. Install uv in the environment that needs it.

   Run from Windows PowerShell:

   ```powershell
   powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
   ```

   Expected result: the installer adds `uv` for the current Windows user.

   Run from Ubuntu:

   ```bash
   curl -LsSf https://astral.sh/uv/install.sh | sh
   ```

   Expected result: the installer adds `uv` for the current Ubuntu user.

2. Restart the shell or refresh the environment, then verify.

   Run from the environment where you installed `uv`:

   ```bash
   uv --version
   ```

   Expected result: `uv` prints its installed version.

3. Keep package-index configuration project-scoped when it belongs to a project.

   Backup: not applicable when creating a new disposable project-owned example. If editing an existing `pyproject.toml` or user `uv.toml`, save a copy before changing it.

   Rollback: remove only the package-index entry you added.

   Project-level example:

   ```toml
   [[tool.uv.index]]
   name = "project-mirror"
   url = "https://example.org/simple"
   default = true
   ```

   Expected result: the index source is explicit and contains no credentials, tokens, or private hostnames.

## Walkthrough

### 1. Decide whether uv is needed

Optional uv setup does not make Python runtime setup mandatory for the core terminal-first workstation. Install `uv` only when you want it for Python package or project workflows.

Use separate installs for Windows PowerShell and Ubuntu. Each environment owns the `uv` binary installed into that environment.

### 2. Install uv on Windows

Run from Windows PowerShell:

```powershell
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
```

Expected result: the installer adds `uv` for the current Windows user and prints any shell refresh instructions.

Restart PowerShell or refresh the environment, then verify:

```powershell
uv --version
```

Expected result: `uv` prints its installed version.

### 3. Install uv on Ubuntu

Run from Ubuntu:

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

Expected result: the installer adds `uv` for the current Ubuntu user and prints any shell refresh instructions.

Restart the shell or source the shell profile modified by the installer, then verify:

```bash
uv --version
```

Expected result: `uv` prints its installed version.

If HTTPS access fails from Ubuntu, use [WSL SSL certificate trust fails](../networking/proxy.md#wsl-ssl-certificate-trust-fails).

### 4. Update uv

When installed by the standalone installer, update with:

```bash
uv self update
```

Expected result: `uv` reports that it is already current or updates successfully.

Run the same command from Windows PowerShell or Ubuntu, depending on which environment owns the installed `uv` binary. If `uv` was installed through another package manager, update it through that same package manager instead.

### 5. Configure package indexes without committing secrets

Project-level configuration belongs in `pyproject.toml` when the package source is part of the project contract.

Backup: if the project already has `pyproject.toml`, save a copy before editing it.

Project-level example:

```toml
[[tool.uv.index]]
name = "project-mirror"
url = "https://example.org/simple"
default = true
```

Expected result: the project source is explicit and credential-free.

User-level workstation defaults belong in `uv.toml` in the user config directory.

Backup: if user-level `uv.toml` already exists, save a copy before editing it.

User-level example:

```toml
[[index]]
name = "workstation-default"
url = "https://example.org/simple"
default = true
```

Expected result: the user-level default is explicit and credential-free.

Use environment variables only for temporary shell sessions or secret-free examples:

```bash
export UV_DEFAULT_INDEX="https://example.org/simple"
```

Expected result: the temporary shell session uses the example index without writing credentials to project files.

Best practices:

- Use `[[tool.uv.index]]` in `pyproject.toml` when the source is part of the project contract.
- Use user-level `uv.toml` when the source is a personal workstation default.
- Keep credentials out of config files. Use environment variables, keyring, or policy-approved credential storage.
- Keep the default `first-index` strategy unless you intentionally accept dependency-confusion risk.

### 6. Verify uv behavior

Run from the environment where `uv` is installed:

```bash
uv --version
uv python list
```

Expected result: `uv` prints its version and lists available Python installations or reports what it needs to discover them.

For index configuration, test with a package approved for the selected source:

```bash
uv pip install --dry-run --default-index https://example.org/simple <package-name>
```

Expected result: the dry run shows what would be installed without installing packages.

## Rollback

Rollback: remove only the installed `uv` binary or configuration entries created by this guide.

Remove the installed `uv` binary through the same install channel used to install it. Remove only the user-level or project-level `uv` config entries you created.

## Troubleshooting

Use the targeted entry that matches the symptom:

- Windows installer or package source is blocked by policy: [Enterprise policy issues](../windows/setup.md#enterprise-policy-troubleshooting)
- Ubuntu HTTPS package access fails: [WSL SSL certificate trust fails](../networking/proxy.md#wsl-ssl-certificate-trust-fails)
