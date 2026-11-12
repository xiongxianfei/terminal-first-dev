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

require_order() {
  local path="$1"
  local first="$2"
  local second="$3"
  local first_line
  local second_line

  first_line="$(grep -nF "$first" "$path" | head -n 1 | cut -d: -f1 || true)"
  second_line="$(grep -nF "$second" "$path" | head -n 1 | cut -d: -f1 || true)"

  test -n "$first_line" || fail "missing ordered text in $path: $first"
  test -n "$second_line" || fail "missing ordered text in $path: $second"
  test "$first_line" -lt "$second_line" || fail "expected '$first' before '$second' in $path"
}

slugify_heading() {
  local heading="$1"

  printf '%s' "$heading" |
    sed -E 's/^#+[[:space:]]*//; s/[[:space:]]*$//' |
    tr '[:upper:]' '[:lower:]' |
    sed -E 's/`//g; s/[^a-z0-9]+/-/g; s/^-+//; s/-+$//'
}

require_anchor() {
  local path="$1"
  local anchor="$2"
  local line
  local slug

  while IFS= read -r line; do
    slug="$(slugify_heading "$line")"
    test "$slug" != "$anchor" || return 0
  done < <(grep -E '^#{1,6}[[:space:]]+' "$path" || true)

  fail "missing anchor in $path: $anchor"
}

check_troubleshooting_links() {
  local source="$1"
  local link
  local target
  local target_file
  local anchor

  while IFS= read -r link; do
    target="${link#](}"
    target_file="${target%%#*}"
    require_file "docs/guides/$target_file"

    if [[ "$target" == *"#"* ]]; then
      anchor="${target#*#}"
      require_anchor "docs/guides/$target_file" "$anchor"
    fi
  done < <(grep -oE '\]\(\.\./troubleshooting/[^)]+' "$source" || true)
}

reject_regex() {
  local path="$1"
  local pattern="$2"
  local reason="$3"

  if grep -Eiq "$pattern" "$path"; then
    fail "$reason: $path"
  fi
}

template=docs/templates/how-to-guide.md
proxy_guide=docs/guides/proxy-setup.md
ubuntu_pilot=docs/guides/03-ubuntu-baseline.md
proposal=docs/proposals/2026-06-15-how-to-guide-template-best-practices.md
exemplar_review=docs/changes/2026-06-15-how-to-guide-template-best-practices/exemplar-review.md
portability_review=docs/changes/2026-06-15-how-to-guide-template-best-practices/portability-pilot-review.md

require_file "$template"
require_file "$proxy_guide"
require_file "$ubuntu_pilot"
require_file "$proposal"
require_regex "$template" '^# <(Configure|Verb|[A-Z][^>]*)'

for text in \
  "<!--" \
  "Required for every guide" \
  "Conditional for state-changing or environment-sensitive guides" \
  "**Prerequisites:**" \
  "**Time:**" \
  "**Outcome:**" \
  "**Verify:**" \
  "**Scope:**" \
  "**Safety:**" \
  "## Fast path" \
  "## Walkthrough" \
  "## Rollback" \
  "## Troubleshooting" \
  "Expected result:" \
  "../troubleshooting/<topic>.md#<anchor>" \
  "Scope:" \
  "Backup:" \
  "Rollback:" \
  "powershell" \
  "bash" \
  "ini" \
  "toml" \
  "lua" \
  "tmux" \
  "not idempotent" \
  "secrets" \
  "proxy credentials" \
  "tokens" \
  "private hostnames" \
  "private certificate material"; do
  require_text "$template" "$text"
done

require_order "$template" "**Prerequisites:**" "## Fast path"
require_order "$template" "## Fast path" "## Walkthrough"
require_order "$template" "## Walkthrough" "## Rollback"
require_order "$template" "## Rollback" "## Troubleshooting"
require_order "$template" "Backup:" '```'

require_regex "$template" '^1\. '
require_regex "$template" '^   Run from <Windows PowerShell \| Ubuntu shell \| inside Neovim \| inside tmux>:'
require_text "$template" "Do not mix Windows and Ubuntu commands in one code block."
require_text "$template" 'Define placeholders such as `<UbuntuUser>` before using them.'
require_text "$template" "Prefer commands that can be re-run safely."
require_text "$template" 'Deep troubleshooting belongs under `docs/troubleshooting/`.'
require_text "$template" "Durable design rationale belongs in ADRs or architecture notes."
require_text "$template" "Rollback is required for persistent machine-changing guides."
require_text "$template" 'The final `Troubleshooting` section is a symptom router.'

test ! -f docs/guides/how-to-guide.md || fail "template must not live under docs/guides/how-to-guide.md"
test ! -f docs/guides/_template.md || fail "template must not live under docs/guides/_template.md"

reject_regex "$template" "generated documentation site|template engine|one-command installer|hidden automation" "template must not introduce generated docs tooling or hidden automation"

for guide in "$proxy_guide" "$ubuntu_pilot"; do
  require_text "$guide" "**Prerequisites:**"
  require_text "$guide" "**Time:**"
  require_text "$guide" "**Outcome:**"
  require_text "$guide" "**Verify:**"
  require_text "$guide" "## Fast path"
  require_text "$guide" "## Walkthrough"
  require_text "$guide" "## Rollback"
  require_text "$guide" "## Troubleshooting"
  require_text "$guide" "Run from"
  require_text "$guide" "Expected result:"
  require_order "$guide" "**Prerequisites:**" "## Fast path"
  require_order "$guide" "## Fast path" "## Walkthrough"
  require_order "$guide" "## Walkthrough" "## Rollback"
  require_order "$guide" "## Rollback" "## Troubleshooting"
done

require_text "$proxy_guide" 'Backup: if `%UserProfile%\.wslconfig` already exists, save a copy before editing it.'
require_text "$proxy_guide" "Backup behavior: if the file already exists, save a copy before editing it."

require_text "$ubuntu_pilot" 'Backup: if `%UserProfile%\.wslconfig` already exists, save a copy before editing it.'
require_text "$ubuntu_pilot" 'Backup: back up `/etc/wsl.conf` before editing it.'
require_text "$ubuntu_pilot" "Backup: back up current APT source files before editing them."
require_text "$ubuntu_pilot" 'Backup: back up `/etc/fstab` before editing it.'
require_text "$ubuntu_pilot" 'Backup: if `/etc/sudoers.d/terminal-first-windows-dev` already exists, save a copy before replacing it.'
require_text "$ubuntu_pilot" "Scope:"
require_text "$ubuntu_pilot" "Safety:"
require_text "$ubuntu_pilot" "../troubleshooting/proxy.md"

require_file "$exemplar_review"
require_file "$portability_review"

for review in "$exemplar_review" "$portability_review"; do
  require_text "$review" "Guide path:"
  require_text "$review" "Reviewer:"
  require_text "$review" "Review mode:"
  require_text "$review" "Starting prerequisites:"
  require_text "$review" "Fast-path result:"
  require_text "$review" "Verification signal:"
  require_text "$review" "Defects found:"
  require_text "$review" "Backup coverage:"
  require_text "$review" "Command execution status:"
  require_text "$review" "No private machine data, credentials, private hostnames, tokens, or personal paths are recorded."
done

require_text "$exemplar_review" "Reference exemplar, not the only validation pilot"
require_text "$portability_review" "Reviewer/template author separation:"
require_text "$portability_review" "Windows 11 + WSL execution or dry-run status:"
require_text "$portability_review" "Walkthrough use:"
require_text "$portability_review" "Template portability result:"

check_troubleshooting_links "$proxy_guide"
check_troubleshooting_links "$ubuntu_pilot"

require_file docs/guides/03-ubuntu-baseline.md
require_text specs/how-to-guide-template-best-practices.md "First-slice validation MUST NOT execute setup commands from guide code blocks."
require_text specs/how-to-guide-template-best-practices.md "First-slice validation MUST NOT require a Windows + WSL CI runner."
require_text specs/how-to-guide-template-best-practices.md 'This spec MUST NOT require renaming `docs/guides/03-ubuntu-baseline.md`'
require_text specs/guides-two-speed-how-to-structure.md "CI or automated command execution for setup code blocks MUST NOT be required in the first implementation slice."
require_text "$proposal" "status: accepted"
require_regex "$proposal" '^accepted$'

for path in \
  "$template" \
  "$proxy_guide" \
  "$ubuntu_pilot" \
  "$exemplar_review" \
  "$portability_review"; do
  reject_regex "$path" "generated documentation site|template engine|one-command installer|hidden automation" "changed artifacts must not introduce generated docs tooling, installers, or hidden automation"
  reject_regex "$path" "password=|token=|secret=|proxy\\.corp|internal\\.example|private key" "changed artifacts must not contain credential-like examples or private hostnames"
done

if grep -Eq '[a]pt update|[s]udo apt|[w]sl --shutdown|[w]inget |[u]pdate-ca-certificates|[s]udo mount -a|[s]udo visudo|[c]url -I ' "$0"; then
  fail "proof script must not execute or embed setup command blocks"
fi
