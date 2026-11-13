# tmux

Keep terminal sessions running and split them into windows and panes. This guide covers Ubuntu on WSL; platform instructions below are unverified.

**Official resources:** [tmux wiki](https://github.com/tmux/tmux/wiki).

## Ubuntu 26.04 on WSL

Requires an installed Ubuntu WSL distribution, Bash, sudo access, and this repository in the Ubuntu filesystem. Run from the repository root in an Ubuntu terminal. The [project configuration](../../config/tmux/tmux.conf) was written for tmux 3.4 with the outer terminal reporting `xterm-256color`; check your terminal before adopting it. Stop if a command fails.

**1. Run in terminal:** install tmux and copy the configuration for the current Ubuntu user.

```bash
# Requires sudo; changes packages throughout this Ubuntu distribution.
sudo apt update && sudo apt install -y tmux

# Replaces ~/.tmux.conf. Back up an existing file before copying.
# Numbered backups preserve earlier copies on repeated runs.
if [ -e ~/.tmux.conf ]; then cp --backup=numbered ~/.tmux.conf ~/.tmux.conf.bak; fi
cp config/tmux/tmux.conf ~/.tmux.conf
```

The configuration enables mouse support, vi copy mode, window numbering from 1 with renumbering, and a session/time status bar. It uses no plugins. Copying the file does not reload an existing server.

### Verify in a new terminal

Open a new Ubuntu Bash terminal, return to the repository root, and run this block. `cmp` should be silent; the option checks should print `1` and `on`. Any configuration error means the check failed.

```bash
tmux -V
cmp config/tmux/tmux.conf ~/.tmux.conf

# Use a unique socket so the check cannot reuse an existing tmux server.
# The subshell cleans up only its disposable server, including after a failure.
(
    set -e
    tmux_check_dir=$(mktemp -d /tmp/tmux-check.XXXXXX)
    trap 'tmux -S "$tmux_check_dir/socket" kill-server 2>/dev/null || :; rm -f -- "$tmux_check_dir/socket"; rmdir -- "$tmux_check_dir"' EXIT
    tmux -S "$tmux_check_dir/socket" -f /dev/null new-session -d -s config-check 'sleep 300'
    # Explicit sourcing reports config errors to this client.
    tmux -S "$tmux_check_dir/socket" source-file "$PWD/config/tmux/tmux.conf"
    tmux -S "$tmux_check_dir/socket" show-options -gv base-index
    tmux -S "$tmux_check_dir/socket" show-options -gv mouse
)
```

### First use

Run outside tmux. Choose another name if `dev` already exists, or attach to it. A newly started server loads `~/.tmux.conf`; an existing server keeps its loaded settings. To apply the file to an existing server, deliberately run `tmux source-file ~/.tmux.conf` only when changing settings for all its sessions is acceptable.

```bash
tmux new -s dev
# Inside tmux: press Ctrl+B, release, then d to detach.
# Back in the outer shell:
tmux ls
tmux attach -t dev
```

`tmux ls` should list `dev`, and attaching should reopen it. `prefix` below means Ctrl+B followed by the listed key.

| Action | Key |
| --- | --- |
| Prefix | `C-b` |
| Split left/right | `prefix \|` |
| Split top/bottom | `prefix -` |
| Move between panes | `Alt` + arrow key |
| Resize pane | `prefix H/J/K/L` |
| New window | `prefix c` |
| Next window | `prefix n` |
| Previous window | `prefix p` |
| Copy mode | `prefix [` |
| Detach | `prefix d` |

Inside copy mode, use vi-style movement, `v` to start selection, and `y` or `Enter` to copy. Manually check both splits, numbering from 1, mouse selection/pane focus in Windows Terminal, and copy-mode selection. The disposable check alone does not verify these terminal interactions.

### Upgrade

```bash
# Record the installed version before upgrading.
tmux -V
# Requires sudo; updates the distribution's tmux package.
sudo apt update && sudo apt install --only-upgrade -y tmux
tmux -V
```

Repeat the isolated configuration check after upgrading. Existing servers keep running their old executable; finish their work and exit normally before starting a new server.

### Uninstall

Finish work and exit your tmux sessions first; closing a live session terminates its processes. Then run:

```bash
# Requires sudo; removes tmux for all users of this Ubuntu distribution.
sudo apt remove tmux
```

Your `~/.tmux.conf` remains. Use the rollback instructions to restore or remove it.

## Rollback

Compare `~/.tmux.conf` with `~/.tmux.conf.bak` (and numbered backups), then restore the pre-change copy, accounting for later edits. If no configuration existed before, remove only the file copied by this guide. These changes affect future servers; removing or reloading a file does not reset every option already set in a running server. Finish active work and exit sessions normally before starting a fresh server with the restored configuration. Never use an unqualified `tmux kill-server` for verification or recovery of the disposable check.

## Troubleshooting

- **Configuration errors:** check `tmux -V` against the configuration's version assumptions and repeat the isolated check. Do not reload a failing configuration into working sessions.
- **Keys differ from the table:** an existing server may still have its previous settings. Check whether reloading is appropriate for all sessions on that server.
- Package installation fails in a managed environment: [Enterprise policy issues](../windows/setup.md#enterprise-policy-troubleshooting).
- HTTPS package access fails in Ubuntu: [WSL SSL certificate trust fails](../networking/proxy.md#wsl-ssl-certificate-trust-fails).

[Official installation guide](https://github.com/tmux/tmux/wiki/Installing) and [tmux manual](https://github.com/tmux/tmux/blob/master/tmux.1), reviewed November 13, 2026. Documentation checks do not establish platform compatibility.
