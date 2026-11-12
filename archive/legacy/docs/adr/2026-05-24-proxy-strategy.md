# ADR: Proxy Strategy

## Status

accepted

## Context

Proxy behavior often blocks package installation and varies by VPN, PAC, corporate CA, and Windows/WSL version.

## Decision

Use WSL automatic proxy mirroring as the primary path via `%UserProfile%\.wslconfig`:

```ini
[wsl2]
autoProxy=true
```

Document manual environment-variable fallback guidance. Defer PAC files from the first slice. Keep corporate CA certificate handling manual and troubleshooting-only, governed by [ADR: WSL Certificate Trust Policy](https://github.com/xiongxianfei/terminal-first-windows-dev/blob/8f22389e563a6b1376a36eef74b26e36bd6a3659/docs/adr/2026-05-25-wsl-certificate-trust-policy.md).

## Alternatives Considered

- Manual environment variables only: more explicit, but duplicates configuration and is error-prone.
- Full PAC and automatic corporate CA support: useful, but too organization-specific and security-sensitive for first-slice scope.
- Ignore proxy setup: simpler, but package installation may fail without explanation.

## Consequences

- The guide must explain when WSL restart is needed for `.wslconfig` changes.
- Doctor checks should report proxy auto-mirroring or fallback state.
- Corporate environments remain partially supported through troubleshooting, not full setup.
- Certificate trust repair must stay manual unless a future proposal/spec accepts automation.

## Follow-up

Define proxy doctor checks and troubleshooting notes in the test spec and guide implementation.
