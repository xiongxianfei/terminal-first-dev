# Verify the Windows/WSL workstation

Use this checklist after the relevant setup steps. Repository checks and workstation checks are separate: passing one does not prove the other works.

**Prerequisites:** A repository checkout, Python 3.10+ for static checks, and the relevant Windows/Ubuntu tools for manual checks.
**Results:** Record each layer as `pass`, `fail`, `skipped`, or `needs manual action`, with the tested platform, versions, and date.
**Safety:** Static checks read repository content. Some optional workstation checks below restart WSL, mount filesystems, start tmux sessions, or execute Neovim configuration. Review the corresponding setup and rollback instructions first. Never publish logs containing credentials, tokens, private hostnames, or private machine paths.

## Repository checks

Run from the repository root in Ubuntu/WSL or another environment with Python 3.10+:

```bash
python3 -m unittest discover -s tests -p 'test_*.py' -v
python3 tests/check_docs.py
```

Expected result: unit tests pass, and the documentation checker reports valid local links, anchors, and repository command paths. These checks do not install software or validate a real Windows/WSL workstation. External URLs and archived historical records are outside their scope.

Before committing, review the staged changes. Recognize Windows CRLF line endings without rewriting historical files:

```bash
git diff --cached --name-only
git -c core.whitespace=blank-at-eol,blank-at-eof,space-before-tab,cr-at-eol diff --cached --check
```

Record new test results in the relevant maintained note or pull request, not in the frozen archive. See [the editing guide](../../AGENTS.md#checks).

## Workstation checks

Run only the checks for setup steps you actually chose. An unrun check is `skipped` or `needs manual action`, never `pass`.

| Layer | Environment | Setup reference | Expected observation |
| --- | --- | --- | --- |
| Windows host | PowerShell | [Host setup](setup.md) | Tool versions or status are available. |
| WSL storage | PowerShell | [Install](wsl-ubuntu-install.md) / [migration](wsl-ubuntu-migration.md) | The intended distro is registered, launches, and uses the reviewed storage location. |
| WSL config and Ubuntu baseline | Ubuntu and PowerShell | [Ubuntu baseline](../linux/ubuntu-setup.md) | Selected configuration, data mount, locale, and sudo settings pass their checks. |
| proxy | Ubuntu and PowerShell | [Proxy setup](../networking/proxy.md) | The chosen proxy posture permits required package/network access. |
| Neovim Windows and Neovim Ubuntu | Each environment separately | [Neovim](../tools/neovim.md) | The local binary starts and configuration health is reviewed. |
| tmux Ubuntu | Ubuntu | [tmux](../tools/tmux.md) | Version and configuration checks succeed. |
| Optional uv | PowerShell or Ubuntu | [uv](../tools/uv.md) | The selected installation passes the guide's checks, or is intentionally skipped. |

### Windows host

Run from Windows PowerShell:

```powershell
pwsh --version
winget --version
wt --version
wsl --version
```

If `wsl --version` is unavailable, capture:

```powershell
wsl --status
```

Each available tool should report a version or status. Missing or policy-blocked tools require manual action; use the policy-approved installation path rather than bypassing restrictions.

### WSL install and migration

Before fresh installation, record from Windows PowerShell:

```powershell
wsl --version
wsl --help
wsl --list --online
```

Confirm required options against the local help output; do not assume every WSL version supports `--location` or import-in-place.

After fresh installation:

```powershell
wsl --list --verbose
wsl -d <UbuntuLtsDistroName>
```

After the documented import-in-place migration:

```powershell
wsl --list --verbose
wsl -d Ubuntu
```

The intended distro should appear and launch. Confirm the chosen storage location using the [storage checks](wsl-troubleshooting.md#storage-path-checks), and retain the verified export/backup until migration is confirmed.

### Ubuntu baseline

Run only after completing the relevant [Ubuntu baseline steps](../linux/ubuntu-setup.md). These assumptions are for Ubuntu in WSL2, not arbitrary native Linux machines.

If WSL configuration changed, save work and stop running jobs before restarting WSL from PowerShell:

```powershell
wsl --shutdown
```

Reopen Ubuntu and check WSL config:

```bash
test -f /etc/wsl.conf
grep -n 'mountFsTab=true' /etc/wsl.conf
```

Review the complete configuration against the setup note; finding one line alone does not prove all intended settings are active.

Inspect proxy state locally; the output may contain credentials and must not be pasted into public logs:

```bash
env | grep -Ei '^(http_proxy|https_proxy|no_proxy)=' || true
```

Use the [proxy verification steps](../networking/proxy.md) to test actual access. Environment variables alone do not prove connectivity.

Check the optional data mount only after reviewing `/etc/fstab`; `sudo mount -a` attempts configured mounts:

```bash
sudo mount -a
findmnt "$HOME/data"
```

The intended `/home/<user>/data` should reach `D:\Data` through the configured mount or documented fallback symlink. A deliberately omitted shared data setup is `skipped`.

Check locale:

```bash
locale
locale charmap
```

Output should be warning-free and report UTF-8. `C.UTF-8` is the documented default; another warning-free UTF-8 locale is acceptable.

Check the optional sudo profile only when it was intentionally enabled:

```bash
sudo visudo -cf /etc/sudoers.d/terminal-first-windows-dev
sudo -n true
```

Both checks must succeed for `pass`. Skipping passwordless sudo is a valid choice, not a failure.

### Neovim

Check Neovim Windows separately from Neovim Ubuntu. Success in one environment does not validate the other.

From Windows PowerShell:

```powershell
nvim --version
```

From Ubuntu:

```bash
nvim --version
nvim --clean +'quit'
```

After deploying the configuration, run inside Neovim:

```vim
:checkhealth
```

When using Lazy, inspect plugin state:

```vim
:Lazy
```

Review startup errors, plugin state, and health output. Missing optional language tools need not fail the core editor profile.

### tmux on Ubuntu

From the repository root, check the version and load the configuration in the named test session:

```bash
tmux -V
tmux -f config/tmux/tmux.conf new-session -d -s terminal-first-check
tmux kill-session -t terminal-first-check
```

Use this session name only when it is not already in use. This guide does not provide native Windows tmux verification.

### Optional configuration smoke checks

Only run where the tools are installed, after reading the configurations. Neovim configuration may load plugins or perform network activity; this is not part of static CI.

```bash
nvim --headless --cmd 'set runtimepath^=config/nvim' -u config/nvim/init.lua +qa
tmux -f config/tmux/tmux.conf new-session -d -s terminal-first-check
tmux kill-session -t terminal-first-check
```

Record missing tools as `skipped` or `needs manual action`, rather than claiming success.

## Failures and rollback

Stop at a failed check. Correct the corresponding setup step using its backup/rollback guidance, then rerun the affected verification. Preserve WSL exports, restore reviewed configuration backups where needed, and never treat a failed sudoers or mount validation as a successful setup.

- [WSL recovery](wsl-troubleshooting.md)
- [Proxy and certificate issues](../networking/proxy.md#proxy-troubleshooting)
- [Ubuntu baseline troubleshooting](../linux/ubuntu-setup.md#ubuntu-baseline-troubleshooting)
- [Windows policy caveats](setup.md#enterprise-policy-troubleshooting)
