# WSL Ubuntu setup compatibility path

**Prerequisites:** You reached this page from the older numbered setup sequence.
**Time:** 1 minute to choose the right task guide.
**Outcome:** You are routed to the WSL guide that matches your starting state.
**Verify:** Open the matching task guide and use its verification commands.
**Scope:** This compatibility page changes no machine state.
**Safety:** This page intentionally contains no setup or migration commands.

## Fast path

1. Choose the guide for your starting state.

   If you do not have the project Ubuntu distro yet, use [Install WSL2 Ubuntu](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/guides/wsl-ubuntu-install.md).

   If you already have an Ubuntu distro and need to move it to the project storage location, use [Migrate WSL2 Ubuntu](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/guides/wsl-ubuntu-migration.md).

   Expected result: you leave this compatibility path and follow only one task guide.

## Walkthrough

### 1. Choose the guide for your starting state

This numbered file is retained for old links and bookmarks while the WSL content moves to task-scoped guides. It is a router, not a second source of setup commands.

Use [Install WSL2 Ubuntu](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/guides/wsl-ubuntu-install.md) when you are starting fresh and want the distro created under the project storage location.

Use [Migrate WSL2 Ubuntu](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/guides/wsl-ubuntu-migration.md) when an existing Ubuntu distro must be exported, moved, and re-registered.

Expected result: the install and migration paths stay separate, so destructive migration guidance is not mixed into the fresh-install path.

## Rollback

Rollback is not applicable here because this compatibility page does not change machine state. Return to the [guide router](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/guides/README.md) if you opened the wrong page.

## Troubleshooting

Use the targeted entry that matches the symptom:

- Your WSL command does not support the needed install options: [Unsupported fresh install-location command](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/troubleshooting/wsl.md#unsupported-fresh-install-location-command)
- Migration or import fails: [Migration/import-in-place recovery](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/troubleshooting/wsl.md#migration-import-in-place-recovery)
- You are unsure where the distro is stored: [Storage path checks](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/troubleshooting/wsl.md#storage-path-checks)
