# Set up tmux in Ubuntu

**Prerequisites:** Ubuntu on WSL is installed and this repository is available from the Ubuntu shell.
**Time:** 5-10 minutes.
**Outcome:** tmux is installed in Ubuntu and the project tmux config can load in a clean session.
**Verify:** `tmux -V` succeeds and a clean disposable session loads `config/tmux/tmux.conf`.
**Scope:** Ubuntu user-local tmux setup. Ubuntu only; Windows-host tmux is out of scope.
**Safety:** Replacing `~/.tmux.conf` changes tmux behavior for the current Ubuntu user.

## Fast path

1. Install tmux.

   Run from Ubuntu:

   ```bash
   sudo apt update
   sudo apt install -y tmux
   ```

   Expected result: APT finishes without errors and tmux is available in Ubuntu.

2. Install the project tmux config.

   Backup: if `~/.tmux.conf` already exists, save a copy before replacing it.

   Run from Ubuntu at the repository root:

   ```bash
   cp config/tmux/tmux.conf ~/.tmux.conf
   ```

   Expected result: `~/.tmux.conf` contains the project tmux config for the current Ubuntu user.

3. Verify tmux and the config.

   Run from Ubuntu at the repository root:

   ```bash
   tmux -V
   tmux -f config/tmux/tmux.conf new-session -d -s terminal-first-check
   tmux kill-session -t terminal-first-check
   ```

   Expected result: `tmux -V` prints a version and the clean disposable session starts and stops without errors.

## Walkthrough

### 1. Install tmux

tmux support in this guide is scoped to Ubuntu on WSL. The current project setup does not configure a Windows-host tmux package or terminal integration.

Run from Ubuntu:

```bash
sudo apt update
sudo apt install -y tmux
```

Expected result: APT finishes without errors.

Verify:

```bash
tmux -V
```

Expected result: tmux prints its installed version.

### 2. Install the project tmux config

The source config lives at `config/tmux/tmux.conf`. The target config is `~/.tmux.conf` for the current Ubuntu user.

- Scope: writes the current user's Ubuntu tmux config.
- Backup: if `~/.tmux.conf` already exists, save a copy before replacing it.
- Rollback: restore the backup or remove `~/.tmux.conf`.

Run from Ubuntu at the repository root:

```bash
cp config/tmux/tmux.conf ~/.tmux.conf
```

Expected result: `~/.tmux.conf` is replaced with the project config.

The config covers:

- prefix: tmux default `C-b`;
- pane split keys: `|` for horizontal and `-` for vertical;
- pane movement: `h`, `j`, `k`, and `l`;
- window indexing from 1 and automatic renumbering;
- mouse support;
- status bar with session and time;
- copy-mode using vi keys;
- no tmux plugins.

### 3. Try the daily-use baseline

Run from Ubuntu:

```bash
tmux new -s dev
```

Expected result: tmux opens a named session.

Detach and leave the session running:

```text
prefix d
```

Expected result: tmux returns to the shell and leaves the `dev` session running.

List sessions:

```bash
tmux ls
```

Expected result: the `dev` session appears in the session list.

Attach again:

```bash
tmux attach -t dev
```

Expected result: tmux reopens the `dev` session.

Common keys:

| Action | Key |
| --- | --- |
| Prefix | `C-b` |
| Split left/right | `prefix |` |
| Split top/bottom | `prefix -` |
| New window | `prefix c` |
| Next window | `prefix n` |
| Previous window | `prefix p` |
| Copy mode | `prefix [` |
| Detach | `prefix d` |

Inside copy mode, use vi-style movement, `v` to start selection, and `y` or `Enter` to copy.

### 4. Verify tmux and config loading

Run from Ubuntu:

```bash
tmux -V
```

Expected result: tmux prints its installed version.

Load the config in a clean disposable session from the repository root:

```bash
tmux -f config/tmux/tmux.conf new-session -d -s terminal-first-check
tmux kill-session -t terminal-first-check
```

Expected result: the clean disposable session starts and stops without errors.

Manual checks:

- prefix `C-b` sends tmux commands;
- pane splits work with `prefix |` and `prefix -`;
- windows start at index 1;
- mouse selection and pane focus work in Windows Terminal;
- copy-mode opens and uses vi-style selection.

## Rollback

Restore the backed-up `~/.tmux.conf` or remove the project-owned tmux config file. Kill only tmux sessions that were created for verification unless you intentionally want to reset active sessions.

## Troubleshooting

Use the targeted entry that matches the symptom:

- Package installation fails in a managed environment: [Enterprise policy issues](../windows/setup.md#enterprise-policy-troubleshooting)
- HTTPS package access fails in Ubuntu: [WSL SSL certificate trust fails](../networking/proxy.md#wsl-ssl-certificate-trust-fails)
