#!/usr/bin/env bash
set -euo pipefail

guide=docs/guides/03-ubuntu-baseline.md
verification=docs/guides/99-verification.md
proxy_troubleshooting=docs/troubleshooting/proxy.md
ubuntu_troubleshooting=docs/troubleshooting/ubuntu-baseline.md
certificate_adr=docs/adr/2026-05-25-wsl-certificate-trust-policy.md

for path in "$guide" "$verification" "$proxy_troubleshooting" "$ubuntu_troubleshooting" "$certificate_adr"; do
  test -f "$path" || {
    echo "missing required file: $path" >&2
    exit 1
  }
done

grep -Fq '%UserProfile%\.wslconfig' "$guide"
grep -Fq 'notepad $env:USERPROFILE\.wslconfig' "$guide"
grep -Fq '[wsl2]' "$guide"
grep -Fq 'autoProxy=true' "$guide"
grep -q 'manual proxy' "$guide"
grep -q 'http_proxy' "$guide"
grep -q 'https_proxy' "$guide"
grep -q 'PAC' "$guide"
grep -q 'corporate CA' "$guide"
grep -q 'known limitation' "$proxy_troubleshooting"
grep -q 'all-certificates' "$proxy_troubleshooting"
grep -q 'Join-Path (Get-Location) "all-certificates"' "$proxy_troubleshooting"
grep -Fq 'Get-ChildItem -Recurse Cert:\' "$proxy_troubleshooting"
grep -q 'X509Certificate2' "$proxy_troubleshooting"
grep -q 'SeenThumbprints' "$proxy_troubleshooting"
grep -q 'SafeSubject' "$proxy_troubleshooting"
grep -q '/usr/local/share/ca-certificates/win11' "$proxy_troubleshooting"
grep -q 'sudo update-ca-certificates' "$proxy_troubleshooting"
grep -q 'SSL certificate problem' "$proxy_troubleshooting"
grep -q 'WSL Certificate Trust Policy' "$proxy_troubleshooting"
grep -q 'export public certificate data only' "$certificate_adr"
grep -q 'deduplicate certificates by thumbprint' "$certificate_adr"
grep -q 'never commit exported certificate material' "$certificate_adr"

grep -q '/etc/wsl.conf' "$guide"
grep -q 'enabled=false' "$guide"
grep -q 'mountFsTab=true' "$guide"
grep -q 'appendWindowsPath=false' "$guide"
grep -q 'APT source configuration' "$guide"
grep -q '/etc/apt/sources.list.d/ubuntu.sources' "$guide"
grep -q 'sudoedit /etc/apt/sources.list.d/ubuntu.sources' "$guide"
grep -q 'apt-cache policy' "$guide"
grep -q '/etc/fstab' "$guide"
grep -q 'D:/Data /home/<user>/data drvfs' "$guide"
grep -q '/home/<user>/data' "$guide"
grep -Fq 'D:\Data' "$guide"
grep -q 'sudo mount -a' "$guide"
grep -q 'fallback symlink' "$guide"
grep -q 'create, skip, or choose' "$guide"
grep -q '~/src' "$guide"

grep -q 'C.UTF-8' "$guide"
grep -q 'locale' "$guide"
grep -q 'UTF-8' "$guide"
grep -q 'warning-free' "$guide"
grep -q 'sudo update-locale LANG=C.UTF-8 LC_ALL=' "$guide"
grep -q 'sudo locale-gen en_US.UTF-8' "$guide"
grep -q 'LC_ALL' "$guide"
grep -q 'grep -nE' "$ubuntu_troubleshooting"

grep -q 'passwordless sudo' "$guide"
grep -q 'personal-workstation convenience profile' "$guide"
grep -q 'optional' "$guide"
grep -q 'project-owned sudoers drop-in' "$guide"
grep -q 'visudo' "$guide"
grep -q 'sudo -n true' "$guide"
grep -q 'skip' "$guide"

grep -q 'target path' "$guide"
grep -q 'backup behavior' "$guide"
grep -q 'rollback behavior' "$guide"
grep -q 'machine-wide' "$guide"

grep -q 'pass' "$verification"
grep -q 'fail' "$verification"
grep -q 'skipped' "$verification"
grep -q 'needs manual action' "$verification"
grep -q 'WSL config' "$verification"
grep -q 'proxy' "$verification"
grep -q 'data mount' "$verification"
grep -q 'locale' "$verification"
grep -q 'sudo' "$verification"
grep -q '/home/<user>/data' "$verification"
grep -q 'sudo mount -a' "$verification"
grep -q 'C.UTF-8' "$verification"
grep -q 'visudo' "$verification"

grep -q 'remove' "$guide"
grep -q '.wslconfig' "$guide"
grep -q '/etc/wsl.conf' "$guide"
grep -q '/etc/fstab' "$guide"
grep -q 'sudoers' "$guide"
grep -q 'proxy' "$guide"
