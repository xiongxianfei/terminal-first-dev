# WSL Troubleshooting

## Purpose

Track WSL command-version drift, unsupported options, storage-location checks, and migration recovery notes.

## Current scope

This note covers fresh install-location support, migration/import-in-place recovery, and storage path verification.

## Safety notes

Do not run destructive WSL commands against a production distro unless backup or export verification has already passed.

## Unsupported fresh install-location command

If `wsl --help` does not list `--location`, run:

```powershell
wsl --update
wsl --shutdown
wsl --help
```

If `--location` is still unavailable, stop the fresh custom-location path. These unsupported systems must use the migration/import path or another documented fallback instead of silently installing to the default storage location.

## WSL update fails through Microsoft Store

If `wsl --update` fails because Microsoft Store delivery is blocked, stale, or unavailable, use the web-download path from Windows PowerShell:

```powershell
wsl --update --web-download
wsl --shutdown
wsl --version
```

If `--web-download` is not supported, record the WSL version and Windows build, then use the policy-approved WSL installer or update path for the machine.

## WSL update fails with `Wsl/UpdatePackage/0x80190193`

`Wsl/UpdatePackage/0x80190193` commonly indicates that the update request reached an HTTP endpoint but was blocked or rejected, often by proxy, VPN, TLS inspection, or enterprise network policy.

Use this recovery path from Windows PowerShell.

First record the current proxy state:

```powershell
netsh winhttp show proxy
Get-ChildItem Env:HTTP_PROXY,Env:HTTPS_PROXY,Env:NO_PROXY -ErrorAction SilentlyContinue
```

Temporarily close or bypass the proxy for the WSL update attempt. For WinHTTP proxy state, reset the proxy:

```powershell
netsh winhttp reset proxy
```

If the proxy is configured through Windows Settings, open the proxy settings page and temporarily disable the active proxy or VPN according to local policy:

```powershell
Start-Process ms-settings:network-proxy
```

Retry the WSL update using web download instead of Microsoft Store delivery:

```powershell
wsl --update --web-download
wsl --shutdown
wsl --version
```

If the update succeeds, restore the proxy or VPN settings required by the machine or organization. If a WinHTTP proxy is required, restore it with the policy-approved value:

```powershell
netsh winhttp set proxy <proxy-server> <bypass-list>
```

Example shape only:

```powershell
netsh winhttp set proxy proxy.example:8080 "localhost;127.0.0.1"
```

Do not commit private proxy hostnames, credentials, tokens, PAC URLs, or internal network details. If enterprise policy controls proxy configuration, ask the device owner or administrator before changing it.

## WSL install download hangs

If distro installation hangs at `0.0%` or Store delivery is blocked, retry with web download:

```powershell
wsl --install --web-download --distribution <UbuntuLtsDistroName>
```

For this project's custom storage path, use `--location` only when the local `wsl --help` confirms support:

```powershell
wsl --install --web-download --distribution <UbuntuLtsDistroName> --location "D:\Software\WSL\Ubuntu"
```

<a id="migration-import-in-place-recovery"></a>

## Migration/import-in-place recovery

The migration/import path depends on a successful export or backup before unregister.

If export fails:

- keep the existing registered distro;
- do not run `wsl --unregister`;
- check disk space and whether the distro is still running.

If import-in-place fails:

- preserve `D:\Software\WSL\Ubuntu\ext4.vhdx`;
- do not delete the export;
- review the distro name and WSL version;
- retry only after the failure is understood.

## Storage path checks

The intended WSL storage path is `D:\Software\WSL\Ubuntu`. The intended shared data path is `D:\Data`, which later maps to `/home/<user>/data`.

Use the best available non-destructive check for the current WSL version to confirm the registered distro storage path. If a direct location query is unavailable, record the VHDX path used for fresh install or import-in-place and verify the distro launches with `wsl -d Ubuntu` or the selected explicit Ubuntu LTS distro name.
