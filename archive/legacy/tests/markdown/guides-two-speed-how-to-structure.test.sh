#!/usr/bin/env bash
set -euo pipefail

fail() {
  echo "$1" >&2
  exit 1
}

require_file() {
  local path="$1"
  test -f "$path" || fail "missing required file: $path"
}

require_text() {
  local path="$1"
  local text="$2"
  grep -Fq "$text" "$path" || fail "missing text in $path: $text"
}

require_regex() {
  local path="$1"
  local pattern="$2"
  grep -Eq "$pattern" "$path" || fail "missing pattern in $path: $pattern"
}

require_anchor() {
  local path="$1"
  local heading="$2"
  grep -Fxq "$heading" "$path" || fail "missing anchor heading in $path: $heading"
}

router=docs/guides/README.md
template=docs/templates/how-to-guide.md
proxy_guide=docs/guides/proxy-setup.md
proxy_troubleshooting=docs/troubleshooting/proxy.md
pilot_review=docs/changes/2026-06-07-guides-two-speed-how-to-structure/pilot-review.md

require_file "$router"
require_file "$template"
require_file "$proxy_guide"
require_file "$proxy_troubleshooting"
require_file "$pilot_review"

for path in \
  docs/guides/01-windows-host.md \
  docs/guides/02-wsl2-ubuntu.md \
  docs/guides/wsl-ubuntu-install.md \
  docs/guides/wsl-ubuntu-migration.md \
  docs/guides/03-ubuntu-baseline.md \
  docs/guides/04-neovim.md \
  docs/guides/05-tmux.md \
  docs/guides/99-verification.md; do
  require_file "$path"
done

require_text "$router" "Use this page as a router"
require_text "$router" "I want to set up a workstation from scratch"
require_text "$router" "I want to configure one task"
require_text "$router" "I hit a failure"
require_text "$router" "Task-scoped filenames should be stable, lowercase, hyphenated, and unnumbered"
require_text "$router" "[Proxy setup](proxy-setup.md)"
require_text "$router" "[Prepare the Windows host](01-windows-host.md)"
require_text "$router" "[Install WSL2 Ubuntu](wsl-ubuntu-install.md)"
require_text "$router" "[Migrate WSL2 Ubuntu](wsl-ubuntu-migration.md)"
require_text "$router" "[WSL compatibility path](02-wsl2-ubuntu.md)"
require_text "$router" "[Configure the Ubuntu baseline](03-ubuntu-baseline.md)"
require_text "$router" "[Set up Neovim](04-neovim.md)"
require_text "$router" "[Set up tmux](05-tmux.md)"
require_text "$router" "[Run verification](99-verification.md)"
require_text "$router" "../templates/how-to-guide.md"
require_text "$router" "../troubleshooting/proxy.md"

require_text "$template" "**Prerequisites:**"
require_text "$template" "**Time:**"
require_text "$template" "**Outcome:**"
require_text "$template" "**Verify:**"
require_text "$template" "## Fast path"
require_text "$template" "## Walkthrough"
require_text "$template" "## Rollback"
require_text "$template" "## Troubleshooting"
require_text "$template" "../troubleshooting/<topic>.md#<anchor>"
test ! -f docs/guides/_template.md || fail "template must not live under docs/guides/_template.md"
test ! -f docs/guides/how-to-guide.md || fail "template must not live under docs/guides/how-to-guide.md"

require_text "$proxy_guide" "# Configure WSL automatic proxy mirroring"
require_text "$proxy_guide" "**Prerequisites:**"
require_text "$proxy_guide" "**Time:**"
require_text "$proxy_guide" "**Outcome:**"
require_text "$proxy_guide" "**Verify:**"
require_text "$proxy_guide" "## Fast path"
require_text "$proxy_guide" "## Walkthrough"
require_text "$proxy_guide" "## Rollback"
require_text "$proxy_guide" "## Troubleshooting"
require_regex "$proxy_guide" "^1\\. Enable automatic proxy mirroring"
require_regex "$proxy_guide" "^2\\. Restart WSL"
require_regex "$proxy_guide" "^3\\. Verify HTTPS access"
require_regex "$proxy_guide" "^### 1\\. Enable automatic proxy mirroring"
require_regex "$proxy_guide" "^### 2\\. Restart WSL"
require_regex "$proxy_guide" "^### 3\\. Verify HTTPS access"
require_text "$proxy_guide" '```ini'
require_text "$proxy_guide" '```powershell'
require_text "$proxy_guide" '```bash'
require_text "$proxy_guide" "Expected result:"
require_text "$proxy_guide" "Warning: this changes WSL global configuration for the current Windows user."
require_text "$proxy_guide" 'Warning: `%UserProfile%\.wslconfig` affects WSL behavior for the current Windows user.'
require_text "$proxy_guide" "../troubleshooting/proxy.md#automatic-proxy-mirroring-does-not-work"
require_text "$proxy_guide" "../troubleshooting/proxy.md#manual-proxy-fallback-cautions"
require_text "$proxy_guide" "../troubleshooting/proxy.md#wsl-ssl-certificate-trust-fails"

require_anchor "$proxy_troubleshooting" "## Automatic proxy mirroring does not work"
require_anchor "$proxy_troubleshooting" "## Manual proxy fallback cautions"
require_anchor "$proxy_troubleshooting" "## WSL SSL certificate trust fails"

require_text "$pilot_review" "## Documented starting state"
require_text "$pilot_review" "Completion result: completable"
require_text "$pilot_review" "Approximate completion time:"
require_text "$pilot_review" "Walkthrough text needed:"
require_text "$pilot_review" "Command execution status: not executed"
require_text "$pilot_review" "No proxy credentials, private hostnames, tokens, or certificate material"

require_text "$proxy_guide" 'manual `http_proxy`, `https_proxy`, or `no_proxy` values'
require_text "$proxy_guide" "PAC files remain a first-slice limitation"
require_text "$pilot_review" "No setup command blocks are executed by CI in this slice."
require_text specs/guides-two-speed-how-to-structure.md "CI or automated command execution for setup code blocks MUST NOT be required in the first implementation slice."

if grep -Eq "[a]pt update|[s]udo apt|[w]inget |[w]sl --install|[u]pdate-ca-certificates" "$0"; then
  fail "proof script must not contain setup command execution checks"
fi
