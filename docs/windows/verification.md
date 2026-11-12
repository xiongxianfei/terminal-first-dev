# Verify the terminal-first workstation

**Prerequisites:** Complete the setup guide paths you want to verify. Use unresolved follow-ups in the inventory instead of active guide links for targets that are not converted yet.
**Time:** 10-20 minutes for static checks and manual command review; longer if you run every workstation command on Windows and Ubuntu.
**Outcome:** Each setup layer has a recorded result using `pass`, `fail`, `skipped`, or `needs manual action`.
**Verify:** `bash tests/markdown/remaining-guides-template-rollout.test.sh` passes for the documentation contract, and manual workstation checks record their result state.
**Scope:** Verification reads workstation state and may create short-lived local sessions. It does not replace the setup guides.
**Backup:** Not applicable for read-only verification. If you save local result logs, keep them scrubbed of secrets, proxy credentials, tokens, private hostnames, and private machine paths.
**Rollback:** Rerun the affected check after correcting setup state, or restore the previous verification record if a result was recorded incorrectly.
**Safety:** Do not treat manual Windows or machine-changing checks as passed unless they were actually run. Verification output must not include secrets, proxy credentials, tokens, private hostnames, or private machine paths beyond documented examples.

## Fast path

1. Verify the active guide paths exist.

   Run from Ubuntu:

   ```bash
   test -f docs/guides/01-windows-host.md
   test -f docs/guides/wsl-ubuntu-install.md
   test -f docs/guides/wsl-ubuntu-migration.md
   test -f docs/guides/proxy-setup.md
   test -f docs/guides/04-neovim.md
   test -f docs/guides/05-tmux.md
   test -f docs/guides/06-uv.md
   ```

   Expected result: every active verification reference exists. The current unresolved Ubuntu baseline target is listed in the verification target inventory instead of linked as an active verification step.

2. Run the static documentation checks.

   Run from Ubuntu:

   ```bash
   bash tests/markdown/m1-project-entrypoint.test.sh
   bash tests/markdown/m2-windows-wsl-storage.test.sh
   bash tests/markdown/m3-ubuntu-baseline.test.sh
   bash tests/markdown/m4-neovim-tmux.test.sh
   bash tests/markdown/m5-release-readiness.test.sh
   bash tests/markdown/remaining-guides-template-rollout.test.sh
   ```

   Expected result: each check exits successfully. Any failure is `fail` for the matching documentation layer until corrected.

3. Record workstation-layer results.

   Run from the environment named in the verification matrix:

   ```text
   pass
   fail
   skipped
   needs manual action
   ```

   Expected result: every layer uses exactly one result state. Manual Windows checks that were not run are `needs manual action` or `skipped`, not `pass`.

## Walkthrough

### 1. Verify the active guide paths exist

The verification guide is a proof surface, not a setup guide. It can link active verification targets only when the path exists after this slice. Targets that are missing or not yet converted belong in `archive/legacy/docs/changes/2026-06-16-remaining-guides-template-rollout/verification-target-inventory.md` as unresolved follow-ups.

Run from Ubuntu:

```bash
test -f docs/guides/01-windows-host.md
test -f docs/guides/wsl-ubuntu-install.md
test -f docs/guides/wsl-ubuntu-migration.md
test -f docs/guides/proxy-setup.md
test -f docs/guides/04-neovim.md
test -f docs/guides/05-tmux.md
test -f docs/guides/06-uv.md
```

Expected result: every active verification reference exists. The old WSL compatibility path remains `docs/windows/wsl.md`, but verification should use the install and migration task guides.

Active verification references:

- [Windows host](setup.md)
- [WSL Ubuntu install](wsl-ubuntu-install.md)
- [WSL Ubuntu migration](wsl-ubuntu-migration.md)
- [Proxy setup](../networking/proxy.md)
- [Neovim setup](../tools/neovim.md)
- [tmux setup](../tools/tmux.md)
- [uv setup](../tools/uv.md)

Unresolved verification follow-up: Ubuntu baseline remains covered by legacy checks and `docs/linux/ubuntu-setup.md`, but it is not an active converted-guide verification link in this slice.

### 2. Run the static documentation checks

Static checks prove documentation structure, link targets, and rollout-specific contracts without executing workstation setup commands.

Run from Ubuntu:

```bash
bash tests/markdown/m1-project-entrypoint.test.sh
bash tests/markdown/m2-windows-wsl-storage.test.sh
bash tests/markdown/m3-ubuntu-baseline.test.sh
bash tests/markdown/m4-neovim-tmux.test.sh
bash tests/markdown/m5-release-readiness.test.sh
bash tests/markdown/remaining-guides-template-rollout.test.sh
```

Expected result: each check exits successfully.

Run staged whitespace validation before review:

```bash
git diff --cached --name-only
git diff --cached --check
```

Expected result: the staged file list contains only the intended milestone files, and staged whitespace validation passes.

For local editing prechecks, a path-scoped working-tree check is acceptable. The repository-wide `git diff --check` is advisory while known unrelated baseline drift exists.

### 3. Record workstation-layer results

Use this result vocabulary for every layer: `pass`, `fail`, `skipped`, or `needs manual action`.

In plain text, every doctor result is one of: pass, fail, skipped, or needs manual action.

#### Verification matrix

| Layer | Environment | Active guide target | Required observation | Result states |
| --- | --- | --- | --- | --- |
| Windows host | Windows PowerShell | [Windows host](setup.md) | `pwsh`, `winget`, `wt`, and WSL availability commands report versions or status | `pass`, `fail`, `skipped`, `needs manual action` |
| WSL storage | Windows PowerShell | [WSL Ubuntu install](wsl-ubuntu-install.md) or [WSL Ubuntu migration](wsl-ubuntu-migration.md) | fresh install or migration uses `D:\Software\WSL\Ubuntu` and verifies the distro with `wsl --list --verbose` | `pass`, `fail`, `skipped`, `needs manual action` |
| WSL config | Ubuntu shell and Windows PowerShell | unresolved verification follow-up | `/etc/wsl.conf` contains the documented automount and interop posture after WSL restart | `pass`, `fail`, `skipped`, `needs manual action` |
| Ubuntu baseline | Ubuntu shell | unresolved verification follow-up | baseline checks can run without locale, mount, or sudoers warnings | `pass`, `fail`, `skipped`, `needs manual action` |
| proxy | Windows PowerShell and Ubuntu shell | [Proxy setup](../networking/proxy.md) | automatic proxy mirroring or manual proxy fallback supports package/network access | `pass`, `fail`, `skipped`, `needs manual action` |
| data mount | Ubuntu shell | unresolved verification follow-up | `/home/<user>/data` reaches `D:\Data` through fstab or fallback symlink | `pass`, `fail`, `skipped`, `needs manual action` |
| locale | Ubuntu shell | unresolved verification follow-up | `locale` is warning-free and `locale charmap` reports `UTF-8` | `pass`, `fail`, `skipped`, `needs manual action` |
| sudo | Ubuntu shell | unresolved verification follow-up | optional passwordless sudo is either skipped or passes `visudo` and non-interactive sudo checks | `pass`, `fail`, `skipped`, `needs manual action` |
| Neovim Windows | Windows PowerShell and Neovim command | [Neovim setup](../tools/neovim.md) | Windows Neovim reports version, starts cleanly, and has reviewed plugin and health status | `pass`, `fail`, `skipped`, `needs manual action` |
| Neovim Ubuntu | Ubuntu shell and Neovim command | [Neovim setup](../tools/neovim.md) | Ubuntu Neovim reports version, starts cleanly, and has reviewed plugin and health status | `pass`, `fail`, `skipped`, `needs manual action` |
| tmux Ubuntu | Ubuntu shell and tmux command | [tmux setup](../tools/tmux.md) | tmux reports version and loads the project config in a clean session | `pass`, `fail`, `skipped`, `needs manual action` |
| uv optional tooling | Windows PowerShell or Ubuntu shell | [uv setup](../tools/uv.md) | uv is either intentionally skipped or reports its version and package-source posture | `pass`, `fail`, `skipped`, `needs manual action` |

#### Windows host checks

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

Expected result: each available tool reports a version or status. Missing or policy-blocked tools are `needs manual action`.

#### WSL install and migration checks

Before fresh install, record from Windows PowerShell:

```powershell
wsl --version
wsl --help
wsl --list --online
```

After fresh install, record from Windows PowerShell:

```powershell
wsl --list --verbose
wsl -d <UbuntuLtsDistroName>
```

Expected result: the selected explicit Ubuntu LTS distro appears in verbose output and launches.

After import-in-place migration, record from Windows PowerShell:

```powershell
wsl --list --verbose
wsl -d Ubuntu
```

Expected result: the imported distro appears, launches, and is the intended default after `wsl --set-default Ubuntu`.

#### Ubuntu baseline follow-up checks

These checks remain associated with the unresolved Ubuntu baseline follow-up until that guide is converted. Run them only when the relevant Ubuntu setup path has been completed.

Run WSL config and proxy checks after Ubuntu has restarted from Windows PowerShell:

```powershell
wsl --shutdown
```

Then run Ubuntu-side checks from the Ubuntu shell.

Check WSL config:

```bash
test -f /etc/wsl.conf
grep -n 'mountFsTab=true' /etc/wsl.conf
```

Expected result: WSL config is `pass` when `/etc/wsl.conf` includes the documented automount and interop posture. Missing or intentionally deferred config is `needs manual action` or `skipped`, depending on the user's choice.

Check proxy state:

```bash
env | grep -Ei '^(http_proxy|https_proxy|no_proxy)=' || true
```

Expected result: proxy is `pass` when automatic proxy mirroring or manual proxy fallback supports package/network access. Environments that require PAC or corporate CA setup beyond the first slice are `needs manual action`.

Check data mount:

```bash
sudo mount -a
findmnt "$HOME/data"
```

Expected result: data mount is `pass` when `/home/<user>/data` reaches `D:\Data` through fstab or the documented fallback symlink. Missing `D:\Data` may be `skipped` when the user intentionally skips shared data setup.

Check locale:

```bash
locale
locale charmap
```

Expected result: locale is `pass` when output is warning-free and `locale charmap` reports `UTF-8`. `C.UTF-8` is the healthy default; user-selected UTF-8 locales are also acceptable when warning-free.

Check optional sudo profile:

```bash
sudo visudo -cf /etc/sudoers.d/terminal-first-windows-dev
sudo -n true
```

Expected result: sudo is `pass` only when passwordless sudo was intentionally enabled and both checks pass. If the user skipped the personal-workstation convenience profile, report sudo as `skipped`, not failed.

#### Neovim checks

Check Neovim Windows separately from Neovim Ubuntu. Do not treat one environment as proof for the other.

Run from Windows PowerShell:

```powershell
nvim --version
```

Run from Ubuntu:

```bash
nvim --version
nvim --clean +'quit'
```

After deploying the project config, open Neovim and run from inside Neovim:

```vim
:checkhealth
```

If Lazy is used as the plugin manager, check plugin manager status from inside Neovim:

```vim
:Lazy
```

Expected result: Neovim Windows and Neovim Ubuntu each report `pass` only when the local binary works, startup has no config errors, plugin manager status is understood, and `:checkhealth` is reviewed. Missing optional JavaScript/TypeScript or Python tools should not fail the core editor profile.

#### tmux Ubuntu checks

Run from Ubuntu:

```bash
tmux -V
tmux -f config/tmux/tmux.conf new-session -d -s terminal-first-check
tmux kill-session -t terminal-first-check
```

Expected result: tmux Ubuntu is `pass` when `tmux -V` works and the config loads in a clean session. Native Windows tmux is `skipped` because it is outside the first slice.

## Publication gate

Before publishing a release or treating the guide as final, maintainers must record tested versions in `archive/legacy/docs/release-notes/2026-05-24-tested-versions.md` or a newer release note.

The version policy is latest stable at setup time, not preview or nightly. Pin only where reproducibility matters, such as Neovim plugin lockfiles.

The WSL install-location command contract must include:

- official Microsoft Learn evidence for `wsl --install`, `--distribution`, `--location`, `wsl --list --online`, `wsl --help`, and `wsl --list --verbose`;
- a local or release-captured `wsl --help` excerpt showing the required options;
- the primary command `wsl --install --distribution <UbuntuLtsDistroName> --location "D:\Software\WSL\Ubuntu"`;
- a negative check that `wsl --install Ubuntu --location ...` is not published as the primary command.

Reference: Microsoft Learn, Basic commands for WSL, `https://learn.microsoft.com/en-us/windows/wsl/basic-commands`.

Manual Windows checks that cannot run from this Linux workspace must be marked `unrun` or `needs manual action`; do not treat them as passed.

## Static checks

Run the milestone static checks before review:

```bash
bash tests/markdown/m1-project-entrypoint.test.sh
bash tests/markdown/m2-windows-wsl-storage.test.sh
bash tests/markdown/m3-ubuntu-baseline.test.sh
bash tests/markdown/m4-neovim-tmux.test.sh
bash tests/markdown/m5-release-readiness.test.sh
```

Expected result: each static check exits successfully.

Run config smoke checks only where tools are available:

```bash
nvim --headless --cmd 'set runtimepath^=config/nvim' -u config/nvim/init.lua +qa
tmux -f config/tmux/tmux.conf new-session -d -s terminal-first-check
tmux kill-session -t terminal-first-check
```

Expected result: available local tools exit successfully. Missing optional local tools should be recorded as `skipped` or `needs manual action`.

## Rollback

Verification rollback means restoring the prior verification record or rerunning the relevant check after correcting setup state.

Rollback coverage must exist for:

- WSL relocation: preserve the VHDX/export and reset the default distro only after verification.
- `.wslconfig`: remove project-owned `autoProxy=true` or restore the backup, then run `wsl --shutdown`.
- `/etc/wsl.conf`: restore the backup or remove project-owned entries, then restart WSL.
- `/etc/fstab`: remove project-owned data mount entries or restore the backup, then run `sudo mount -a`.
- sudoers: remove `/etc/sudoers.d/terminal-first-windows-dev`, then run `sudo visudo -c`.
- proxy fallback: unset shell variables or remove project-owned profile lines.
- Neovim config: restore backed-up `%LocalAppData%\nvim` or `~/.config/nvim`.
- tmux config: restore backed-up `~/.tmux.conf` or remove the project-owned tmux config.

## Troubleshooting

Use the targeted entry that matches the symptom:

- WSL install, migration, or storage verification fails: [WSL issues](wsl-troubleshooting.md)
- Proxy verification fails: [Proxy and certificate issues](../networking/proxy.md#proxy-troubleshooting)
- Ubuntu baseline verification fails: [Ubuntu baseline issues](../linux/ubuntu-setup.md#ubuntu-baseline-troubleshooting)
- Enterprise policy blocks Windows host verification: [Enterprise policy issues](setup.md#enterprise-policy-troubleshooting)
