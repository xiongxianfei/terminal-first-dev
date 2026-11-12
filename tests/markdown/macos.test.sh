#!/usr/bin/env bash
# Adapted from terminal-first-macos-dev at 8d3521798dde9af1aec1d803591eda1fbacbf18f.
# Copyright 2026 xiongxianfei. Licensed under Apache-2.0; see LICENSE.
# Static checks only: no macOS setup command is executed.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

README="$ROOT/README.md"
GUIDE="$ROOT/docs/macos/setup.md"
VERIFY="$ROOT/docs/macos/verification.md"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

assert_file() {
  local path="$1"
  [[ -f "$path" ]] || fail "missing file: ${path#$ROOT/}"
}

assert_contains() {
  local path="$1"
  local pattern="$2"
  local description="$3"
  grep -Eiq "$pattern" "$path" || fail "${path#$ROOT/} missing ${description}"
}

assert_not_contains() {
  local path="$1"
  local pattern="$2"
  local description="$3"
  if grep -Eiq "$pattern" "$path"; then
    fail "${path#$ROOT/} contains forbidden ${description}"
  fi
}

line_number() {
  local path="$1"
  local pattern="$2"
  local line
  line="$(grep -Einm 1 "$pattern" "$path" | cut -d: -f1 || true)"
  [[ -n "$line" ]] || fail "${path#$ROOT/} missing ordering marker: $pattern"
  printf '%s\n' "$line"
}

assert_before() {
  local path="$1"
  local first="$2"
  local second="$3"
  local description="$4"
  local first_line second_line
  first_line="$(line_number "$path" "$first")"
  second_line="$(line_number "$path" "$second")"
  (( first_line < second_line )) || fail "${path#$ROOT/} has wrong order for ${description}"
}

assert_file "$README"
assert_file "$GUIDE"
assert_file "$VERIFY"
assert_file "$ROOT/LICENSE"

assert_contains "$README" 'Windows, Linux, and macOS' 'unified platform scope'
assert_contains "$README" 'docs/macos/setup\.md' 'macOS guide link'
assert_contains "$README" 'docs/macos/verification\.md' 'macOS verification link'
assert_contains "$GUIDE" '8d3521798dde9af1aec1d803591eda1fbacbf18f' 'pinned source provenance'
assert_contains "$GUIDE" 'Apache-2.0' 'import license attribution'
assert_contains "$GUIDE" 'Copyright 2026 xiongxianfei' 'source copyright notice'
assert_contains "$GUIDE" '\]\(verification\.md\)' 'local verification link'
assert_contains "$VERIFY" '\]\(setup\.md\)' 'local setup link'

assert_contains "$GUIDE" '^## Scope$' 'Scope section'
assert_contains "$GUIDE" '^## Traceability$' 'Traceability section'
assert_contains "$GUIDE" '^## Verification status$' 'Verification status section'
assert_contains "$GUIDE" '^## Prerequisites$' 'Prerequisites section'
assert_contains "$GUIDE" '^## Outcome$' 'Outcome section'
assert_contains "$GUIDE" '^## Safety gates before setup changes$' 'Safety gates section'
assert_contains "$GUIDE" '^## Ownership context$' 'Ownership context section'
assert_contains "$GUIDE" '^## Hardware and compatibility$' 'Hardware and compatibility section'
assert_contains "$GUIDE" '^## Backup and Apple-owned system setup$' 'Backup and Apple-owned system setup section'
assert_contains "$GUIDE" '^## Apple developer tooling$' 'Apple developer tooling section'
assert_contains "$GUIDE" '^## Homebrew for third-party CLI tooling$' 'Homebrew section'
assert_contains "$GUIDE" '^## Shell, Git, SSH, and editor baseline$' 'Shell, Git, SSH, and editor section'
assert_contains "$GUIDE" '^## Follow-up modules$' 'Follow-up modules section'
assert_contains "$GUIDE" 'personal developer MacBook' 'personal MacBook audience'
assert_contains "$GUIDE" 'Apple silicon' 'Apple silicon target'
assert_contains "$GUIDE" 'proposal.*spec.*plan' 'historical proposal/spec/plan traceability'
assert_contains "$GUIDE" 'manual verification.*not.*complete|not.*complete.*manual verification' 'unverified manual walkthrough status'
assert_contains "$GUIDE" 'verified|manually checked|skipped|blocked|policy-dependent' 'verification status categories'
assert_contains "$GUIDE" 'MDM' 'managed-Mac MDM routing'
assert_contains "$GUIDE" 'endpoint security' 'managed-Mac endpoint security routing'
assert_contains "$GUIDE" 'certificate' 'managed-Mac certificate routing'
assert_contains "$GUIDE" 'proxy' 'managed-Mac proxy routing'
assert_contains "$GUIDE" 'restricted administrator' 'restricted administrator routing'
assert_contains "$GUIDE" 'hardware model' 'hardware model guidance'
assert_contains "$GUIDE" 'CPU architecture|uname -m' 'CPU architecture guidance'
assert_contains "$GUIDE" 'Intel.*unverified|unverified.*Intel' 'Intel non-claim language'
assert_contains "$GUIDE" 'backup posture' 'backup posture gate'
assert_contains "$GUIDE" 'Software Update' 'Apple Software Update path'
assert_contains "$GUIDE" 'https://support\.apple\.com/en-us/108382' 'official Apple Software Update source link'
assert_contains "$GUIDE" 'beta.*not.*default|not.*default.*beta' 'beta exclusion'
assert_contains "$GUIDE" 'FileVault' 'FileVault review'
assert_contains "$GUIDE" 'recovery-key|recovery key' 'recovery-key handling'
assert_contains "$GUIDE" 'Apple Account' 'Apple Account assumption'
assert_contains "$GUIDE" 'administrator' 'administrator assumption'
assert_contains "$GUIDE" 'Privacy & Security' 'Privacy & Security review'
assert_contains "$GUIDE" 'Command Line Tools|Xcode' 'Apple developer tooling'
assert_contains "$GUIDE" 'https://developer\.apple\.com/documentation/xcode/installing-the-command-line-tools' 'official Apple Command Line Tools source link'
assert_contains "$GUIDE" 'Apple-owned system tooling' 'Apple-owned tooling boundary'
assert_contains "$GUIDE" 'third-party developer CLI tooling' 'third-party tooling boundary'
assert_contains "$GUIDE" 'Homebrew' 'Homebrew coverage'
assert_contains "$GUIDE" 'https://docs\.brew\.sh/Installation' 'official Homebrew installation source link'
assert_contains "$GUIDE" 'https://github\.com/Homebrew/install' 'official Homebrew install and uninstall script source link'
assert_contains "$GUIDE" '/opt/homebrew' 'Apple silicon Homebrew prefix'
assert_contains "$GUIDE" 'install script' 'Homebrew install-script review'
assert_contains "$GUIDE" 'brew update' 'Homebrew update behavior'
assert_contains "$GUIDE" 'brew doctor' 'Homebrew health check'
assert_contains "$GUIDE" 'uninstall|rollback' 'Homebrew rollback notes'
assert_contains "$GUIDE" 'zsh' 'zsh shell boundary'
assert_contains "$GUIDE" '\.zprofile|\.zshrc' 'zsh profile file guidance'
assert_contains "$GUIDE" 'PATH' 'PATH change guidance'
assert_contains "$GUIDE" 'Git identity' 'Git identity readiness'
assert_contains "$GUIDE" 'SSH key' 'SSH key handling'
assert_contains "$GUIDE" 'credential' 'credential storage expectations'
assert_contains "$GUIDE" 'minimal editor' 'minimal editor availability'
assert_contains "$GUIDE" 'persistent state|inspect.*reverse|reverse.*inspect' 'persistent-state auditability'
assert_contains "$GUIDE" 'Mac App Store automation.*defer|defer.*Mac App Store automation' 'Mac App Store automation deferral'
assert_contains "$GUIDE" 'web development|Python|containers|cloud tooling|GUI app bundles|full editor configuration' 'role-specific follow-up routing'
assert_contains "$GUIDE" 'Do not add hidden setup automation|hidden setup automation' 'hidden automation non-goal'

assert_before "$GUIDE" '^## Ownership context$' '^## Hardware and compatibility$' 'ownership before hardware'
assert_before "$GUIDE" '^## Ownership context$' '^## Homebrew for third-party CLI tooling$' 'ownership before package manager'
assert_before "$GUIDE" '^## Safety gates before setup changes$' '^## Homebrew for third-party CLI tooling$' 'safety gates before Homebrew'
assert_before "$GUIDE" '^## Backup and Apple-owned system setup$' '^## Apple developer tooling$' 'backup before developer tooling'
assert_before "$GUIDE" '^## Apple developer tooling$' '^## Homebrew for third-party CLI tooling$' 'Apple tooling before Homebrew'
assert_before "$GUIDE" '^## Homebrew for third-party CLI tooling$' '^## Shell, Git, SSH, and editor baseline$' 'Homebrew before shell integration'

assert_contains "$VERIFY" '^## Required evidence fields$' 'required evidence fields section'
assert_contains "$VERIFY" '^## Manual walkthrough record$' 'Manual walkthrough record section'
assert_contains "$VERIFY" '^## Verification checklist$' 'verification checklist section'
assert_contains "$VERIFY" '^## Transcript scrubbing$' 'transcript scrubbing section'
assert_contains "$VERIFY" '^## Claim boundary$' 'claim boundary section'
assert_contains "$VERIFY" 'sw_vers' 'sw_vers evidence field'
assert_contains "$VERIFY" 'hardware model' 'hardware model evidence field'
assert_contains "$VERIFY" 'CPU architecture' 'CPU architecture evidence field'
assert_contains "$VERIFY" 'Command Line Tools' 'Command Line Tools evidence field'
assert_contains "$VERIFY" 'Homebrew prefix' 'Homebrew prefix evidence field'
assert_contains "$VERIFY" 'Homebrew health' 'Homebrew health evidence field'
assert_contains "$VERIFY" 'Git availability' 'Git availability evidence field'
assert_contains "$VERIFY" 'SSH readiness' 'SSH readiness evidence field'
assert_contains "$VERIFY" 'Minimal editor launch' 'minimal editor launch evidence field'
assert_contains "$VERIFY" 'verification date' 'verification date evidence field'
assert_contains "$VERIFY" 'verifier context' 'verifier context evidence field'
assert_contains "$VERIFY" 'personal or managed' 'ownership context evidence field'
assert_contains "$VERIFY" 'No command-success or compatibility claims are verified yet' 'unverified claims statement'
assert_contains "$VERIFY" 'verified|manually checked|skipped|blocked|policy-dependent' 'verification status categories'
assert_contains "$VERIFY" 'latest stable macOS offered by Software Update' 'stable macOS evidence boundary'
assert_contains "$VERIFY" 'real Apple silicon MacBook' 'real Apple silicon manual walkthrough requirement'
assert_contains "$VERIFY" 'tokens|private keys|recovery keys|private machine names|organization identifiers|private paths' 'sensitive transcript scrubbing fields'

for path in "$README" "$GUIDE" "$VERIFY"; do
  assert_not_contains "$path" 'brew bundle|mas install' 'baseline automation commands'
  assert_not_contains "$path" '\.\./20260524-terminal-dev|does not change.*terminal-first-windows-dev|Windows-first repository by default' 'obsolete companion boundaries or local checkout paths'
done

assert_not_contains "$GUIDE" 'primary verified target' 'premature platform verification claim'
assert_not_contains "$GUIDE" '^## Current milestone$|M[0-9]+ still owns|M[0-9]+ authors' 'workflow milestone status in reader guide'

printf 'PASS: macOS knowledge-base baseline checks passed\n'
