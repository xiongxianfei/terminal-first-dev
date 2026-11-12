# Configure WSL automatic proxy mirroring

**Prerequisites:** WSL2 Ubuntu is installed; Windows proxy or VPN policy is already configured; you can edit `%UserProfile%\.wslconfig` for the current Windows user.
**Time:** ~10 minutes.
**Outcome:** Ubuntu uses WSL automatic proxy mirroring, or you have a targeted fallback path when local policy blocks it.
**Verify:** `curl -I https://github.com` or a policy-approved HTTPS endpoint succeeds from Ubuntu.

## Fast path

1. Enable automatic proxy mirroring in `%UserProfile%\.wslconfig`.

   Warning: this changes WSL global configuration for the current Windows user.

   Backup: if `%UserProfile%\.wslconfig` already exists, save a copy before editing it.

   ```ini
   [wsl2]
   autoProxy=true
   ```

   Expected result: `%UserProfile%\.wslconfig` contains `[wsl2]` and `autoProxy=true`.

   If automatic mirroring is blocked by WSL version, VPN, or enterprise policy, use [automatic proxy mirroring does not work](#automatic-proxy-mirroring-does-not-work).

2. Restart WSL from Windows PowerShell.

   ```powershell
   wsl --shutdown
   ```

   Expected result: WSL shuts down without an error. Open Ubuntu again after the command returns.

3. Verify HTTPS access from Ubuntu.

   ```bash
   curl -I https://github.com
   ```

   Expected result: HTTP response headers print without a proxy, DNS, timeout, or certificate error.

   If your environment blocks GitHub, use an approved HTTPS endpoint instead. If HTTPS fails with a certificate or issuer error, use [WSL SSL certificate trust fails](#wsl-ssl-certificate-trust-fails). If proxy credentials would be required in environment variables, read [manual proxy fallback cautions](#manual-proxy-fallback-cautions) before entering anything in a shell.

## Walkthrough

### 1. Enable automatic proxy mirroring

WSL automatic proxy mirroring lets Ubuntu use the Windows proxy configuration instead of keeping a separate Linux proxy setup. This is the primary path for this project when the installed WSL version and local policy support it.

Warning: `%UserProfile%\.wslconfig` affects WSL behavior for the current Windows user. Save a copy before editing an existing file.

Target path: `%UserProfile%\.wslconfig`

Backup behavior: if the file already exists, save a copy before editing it.

Rollback: remove the project-owned `autoProxy=true` entry or restore the backup, then restart WSL.

Scope: user-local WSL global configuration for the Windows account.

Open the file from Windows PowerShell:

```powershell
notepad $env:USERPROFILE\.wslconfig
```

Add or verify:

```ini
[wsl2]
autoProxy=true
```

Expected result: `%UserProfile%\.wslconfig` contains `[wsl2]` and `autoProxy=true`.

If automatic mirroring is blocked by WSL version, VPN, or enterprise policy, use [automatic proxy mirroring does not work](#automatic-proxy-mirroring-does-not-work). PAC files remain a first-slice limitation; keep PAC handling in troubleshooting and local policy documentation.

### 2. Restart WSL

WSL reads `.wslconfig` when the WSL VM starts. Restart WSL after changing the file.

Run from Windows PowerShell:

```powershell
wsl --shutdown
```

Then open Ubuntu again from Windows Terminal.

Expected result: WSL shuts down without an error and Ubuntu starts normally.

Rollback: restore the previous `.wslconfig` or remove the project-owned proxy entry, then run `wsl --shutdown` again.

### 3. Verify HTTPS access

Run from Ubuntu:

```bash
curl -I https://github.com
```

Expected result: HTTP response headers print without a proxy, DNS, timeout, or certificate error.

If your organization blocks GitHub, use a policy-approved HTTPS endpoint that should be reachable through the Windows proxy.

If HTTPS fails with a certificate or issuer error, use [WSL SSL certificate trust fails](#wsl-ssl-certificate-trust-fails). If the environment requires manual `http_proxy`, `https_proxy`, or `no_proxy` values, read [manual proxy fallback cautions](#manual-proxy-fallback-cautions) before entering anything in a shell.

## Rollback

Remove the project-owned `autoProxy=true` entry from `%UserProfile%\.wslconfig` or restore the backup copy, then restart WSL from Windows PowerShell:

```powershell
wsl --shutdown
```

Manual fallback variables are shell-session-only unless you persist them yourself. Unset session variables with:

```bash
unset http_proxy https_proxy no_proxy
```

## Troubleshooting

Use the targeted troubleshooting entry that matches the symptom:

- Automatic mirroring blocked or unavailable: [automatic proxy mirroring does not work](#automatic-proxy-mirroring-does-not-work)
- Proxy credentials, private hostnames, or shell-history risk: [manual proxy fallback cautions](#manual-proxy-fallback-cautions)
- HTTPS certificate or issuer errors: [WSL SSL certificate trust fails](#wsl-ssl-certificate-trust-fails)

## Proxy Troubleshooting

### Purpose

Track proxy behavior that can affect Windows, WSL, Ubuntu package installation, Neovim plugins, and terminal tools.

### Current scope

This note documents WSL automatic proxy mirroring as the primary path, manual environment-variable fallback, and first-slice limits for PAC files and corporate CA certificates. This troubleshooting page includes a manual certificate export/import path for WSL when HTTPS fails because Ubuntu does not trust a Windows-managed corporate root certificate.

### Safety notes

Do not paste proxy credentials into shell history when a secure alternative exists.

### Automatic proxy mirroring does not work

Check `%UserProfile%\.wslconfig` on Windows:

```ini
[wsl2]
autoProxy=true
```

After editing the file, restart WSL:

```powershell
wsl --shutdown
```

If enterprise policy, VPN behavior, or the installed WSL version blocks automatic proxy mirroring, use the manual proxy fallback in `docs/linux/ubuntu-setup.md`.

### Manual proxy fallback cautions

Manual proxy variables such as `http_proxy`, `https_proxy`, and `no_proxy` can unblock Ubuntu package installation and terminal tools, but they can also leak proxy credentials if copied into shell history, logs, or committed files.

Use credential-free examples in public docs. Keep private proxy hostnames, usernames, passwords, tokens, and certificate material out of the repository.

### WSL SSL certificate trust fails

Symptoms can include `SSL certificate problem`, `unable to get local issuer certificate`, or HTTPS failures from `apt`, `curl`, `git`, language package managers, or Neovim plugin installation inside WSL while the same site works from Windows.

Design reference: [ADR: WSL Certificate Trust Policy](../../archive/legacy/docs/adr/2026-05-25-wsl-certificate-trust-policy.md).

Warning: importing all Windows root and intermediate certificates into Ubuntu broadly extends Ubuntu's trust store. Prefer exporting only the required enterprise root or intermediate certificate when you know which certificate is needed. Do not commit exported certificates to this repository.

#### 1. Export Windows certificates from PowerShell

Run in Windows PowerShell from the folder where you want the export directory created. This exports public certificates only, not private keys, into `.\all-certificates` as PEM files.

```powershell
$StoreToDir = Join-Path (Get-Location) "all-certificates"
New-Item -ItemType Directory -Force -Path $StoreToDir | Out-Null

$SeenThumbprints = @{}

Get-ChildItem -Recurse Cert:\ |
  Where-Object { $_ -is [System.Security.Cryptography.X509Certificates.X509Certificate2] } |
  ForEach-Object {
    $Thumbprint = $_.Thumbprint

    if ($SeenThumbprints.ContainsKey($Thumbprint)) {
      return
    }

    $SeenThumbprints[$Thumbprint] = $true

    $SafeSubject = $_.Subject -replace '[^\w.-]', '_'
    if ([string]::IsNullOrWhiteSpace($SafeSubject)) {
      $SafeSubject = "certificate"
    }

    $Path = Join-Path $StoreToDir "$SafeSubject-$Thumbprint.pem"

    $Pem = @(
      "-----BEGIN CERTIFICATE-----"
      [Convert]::ToBase64String($_.RawData, [System.Base64FormattingOptions]::InsertLineBreaks)
      "-----END CERTIFICATE-----"
      ""
    ) -join "`n"

    Set-Content -Path $Path -Value $Pem -Encoding ascii
  }

"Exported PEM files: $((Get-ChildItem $StoreToDir -Filter *.pem).Count)"
"Output directory: $StoreToDir"
```

The recursive `Cert:\` scan finds certificates outside the basic root and intermediate stores, filters only real `X509Certificate2` objects, names files safely with subject plus thumbprint, and deduplicates certificates by thumbprint.

If local policy blocks reading machine-level stores, rerun PowerShell as Administrator or change the scan root to `Cert:\CurrentUser`.

#### 2. Copy PEM files into WSL as CRT files

Run inside Ubuntu:

```bash
mkdir -p /tmp/win11-certificates
cp /mnt/c/<PathToExportFolder>/all-certificates/*.pem /tmp/win11-certificates/

for cert in /tmp/win11-certificates/*.pem; do
  cp "$cert" "/tmp/win11-certificates/$(basename "$cert" .pem).crt"
done
```

Replace `<PathToExportFolder>` with the Windows path, below `/mnt/c`, for the folder where PowerShell created `all-certificates`. For example, if PowerShell exported to `C:\Users\Ada\Downloads\all-certificates`, use `/mnt/c/Users/Ada/Downloads/all-certificates/*.pem`.

#### 3. Install certificates into Ubuntu's system CA directory

Run inside Ubuntu:

```bash
sudo mkdir -p /usr/local/share/ca-certificates/win11
sudo cp /tmp/win11-certificates/*.crt /usr/local/share/ca-certificates/win11/
sudo update-ca-certificates
```

Expected result: `sudo update-ca-certificates` reports added certificates or no changes without errors.

#### 4. Verify HTTPS from WSL

Run inside Ubuntu:

```bash
curl -I https://github.com
git ls-remote https://github.com/neovim/neovim.git HEAD
```

If these commands still fail, confirm the exported certificate is the actual enterprise root or intermediate used by the proxy, VPN, or TLS inspection device.

Rollback:

```bash
sudo rm -rf /usr/local/share/ca-certificates/win11
sudo update-ca-certificates --fresh
```

### Known limitations

PAC file handling remains a known limitation in the first implementation slice. Corporate CA certificate handling is troubleshooting-only and manual; this repository does not automatically install PAC handling or corporate trust roots.
