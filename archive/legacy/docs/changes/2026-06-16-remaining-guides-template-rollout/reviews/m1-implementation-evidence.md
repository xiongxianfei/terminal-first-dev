# M1 Implementation Evidence: Smaller Tool Guides

- Milestone: M1
- Guide paths: `docs/guides/05-tmux.md`, `docs/guides/04-neovim.md`, `docs/guides/06-uv.md`
- Reviewer: implementation pass before code-review
- Review mode: static diff review and proof-script validation
- Setup command execution: not executed

## Command inventory:

- `05-tmux.md`: preserved the Ubuntu APT install commands, `tmux -V`, project config copy to `~/.tmux.conf`, daily-use session commands, and clean disposable session load/kill verification.
- `04-neovim.md`: preserved Windows WinGet install, Ubuntu APT install, Ubuntu release-tarball fallback, fallback rollback commands, version checks, clean startup check, Lazy status check, and `:checkhealth`.
- `06-uv.md`: preserved Windows standalone installer, Ubuntu standalone installer, `uv self update`, version/list verification, package-index configuration forms, environment-variable example, and dry-run package test while replacing private-looking index examples with reserved public examples.

## Fast-path/walkthrough parity:

- Result: pass.
- Evidence: each converted guide uses the same high-level order in `Fast path` and `Walkthrough`.
- Notes: walkthroughs add context, backup details, and manual checks without introducing a different setup flow.

## Backup-before-edit coverage:

- Result: pass.
- Evidence: tmux includes backup guidance before replacing `~/.tmux.conf`; Neovim includes backup guidance before replacing `%LocalAppData%\nvim` and `~/.config/nvim`; uv states backup is not applicable for a new disposable project-owned example and requires backup before editing existing `pyproject.toml` or user `uv.toml`.

## Command-context coverage:

- Result: pass.
- Evidence: command blocks are introduced with Windows PowerShell, Ubuntu, repository-root, or inside-Neovim context as applicable.

## Expected-result coverage:

- Result: pass.
- Evidence: meaningful commands and verification commands have nearby expected-result text.

## Troubleshooting-anchor result:

- Result: pass.
- Evidence: introduced troubleshooting links target existing `enterprise-policy.md` and `proxy.md#wsl-ssl-certificate-trust-fails` anchors.

## Security/privacy result:

- Result: pass.
- Evidence: uv examples use `https://example.org/simple` and avoid credentials, tokens, private hostnames, private certificate material, and user-specific machine names.

## Follow-ups:

None for M1.
