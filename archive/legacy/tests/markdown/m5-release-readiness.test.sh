#!/usr/bin/env bash
set -euo pipefail

verification=docs/guides/99-verification.md
version_record=docs/release-notes/2026-05-24-tested-versions.md
readme=README.md
plan=docs/changes/2026-05-24-terminal-first-workstation-setup/plan.md

for path in "$verification" "$version_record" "$readme" "$plan"; do
  test -f "$path" || {
    echo "missing required file: $path" >&2
    exit 1
  }
done

grep -q 'Verification matrix' "$verification"
grep -q 'Windows host' "$verification"
grep -q 'WSL storage' "$verification"
grep -q 'WSL config' "$verification"
grep -q 'Ubuntu baseline' "$verification"
grep -q 'proxy' "$verification"
grep -q 'data mount' "$verification"
grep -q 'locale' "$verification"
grep -q 'sudo' "$verification"
grep -q 'Neovim Windows' "$verification"
grep -q 'Neovim Ubuntu' "$verification"
grep -q 'tmux Ubuntu' "$verification"
grep -q 'pass' "$verification"
grep -q 'fail' "$verification"
grep -q 'skipped' "$verification"
grep -q 'needs manual action' "$verification"

grep -q 'Publication gate' "$verification"
grep -q 'latest stable' "$verification"
grep -q 'wsl --help' "$verification"
grep -q 'wsl --install' "$verification"
grep -q -- '--distribution' "$verification"
grep -q -- '--location' "$verification"
grep -q 'wsl --list --online' "$verification"
grep -q 'Microsoft Learn' "$verification"
grep -q 'https://learn.microsoft.com/en-us/windows/wsl/basic-commands' "$verification"
grep -q 'git diff --cached --name-only' "$verification"
grep -q 'git diff --cached --check' "$verification"
grep -q 'repository-wide `git diff --check` is advisory' "$verification"

grep -q 'PowerShell' "$version_record"
grep -q 'WSL version' "$version_record"
grep -q 'Ubuntu distro' "$version_record"
grep -q 'Neovim' "$version_record"
grep -q 'tmux' "$version_record"
grep -q 'uv' "$version_record"
grep -q 'optional language tools' "$version_record"
grep -q 'unrun' "$version_record"
grep -q 'manual Windows' "$version_record"

grep -q 'docs/guides/01-windows-host.md' "$readme"
grep -q 'docs/guides/02-wsl2-ubuntu.md' "$readme"
grep -q 'docs/guides/03-ubuntu-baseline.md' "$readme"
grep -q 'docs/guides/04-neovim.md' "$readme"
grep -q 'docs/guides/05-tmux.md' "$readme"
grep -q 'docs/guides/06-uv.md' "$readme"
grep -q 'docs/guides/99-verification.md' "$readme"
grep -q 'verification-first' "$readme"
grep -q 'one-command unattended installer' "$readme"
grep -q 'Warning Labels' "$readme"
grep -q 'Scope' "$readme"

grep -q 'Rollback coverage' "$verification"
grep -q 'WSL relocation' "$verification"
grep -q '.wslconfig' "$verification"
grep -q '/etc/wsl.conf' "$verification"
grep -q '/etc/fstab' "$verification"
grep -q 'sudoers' "$verification"
grep -q 'proxy fallback' "$verification"
grep -q 'Neovim config' "$verification"
grep -q 'tmux config' "$verification"

grep -q 'Use staged milestone-scoped whitespace validation' "$plan"
grep -q 'git diff --cached --check' "$plan"
