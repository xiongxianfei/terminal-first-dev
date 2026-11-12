# Exemplar Review: Proxy Setup

Guide path: `docs/guides/proxy-setup.md`

Reviewer: Codex implementation agent

Review mode: documented dry-run review

Reference role: Reference exemplar, not the only validation pilot

Starting prerequisites: WSL2 Ubuntu is installed; Windows proxy or VPN policy is already configured; the reader can edit `%UserProfile%\.wslconfig` for the current Windows user.

Fast-path result: review-completable. The fast path exposes the `.wslconfig` edit, backup cue, WSL restart, Ubuntu HTTPS verification, expected results, and troubleshooting links without requiring walkthrough text.

Verification signal: `curl -I https://github.com` or a policy-approved HTTPS endpoint succeeds from Ubuntu.

Walkthrough use: not required for the fast-path dry run; walkthrough adds context, backup behavior, rollback, and policy caveats.

Defects found: none blocking M2. The existing HGT-SR-001 backup cue appears before the fast-path `.wslconfig` snippet, and walkthrough backup behavior remains before the edit.

Backup coverage: `%UserProfile%\.wslconfig` has backup guidance before the edit in both fast path and walkthrough.

Command execution status: not executed. This review did not run Windows PowerShell, WSL, Ubuntu, `curl`, or setup commands.

No private machine data, credentials, private hostnames, tokens, or personal paths are recorded.

## Review Notes

- The guide is treated as the demanding reference exemplar because it exercises WSL global configuration, restart behavior, verification, rollback, and multiple troubleshooting routes.
- The guide is not treated as the only validation pilot; `docs/guides/03-ubuntu-baseline.md` is reviewed separately as the portability pilot.
- Deep recovery remains linked to `docs/troubleshooting/proxy.md` instead of being embedded in the guide.
