# Dot-source from the PowerShell 7 profile after prompt/PSReadLine setup.
# No installation or execution-policy changes. See docs/tools/fzf.md.
# Optional keys: set $TerminalFirstEnableFzfKeys = $true before dot-sourcing.
if ((Get-Variable TerminalFirstEnableFzfKeys -ValueOnly -ErrorAction SilentlyContinue) -eq $true -and
    -not (Get-Variable __TfdFzfLoaded -Scope Global -ValueOnly -ErrorAction SilentlyContinue) -and
    (Get-Command fzf -CommandType Application -ErrorAction SilentlyContinue)) {
    try {
        Import-Module PSReadLine -ErrorAction Stop
        Import-Module PSFzf -ErrorAction Stop
        Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
        $global:__TfdFzfLoaded = $true
    } catch {
        Write-Warning "terminal-first-dev: optional PSFzf keys not enabled: $_"
    }
}

# z/zi are added without replacing cd. zi needs fzf, not the PSFzf module.
if (-not (Get-Variable __TfdZoxideLoaded -Scope Global -ValueOnly -ErrorAction SilentlyContinue) -and
    (Get-Command zoxide -CommandType Application -ErrorAction SilentlyContinue)) {
    try {
        $__tfdInit = (& zoxide init powershell | Out-String)
        if ($LASTEXITCODE -ne 0 -or [string]::IsNullOrWhiteSpace($__tfdInit)) {
            throw 'zoxide init powershell did not produce a successful initialization script.'
        }
        Invoke-Expression $__tfdInit
        $global:__TfdZoxideLoaded = $true
    } catch {
        Write-Warning "terminal-first-dev: zoxide initialization failed: $_"
    } finally {
        Remove-Variable __tfdInit -ErrorAction SilentlyContinue
    }
}
