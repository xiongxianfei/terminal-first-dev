# ADR: Version and Package Policy

## Status

accepted

## Context

The setup guide needs current tools without relying on preview/nightly builds. It also needs reproducibility evidence for reviewers and users.

## Decision

Use latest stable tooling at setup time. Do not use preview or nightly versions in the main path. Record tested versions when publishing the first guide. Pin only where reproducibility matters, such as Neovim plugin lockfiles.

Use supported Windows package paths for Windows tools, with `winget` as the default where available and policy-aware fallback notes where blocked.

## Alternatives Considered

- Fully pinned system versions: more reproducible, but likely stale for a workstation setup guide.
- Preview/nightly versions: more current, but too unstable for a public first-slice guide.
- Manual-only downloads: useful fallback, but worse as the primary path.

## Consequences

- Release notes or version records become part of publication readiness.
- Tests and doctor checks must record observed versions.
- Tool drift remains possible but visible.

## Follow-up

Define version-record format in test-spec or implementation planning.
