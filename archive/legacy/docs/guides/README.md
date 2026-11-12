# Guides

Use this page as a router. Start with what you are trying to do, then open the smallest guide that matches the task.

The current setup guide set is still migrating from numbered first-slice guides to task-scoped how-to guides. Existing numbered guides remain linked here so current readers can find the published setup flow while new task guides are added.

## I want to set up a workstation from scratch

Follow the current first-slice sequence:

1. [Prepare the Windows host](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/guides/01-windows-host.md)
2. [Install WSL2 Ubuntu](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/guides/wsl-ubuntu-install.md)
3. [Configure the Ubuntu baseline](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/guides/03-ubuntu-baseline.md)
4. [Set up Neovim](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/guides/04-neovim.md)
5. [Set up tmux](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/guides/05-tmux.md)
6. [Run verification](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/guides/99-verification.md)

The future sequence guide will be `fresh-setup.md`. Until that guide exists, the numbered files above remain compatibility paths for the full setup order. The old WSL numbered path is retained as the [WSL compatibility path](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/guides/02-wsl2-ubuntu.md).

## I want to configure one task

Use these task targets when you already know which layer you need:

| Task | Current guide | Planned task-scoped guide |
| --- | --- | --- |
| Configure Windows Terminal and host tooling | [Windows host setup](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/guides/01-windows-host.md) | `windows-terminal-setup.md`, `powershell-setup.md` |
| Install WSL2 Ubuntu | [Install WSL2 Ubuntu](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/guides/wsl-ubuntu-install.md) | Current task-scoped guide |
| Migrate WSL2 Ubuntu | [Migrate WSL2 Ubuntu](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/guides/wsl-ubuntu-migration.md) | Current task-scoped guide |
| Follow an old WSL numbered link | [WSL compatibility path](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/guides/02-wsl2-ubuntu.md) | Routes by starting state only |
| Configure Ubuntu baseline behavior | [Ubuntu baseline setup](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/guides/03-ubuntu-baseline.md) | `ubuntu-baseline.md` |
| Configure proxy behavior | [Proxy setup](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/guides/proxy-setup.md) | Replaces the proxy section in [Ubuntu baseline setup](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/guides/03-ubuntu-baseline.md#proxy-primary-path) as the task-scoped pilot |
| Configure shared data access | [Ubuntu baseline setup](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/guides/03-ubuntu-baseline.md#wsl-config) | `data-mount-setup.md` |
| Set up Neovim | [Neovim setup](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/guides/04-neovim.md) | `neovim-setup.md` |
| Set up tmux | [tmux setup](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/guides/05-tmux.md) | `tmux-setup.md` |
| Verify the workstation | [Verification](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/guides/99-verification.md) | `verification.md` |
| Install optional uv tooling | [uv setup](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/guides/06-uv.md) | Follow the same two-speed shape if it remains under `docs/guides/`. |

Task-scoped filenames should be stable, lowercase, hyphenated, and unnumbered. The router and `fresh-setup.md` own setup order.

## I hit a failure

Troubleshooting is a separate reading mode. Use the problem-focused entries under `docs/troubleshooting/` when a guide step fails:

- [Enterprise policy issues](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/troubleshooting/enterprise-policy.md)
- [Proxy and certificate issues](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/troubleshooting/proxy.md)
- [Ubuntu baseline issues](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/troubleshooting/ubuntu-baseline.md)
- [WSL issues](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/troubleshooting/wsl.md)

Guides should link to specific troubleshooting anchors at likely failure points when stable anchors exist.

## I am adding or revising a guide

Use the contributor template at [`docs/templates/how-to-guide.md`](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/templates/how-to-guide.md).

Guides in this directory are reader-facing content. Do not place contributor-only templates, empty skeletons, ADR-style rationale, or deep troubleshooting trees in `docs/guides/`.

Before handing a guide to review, check that it answers:

1. Is this guide for my task?
2. What will be true when I finish?
3. What commands do I run first?
4. How do I know it worked?
5. Where do I go if this exact step fails?
