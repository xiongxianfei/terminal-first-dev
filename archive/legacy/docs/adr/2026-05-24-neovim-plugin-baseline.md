# ADR: Neovim Plugin Baseline

## Status

accepted

## Context

The guide should provide useful Neovim behavior on both Windows PowerShell and Ubuntu without becoming a full editor distribution or dotfiles framework.

## Decision

Use one single-file shared Neovim config at `config/nvim/init.lua`. Deploy or sync that file separately to Windows and Ubuntu paths. Do not share plugin/runtime state through a Windows-mounted path.

The concise profile covers editing, navigation, diagnostics, Git indicators, and LSP wiring. Extra language servers and formatters remain user-installed and optional.

## Alternatives Considered

- Fully separate Windows and Ubuntu configs: clearer per platform, but duplicates behavior.
- Shared runtime/plugin state through DrvFs: convenient, but risks path, performance, and compatibility issues.
- Large Neovim distribution: feature-rich, but outside the concise first-slice scope.

## Consequences

- Config deployment stays simple, but verification is still needed on both environments.
- Plugin lockfile policy is needed where reproducibility matters.
- Doctor checks should distinguish Windows Neovim from Ubuntu Neovim failures.

## Follow-up

Define config layout, plugin manager, lockfile policy, and health checks during architecture review/test-spec work.
