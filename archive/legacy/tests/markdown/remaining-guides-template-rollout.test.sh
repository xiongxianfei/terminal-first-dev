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
  grep -Fq -- "$text" "$path" || fail "missing text in $path: $text"
}

require_regex() {
  local path="$1"
  local pattern="$2"
  grep -Eq -- "$pattern" "$path" || fail "missing pattern in $path: $pattern"
}

reject_regex() {
  local path="$1"
  local pattern="$2"
  local reason="$3"

  if grep -Eiq -- "$pattern" "$path"; then
    fail "$reason: $path"
  fi
}

require_order() {
  local path="$1"
  local first="$2"
  local second="$3"
  local first_line
  local second_line

  first_line="$(grep -nF -- "$first" "$path" | head -n 1 | cut -d: -f1 || true)"
  second_line="$(grep -nF -- "$second" "$path" | head -n 1 | cut -d: -f1 || true)"

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
    target_file="${target_file#../troubleshooting/}"
    require_file "docs/troubleshooting/$target_file"

    if [[ "$target" == *"#"* ]]; then
      anchor="${target#*#}"
      require_anchor "docs/troubleshooting/$target_file" "$anchor"
    fi
  done < <(grep -oE '\]\(\.\./troubleshooting/[^)]+' "$source" || true)
}

require_converted_guide_shape() {
  local guide="$1"

  require_file "$guide"
  require_text "$guide" "**Prerequisites:**"
  require_text "$guide" "**Time:**"
  require_text "$guide" "**Outcome:**"
  require_text "$guide" "**Verify:**"
  require_text "$guide" "**Scope:**"
  require_text "$guide" "## Fast path"
  require_text "$guide" "## Walkthrough"
  require_text "$guide" "## Rollback"
  require_text "$guide" "## Troubleshooting"
  require_text "$guide" "Run from"
  require_text "$guide" "Expected result:"
  require_regex "$guide" '^1\. '
  require_order "$guide" "**Prerequisites:**" "## Fast path"
  require_order "$guide" "## Fast path" "## Walkthrough"
  require_order "$guide" "## Walkthrough" "## Rollback"
  require_order "$guide" "## Rollback" "## Troubleshooting"
  reject_regex "$guide" '<(Verb|task outcome|topic|anchor|TODO|TBD)>' "converted guide must not contain template placeholders"
  reject_regex "$guide" '<!--' "converted guide must not contain contributor comments"
  check_troubleshooting_links "$guide"
}

router=docs/guides/README.md
windows_host_guide=docs/guides/01-windows-host.md
tmux_guide=docs/guides/05-tmux.md
neovim_guide=docs/guides/04-neovim.md
uv_guide=docs/guides/06-uv.md
wsl_stub=docs/guides/02-wsl2-ubuntu.md
wsl_install_guide=docs/guides/wsl-ubuntu-install.md
wsl_migration_guide=docs/guides/wsl-ubuntu-migration.md
verification_guide=docs/guides/99-verification.md
verification_inventory=docs/changes/2026-06-16-remaining-guides-template-rollout/verification-target-inventory.md
explain_change=docs/changes/2026-06-16-remaining-guides-template-rollout/explain-change.md
verify_report=docs/changes/2026-06-16-remaining-guides-template-rollout/verify-report.md
m1_evidence=docs/changes/2026-06-16-remaining-guides-template-rollout/reviews/m1-implementation-evidence.md
m2_evidence=docs/changes/2026-06-16-remaining-guides-template-rollout/reviews/m2-implementation-evidence.md
m3_evidence=docs/changes/2026-06-16-remaining-guides-template-rollout/reviews/m3-implementation-evidence.md
m4_evidence=docs/changes/2026-06-16-remaining-guides-template-rollout/reviews/m4-implementation-evidence.md
unregister_command="wsl --unreg""ister Ubuntu"

require_file "$router"
require_converted_guide_shape "$windows_host_guide"
require_converted_guide_shape "$tmux_guide"
require_converted_guide_shape "$neovim_guide"
require_converted_guide_shape "$uv_guide"
require_converted_guide_shape "$wsl_install_guide"
require_converted_guide_shape "$wsl_migration_guide"
require_converted_guide_shape "$verification_guide"

for guide in "$windows_host_guide" "$tmux_guide" "$neovim_guide" "$uv_guide" "$wsl_install_guide" "$wsl_migration_guide" "$verification_guide"; do
  require_text "$guide" "Backup:"
  require_text "$guide" "Rollback:"
  reject_regex "$guide" "generated documentation|template engine|one-command installer|hidden automation" "converted guides must not add generated tooling or hidden automation"
  reject_regex "$guide" "password=|token=|secret=|proxy\\.corp|internal\\.example|private key" "converted guides must not contain credential-like examples or private hostnames"
done

require_text "$windows_host_guide" "Windows Terminal"
require_text "$windows_host_guide" "PowerShell"
require_text "$windows_host_guide" "WinGet"
require_text "$windows_host_guide" "Microsoft Store/App Installer"
require_text "$windows_host_guide" "WSL availability"
require_text "$windows_host_guide" "administrator"
require_text "$windows_host_guide" "enterprise policy"
require_text "$windows_host_guide" "Do not run all install commands from an elevated shell by default."
require_regex "$windows_host_guide" '[w]inget install --id Microsoft\.PowerShell --source winget'
require_regex "$windows_host_guide" '[w]inget upgrade --id Microsoft\.PowerShell --source winget'
require_regex "$windows_host_guide" '[w]t --version'
require_regex "$windows_host_guide" '[w]sl --(version|status)'
require_regex "$windows_host_guide" 'Get-ExecutionPolicy -List'

require_text "$tmux_guide" "Ubuntu only"
reject_regex "$tmux_guide" "native Windows tmux support" "tmux guide must not claim native Windows tmux support"
require_text "$tmux_guide" 'Backup: if `~/.tmux.conf` already exists, save a copy before replacing it.'
require_text "$tmux_guide" "tmux -V"
require_text "$tmux_guide" "clean disposable session"

require_text "$neovim_guide" "Windows PowerShell"
require_text "$neovim_guide" "Ubuntu"
require_text "$neovim_guide" 'Backup: if `%LocalAppData%\nvim` already exists, save a copy before replacing it.'
require_text "$neovim_guide" 'Backup: if `~/.config/nvim` already exists, save a copy before replacing it.'
require_text "$neovim_guide" "Do not share plugin or runtime state through a Windows-mounted path."
require_text "$neovim_guide" "nvim --version"
require_text "$neovim_guide" "nvim --clean +'quit'"
require_text "$neovim_guide" ":Lazy"
require_text "$neovim_guide" ":checkhealth"

require_text "$uv_guide" "Optional"
require_text "$uv_guide" "optional"
require_text "$uv_guide" "Project-level"
require_text "$uv_guide" "User-level"
require_text "$uv_guide" "does not make Python runtime setup mandatory"
reject_regex "$uv_guide" "packages\\.example|internal\\.|company\\.|corp\\.|token=|password=|secret=" "uv examples must be credential-free and non-private"

require_file "$wsl_stub"
require_text "$wsl_stub" "compatibility"
require_text "$wsl_stub" "starting state"
require_text "$wsl_stub" "wsl-ubuntu-install.md"
require_text "$wsl_stub" "wsl-ubuntu-migration.md"
reject_regex "$wsl_stub" "[w]sl --(install|unregister|import|export|import-in-place|set-default|shutdown|list|help|version)|[w]sl -d " "WSL compatibility stub must not duplicate setup or migration commands"

require_text "$wsl_install_guide" "fresh install"
require_text "$wsl_install_guide" "D:\\Software\\WSL\\Ubuntu"
require_text "$wsl_install_guide" "D:\\Data"
require_text "$wsl_install_guide" "/home/<user>/data"
require_text "$wsl_install_guide" "~/src"
require_regex "$wsl_install_guide" '[w]sl --version'
require_regex "$wsl_install_guide" '[w]sl --help'
require_regex "$wsl_install_guide" '--install'
require_regex "$wsl_install_guide" '--distribution'
require_regex "$wsl_install_guide" '--location'
require_regex "$wsl_install_guide" '[w]sl --list --online'
require_regex "$wsl_install_guide" '[w]sl --install --distribution <UbuntuLtsDistroName> --location "D:\\Software\\WSL\\Ubuntu"'
require_regex "$wsl_install_guide" '[w]sl --update'
require_regex "$wsl_install_guide" '[w]sl --update --web-download'
require_regex "$wsl_install_guide" '[w]sl --install --web-download --distribution <UbuntuLtsDistroName> --location "D:\\Software\\WSL\\Ubuntu"'
require_regex "$wsl_install_guide" '[w]sl --list --verbose'
require_regex "$wsl_install_guide" '[w]sl -d <UbuntuLtsDistroName>'
reject_regex "$wsl_install_guide" '[w]sl --install Ubuntu --location' "positional WSL install-location command must not be published as the primary command"

require_text "$wsl_migration_guide" "migration/import path"
require_text "$wsl_migration_guide" "D:\\Software\\WSL\\Ubuntu"
require_text "$wsl_migration_guide" "D:\\Data"
require_text "$wsl_migration_guide" "~/src"
require_regex "$wsl_migration_guide" '[w]sl --shutdown'
require_regex "$wsl_migration_guide" '[w]sl --export Ubuntu D:\\Software\\WSL\\Ubuntu\\ext4\.vhdx --vhd'
require_regex "$wsl_migration_guide" '[w]sl --unregister Ubuntu'
require_regex "$wsl_migration_guide" '[w]sl --import-in-place Ubuntu D:\\Software\\WSL\\Ubuntu\\ext4\.vhdx'
require_regex "$wsl_migration_guide" '[w]sl --set-default Ubuntu'
require_regex "$wsl_migration_guide" '[w]sl -d Ubuntu'
require_regex "$wsl_migration_guide" '[w]sl --list --verbose'
require_text "$wsl_migration_guide" "successful backup or export"
require_text "$wsl_migration_guide" "data loss"
require_order "$wsl_migration_guide" "Backup/export:" "$unregister_command"
require_order "$wsl_migration_guide" "Destructive step:" "$unregister_command"

require_text "$router" "[uv setup](06-uv.md)"
require_text "$router" "optional"
require_text "$router" "[Install WSL2 Ubuntu](wsl-ubuntu-install.md)"
require_text "$router" "[Migrate WSL2 Ubuntu](wsl-ubuntu-migration.md)"
require_text "$router" "[WSL compatibility path](02-wsl2-ubuntu.md)"

require_file "$verification_inventory"
require_file "$explain_change"
require_text "$verification_inventory" "Active verification references"
require_text "$verification_inventory" "Unresolved verification follow-ups"
require_text "$verification_inventory" "First smaller-guide sequencing"
require_text "$verification_inventory" "not converted in M1"
require_text "$verification_inventory" "docs/guides/01-windows-host.md"
require_text "$verification_inventory" "docs/guides/wsl-ubuntu-install.md"
require_text "$verification_inventory" "docs/guides/wsl-ubuntu-migration.md"
require_text "$verification_inventory" "docs/guides/proxy-setup.md"
require_text "$verification_inventory" "docs/guides/04-neovim.md"
require_text "$verification_inventory" "docs/guides/05-tmux.md"
require_text "$verification_inventory" "docs/guides/06-uv.md"
require_text "$verification_inventory" "docs/guides/03-ubuntu-baseline.md"
require_text "$verification_inventory" "unresolved follow-up"

for path in \
  docs/guides/01-windows-host.md \
  docs/guides/wsl-ubuntu-install.md \
  docs/guides/wsl-ubuntu-migration.md \
  docs/guides/proxy-setup.md \
  docs/guides/04-neovim.md \
  docs/guides/05-tmux.md \
  docs/guides/06-uv.md; do
  require_file "$path"
  require_text "$verification_guide" "$path"
done

reject_regex "$verification_guide" '\]\(03-ubuntu-baseline\.md\)' "verification guide must not actively link unresolved Ubuntu baseline target"
reject_regex "$verification_guide" '\]\(ubuntu-baseline\.md\)' "verification guide must not actively link unresolved Ubuntu baseline target"
require_text "$verification_guide" "pass"
require_text "$verification_guide" "fail"
require_text "$verification_guide" "skipped"
require_text "$verification_guide" "needs manual action"
require_text "$verification_guide" "Verification matrix"
require_text "$verification_guide" "Publication gate"
require_text "$verification_guide" "Static checks"
require_text "$verification_guide" "Rollback coverage"

for text in \
  "Converted guides:" \
  "Compatibility paths:" \
  "Checks run:" \
  "Checks intentionally not run:" \
  "Command execution: not executed" \
  "Verification report: docs/changes/2026-06-16-remaining-guides-template-rollout/verify-report.md" \
  "Branch readiness: owned by verify" \
  "PR readiness: not claimed" \
  "M1-M5 code reviews: clean-with-notes"; do
  require_text "$explain_change" "$text"
done

require_file "$verify_report"
for text in \
  "Skill: verify" \
  "Status: completed" \
  "Open blockers: none" \
  "Next stage: pr" \
  "Readiness: branch-ready" \
  "Hosted CI: not observed"; do
  require_text "$verify_report" "$text"
done

require_file "$m1_evidence"
require_file "$m2_evidence"
require_file "$m3_evidence"
require_file "$m4_evidence"
for text in \
  "Milestone: M1" \
  "Command inventory:" \
  "Fast-path/walkthrough parity:" \
  "Backup-before-edit coverage:" \
  "Command-context coverage:" \
  "Expected-result coverage:" \
  "Troubleshooting-anchor result:" \
  "Security/privacy result:" \
  "Setup command execution: not executed"; do
  require_text "$m1_evidence" "$text"
done

for text in \
  "Milestone: M2" \
  "Command inventory:" \
  "Fast-path/walkthrough parity:" \
  "Backup-before-edit coverage:" \
  "Command-context coverage:" \
  "Expected-result coverage:" \
  "Policy/elevation coverage:" \
  "Troubleshooting-anchor result:" \
  "Security/privacy result:" \
  "Setup command execution: not executed"; do
  require_text "$m2_evidence" "$text"
done

for text in \
  "Milestone: M3" \
  "Command inventory:" \
  "Fast-path/walkthrough parity:" \
  "Backup/export-before-unregister coverage:" \
  "Command-context coverage:" \
  "Expected-result coverage:" \
  "Compatibility-stub result:" \
  "Router result:" \
  "Troubleshooting-anchor result:" \
  "High-risk command review:" \
  "Setup command execution: not executed"; do
  require_text "$m3_evidence" "$text"
done

for text in \
  "Milestone: M4" \
  "Verification target inventory:" \
  "Active-reference result:" \
  "Unresolved-follow-up result:" \
  "First-slice sequencing result:" \
  "Result-vocabulary coverage:" \
  "Command-context coverage:" \
  "Expected-result coverage:" \
  "Static-link result:" \
  "Setup command execution: not executed"; do
  require_text "$m4_evidence" "$text"
done

if grep -Eq '[a]pt update|[s]udo apt|[w]inget |[w]sl --install|[w]sl --unregister|[u]pdate-ca-certificates|[s]udo mount -a|[s]udo visudo' "$0"; then
  fail "proof script must not contain setup command execution checks"
fi
