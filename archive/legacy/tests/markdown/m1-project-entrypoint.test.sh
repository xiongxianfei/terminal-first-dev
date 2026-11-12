#!/usr/bin/env bash
set -euo pipefail

required_files=(
  README.md
  docs/guides/01-windows-host.md
  docs/guides/02-wsl2-ubuntu.md
  docs/guides/wsl-ubuntu-install.md
  docs/guides/wsl-ubuntu-migration.md
  docs/guides/03-ubuntu-baseline.md
  docs/guides/04-neovim.md
  docs/guides/05-tmux.md
  docs/guides/06-uv.md
  docs/guides/99-verification.md
  docs/troubleshooting/enterprise-policy.md
  docs/troubleshooting/proxy.md
  docs/troubleshooting/wsl.md
)

for path in "${required_files[@]}"; do
  test -f "$path" || {
    echo "missing required file: $path" >&2
    exit 1
  }
done

grep -q 'terminal-first Windows 11' README.md
grep -q 'Windows Terminal' README.md
grep -q 'PowerShell' README.md
grep -q 'Ubuntu' README.md
grep -q 'verification-first' README.md
grep -q 'not a one-command unattended installer' README.md

for guide in docs/guides/[0-9][0-9]-*.md; do
  if grep -q '## Fast path' "$guide"; then
    grep -q '## Fast path' "$guide" || {
      echo "missing fast path section: $guide" >&2
      exit 1
    }
    grep -q '## Walkthrough' "$guide" || {
      echo "missing walkthrough section: $guide" >&2
      exit 1
    }
    grep -q '## Rollback' "$guide" || {
      echo "missing rollback section: $guide" >&2
      exit 1
    }
    grep -q '## Troubleshooting' "$guide" || {
      echo "missing troubleshooting section: $guide" >&2
      exit 1
    }
    continue
  fi

  grep -q '## Command environment' "$guide" || {
    echo "missing command environment section: $guide" >&2
    exit 1
  }
  grep -q '## Safety notes' "$guide" || {
    echo "missing safety notes section: $guide" >&2
    exit 1
  }
  grep -q '## Validation' "$guide" || {
    echo "missing validation section: $guide" >&2
    exit 1
  }
  grep -q '## Rollback' "$guide" || {
    echo "missing rollback section: $guide" >&2
    exit 1
  }
done

grep -q 'Windows PowerShell' docs/guides/01-windows-host.md
grep -q 'compatibility path' docs/guides/02-wsl2-ubuntu.md
grep -q 'Windows PowerShell' docs/guides/wsl-ubuntu-install.md
grep -q 'Windows PowerShell' docs/guides/wsl-ubuntu-migration.md
grep -q 'Ubuntu shell' docs/guides/03-ubuntu-baseline.md
grep -q 'inside Neovim' docs/guides/04-neovim.md
grep -q 'Run from Ubuntu' docs/guides/05-tmux.md
grep -q 'uv --version' docs/guides/06-uv.md
grep -q 'uv self update' docs/guides/06-uv.md
grep -q 'pyproject.toml' docs/guides/06-uv.md
grep -q 'uv.toml' docs/guides/06-uv.md
grep -q 'UV_DEFAULT_INDEX' docs/guides/06-uv.md
grep -q 'Keep credentials out of config files' docs/guides/06-uv.md
grep -q 'pass, fail, skipped, or needs manual action' docs/guides/99-verification.md

grep -Rq 'one-command unattended installer' README.md docs/guides
