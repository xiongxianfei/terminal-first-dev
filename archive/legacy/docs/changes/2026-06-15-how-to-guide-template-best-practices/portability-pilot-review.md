# Portability Pilot Review: Ubuntu Baseline

Guide path: `docs/guides/03-ubuntu-baseline.md`

Reviewer: Codex implementation agent

Reviewer/template author separation: not possible in this implementation pass because the same agent authored the M1 template update and the M2 pilot rewrite. This review records the exception required by R43.

Review mode: documented dry-run review

Windows 11 + WSL execution or dry-run status: dry-run review only. No Windows 11 + WSL Ubuntu machine was used for command execution.

Starting prerequisites: WSL2 Ubuntu is installed; Windows PowerShell and Ubuntu can be opened; local policy allows review of WSL, fstab, APT, locale, and sudo changes before running them.

Fast-path result: review-completable. The fast path presents proxy, WSL config, optional APT source posture, shared data mount, locale, and optional sudo steps with command context, backup guidance, expected results, rollback cues, and a top-level verification signal.

Verification signal: `locale charmap` reports `UTF-8`; `findmnt "$HOME/data"` reports the shared data mount when configured; `sudo -n true` succeeds only when passwordless sudo is intentionally enabled.

Walkthrough use: not needed to identify the fast-path command flow during dry run. The walkthrough remains useful for policy assumptions, fallback paths, and recovery notes.

Defects found: none blocking M2. The portability pilot is heavier than the proxy exemplar because it covers several baseline topics, but the fast path remains scan-friendly enough for this first portability check.

Backup coverage: `%UserProfile%\.wslconfig`, `/etc/wsl.conf`, APT source files, `/etc/fstab`, and `/etc/sudoers.d/terminal-first-windows-dev` have visible backup guidance before the edit or replacement path that changes state.

Command execution status: not executed. This review did not run Windows PowerShell, WSL, Ubuntu, mount, sudo, locale, APT, or setup commands.

Template portability result: passed dry-run review. The template works for a guide that was not the original source exemplar, while exposing that multi-topic baseline guides are naturally heavier than task-narrow guides.

No private machine data, credentials, private hostnames, tokens, or personal paths are recorded.

## Review Notes

- This review avoids circular validation by using `docs/guides/03-ubuntu-baseline.md` as the non-exemplar portability pilot.
- Fast-path success is recorded as dry-run review-completable, not executed success, because no Windows + WSL command execution occurred.
- The pilot keeps numbered filename compatibility; no guide rename was required.
