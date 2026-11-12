# Isolated mocks, no Pester dependency. Run with pwsh -NoProfile -File.
$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest
$Snippet = Join-Path $PSScriptRoot '../../config/shell/navigation.ps1'
$Tokens = $null
$ParseErrors = $null
$null = [System.Management.Automation.Language.Parser]::ParseFile($Snippet, [ref]$Tokens, [ref]$ParseErrors)
if ($ParseErrors.Count) { throw ($ParseErrors | Out-String) }
$OriginalCd = (Get-Alias cd).Definition
$env:FZF_DEFAULT_OPTS = '--height=35%'

function Assert([bool]$Condition, [string]$Message) {
    if (-not $Condition) { throw $Message }
}
function Reset-Fixture {
    $script:Tools = @()
    $script:Calls = [System.Collections.Generic.List[string]]::new()
    $script:FailZoxide = $false
    $script:FailModule = $false
    $script:BadEval = $false
    $script:TerminalFirstEnableFzfKeys = $false
    foreach ($Name in '__TfdFzfLoaded', '__TfdZoxideLoaded', '__TfdMockZ', '__TfdPoison') {
        Remove-Variable -Name $Name -Scope Global -ErrorAction SilentlyContinue
    }
}
function Get-Command {
    [CmdletBinding()]
    param([string]$Name, [string]$CommandType)
    if ($script:Tools -contains $Name) { [pscustomobject]@{ Name = $Name } }
}
function Import-Module {
    [CmdletBinding()]
    param([string]$Name)
    $script:Calls.Add("import:$Name")
    if ($script:FailModule -and $Name -eq 'PSFzf') { throw 'simulated missing PSFzf' }
}
function Set-PsFzfOption {
    param([string]$PSReadlineChordProvider, [string]$PSReadlineChordReverseHistory)
    $script:Calls.Add("keys:${PSReadlineChordProvider},${PSReadlineChordReverseHistory}")
}
function zoxide {
    param([string]$Verb, [string]$Shell)
    $script:Calls.Add("zoxide:$Verb $Shell")
    $global:LASTEXITCODE = 0
    if ($script:FailZoxide) {
        $global:LASTEXITCODE = 1
        '$global:__TfdPoison = $true'
    } elseif ($script:BadEval) {
        "throw 'simulated initialization error'"
    } else {
        '$global:__TfdMockZ = $true'
    }
}

# 1: Neither executable installed.
Reset-Fixture
. $Snippet
Assert ($Calls.Count -eq 0) 'Missing tools must not execute anything.'

# 2: zoxide works alone; successful initialization runs once.
Reset-Fixture
$Tools = @('zoxide')
. $Snippet
. $Snippet
Assert ($Calls.Count -eq 1 -and $global:__TfdMockZ) 'zoxide must initialize once.'
Assert ((Get-Alias cd).Definition -eq $OriginalCd) 'cd must stay unchanged.'
Assert ($env:FZF_DEFAULT_OPTS -eq '--height=35%') 'User fzf options must stay unchanged.'

# 3: Merely having fzf installed must not enable optional PowerShell keys.
Reset-Fixture
$Tools = @('fzf')
. $Snippet
Assert ($Calls.Count -eq 0) 'PSFzf keys must require explicit opt-in.'

# 4: Explicit opt-in loads PSReadLine before PSFzf and initializes zoxide last.
Reset-Fixture
$Tools = @('fzf', 'zoxide')
$TerminalFirstEnableFzfKeys = $true
. $Snippet
. $Snippet
Assert (($Calls -join '|') -eq 'import:PSReadLine|import:PSFzf|keys:Ctrl+t,Ctrl+r|zoxide:init powershell') 'Wrong order or duplicate initialization.'

# 5: Missing module must not stop zoxide; retry can enable keys later.
Reset-Fixture
$Tools = @('fzf', 'zoxide')
$TerminalFirstEnableFzfKeys = $true
$FailModule = $true
. $Snippet
Assert ($global:__TfdMockZ) 'A PSFzf failure must not block zoxide.'
Assert (-not (Get-Variable __TfdFzfLoaded -Scope Global -ValueOnly -ErrorAction SilentlyContinue)) 'Failed module must not be marked loaded.'
$FailModule = $false
. $Snippet
Assert ($global:__TfdFzfLoaded) 'Module initialization should be retryable.'
Assert (@($Calls | Where-Object { $_ -eq 'zoxide:init powershell' }).Count -eq 1) 'zoxide was initialized twice.'

# 6: A failed native command may print code; never evaluate it.
Reset-Fixture
$Tools = @('zoxide')
$FailZoxide = $true
. $Snippet
Assert (-not (Get-Variable __TfdPoison -Scope Global -ValueOnly -ErrorAction SilentlyContinue)) 'Failed command output was evaluated.'
$FailZoxide = $false
. $Snippet
Assert ($global:__TfdMockZ -and $Calls.Count -eq 2) 'Failed zoxide initialization should be retryable.'

# 7: Failed generated code must not be marked loaded.
Reset-Fixture
$Tools = @('zoxide')
$BadEval = $true
. $Snippet
Assert (-not (Get-Variable __TfdZoxideLoaded -Scope Global -ValueOnly -ErrorAction SilentlyContinue)) 'Failed evaluation was marked loaded.'
Reset-Fixture
Write-Output 'PASS: 7 PowerShell snippet cases (mocked tools; no setup commands)'
