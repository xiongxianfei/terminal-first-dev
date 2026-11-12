<!--
Required for every guide:
- Outcome-led title.
- Visible metadata: Prerequisites, Time, Outcome, Verify.
- Fast path before Walkthrough.
- Explicit command context before commands or snippets.
- Expected result after meaningful commands and verification commands.
- Inline troubleshooting links at likely failure points when stable anchors exist.

Conditional for state-changing or environment-sensitive guides:
- Scope in the metadata block.
- Safety in the metadata block for destructive, security-sensitive, persistent, or hard-to-undo changes.
- Backup guidance before edits to user-owned or system-owned files, or a concrete reason backup is not applicable.
- Rollback guidance for persistent machine-changing guides.

Remove contributor comments and unused placeholders before publishing a guide.
-->

# <Configure the desired outcome>

**Prerequisites:** <required starting state, tools, policy approvals, or existing setup>.
**Time:** <estimated time>.
**Outcome:** <what is true after the task is complete>.
**Verify:** `<top-level verification command or observable result>` succeeds in <environment>.
**Scope:** <conditional: what user, machine, WSL, shell, editor, tmux, storage, or network state changes>.
**Safety:** <conditional: security, persistence, storage, identity, proxy, sudoers, fstab, package-source, trust-store, execution-policy, or editor-runtime impact>.

## Fast path

1. <Action-oriented step title>.

   Scope: <conditional: what this step changes, or remove for read-only steps>.

   Backup: <conditional: backup the target file/state before editing, or state the concrete reason backup is not applicable>.

   Rollback: <conditional: how to undo this step, or link to the Rollback section>.

   Run from <Windows PowerShell | Ubuntu shell | inside Neovim | inside tmux>:

   ```powershell
   <command>
   ```

   Expected result: <short observable result>.

   If this fails with <specific symptom>, use [<targeted troubleshooting entry>](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/troubleshooting/%3Ctopic%3E.md#<anchor>).

2. <Next action-oriented step title>.

   Run from <Ubuntu shell>:

   ```bash
   <command>
   ```

   Expected result: <short observable result>.

3. Verify the task.

   Run from <environment>:

   ```bash
   <verification command>
   ```

   Expected result: <what success looks like>.

## Walkthrough

### 1. <Same action-oriented step title>

<Explain only what the reader needs to complete this task safely. Durable design rationale belongs in ADRs or architecture notes. Link to that rationale only when it changes the reader's action.>

Scope: <conditional: what this step changes, or remove for read-only steps>.

Backup: <conditional: backup the target file/state before editing, or state the concrete reason backup is not applicable>.

Rollback: <conditional: how to undo this step, or link to the Rollback section>.

Run from <Windows PowerShell | Ubuntu shell | inside Neovim | inside tmux>:

```ini
<configuration snippet>
```

Expected result: <short observable result>.

Verify:

```bash
<verification command>
```

Expected result: <verification signal>.

If this fails with <specific symptom>, use [<targeted troubleshooting entry>](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/troubleshooting/%3Ctopic%3E.md#<anchor>).

### 2. <Same next action-oriented step title>

<Add task-relevant context for the same high-level step order used in the fast path. If an alternate path is needed, label it explicitly as an alternate path.>

Run from <Ubuntu shell>:

```bash
<command>
```

Expected result: <short observable result>.

### 3. Verify the task

Run from <environment>:

```bash
<verification command>
```

Expected result: <what success looks like>.

## Rollback

Rollback is required for persistent machine-changing guides.

<Summarize how to restore the previous user or system state. For verification-only guides, state why rollback is not applicable. Keep detailed recovery in troubleshooting when the recovery tree is long.>

## Troubleshooting

The final `Troubleshooting` section is a symptom router. Deep troubleshooting belongs under `docs/troubleshooting/`.

Use the targeted entry that matches the symptom:

- <Symptom>: [<troubleshooting title>](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/troubleshooting/%3Ctopic%3E.md#<anchor>)

## Command-block conventions

- Use `powershell` for Windows PowerShell or PowerShell 7 commands.
- Use `bash` for Ubuntu shell commands.
- Use `ini`, `toml`, `lua`, or `tmux` for configuration snippets when the snippet type matches the content.
- Introduce each command block with where to run it.
- Do not mix Windows and Ubuntu commands in one code block.
- Define placeholders such as `<UbuntuUser>` before using them.
- Do not include secrets, proxy credentials, tokens, private hostnames, or private certificate material in examples.
- Prefer commands that can be re-run safely.
- If a command is not idempotent, label that before the command and explain the recovery path.
