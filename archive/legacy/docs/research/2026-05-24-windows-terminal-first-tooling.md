# Windows Terminal-First Tooling Research

## Decision To Support

This research supports the first-version proposal for a concise Windows 11 terminal-first development setup guide. It informs whether the guide should use Windows Terminal plus PowerShell as the baseline, whether `winget` is a reasonable default install/update mechanism, how WSL should be positioned, and which security or policy caveats need to appear before a spec is written.

## Research Plan

- Decision: choose first-version defaults for terminal, shell, package manager, Git, WSL posture, editor assumptions, and validation evidence.
- Questions: answer the install/update path, admin impact, machine-wide impact, policy variance, and minimum walkthrough questions from the exploration artifact.
- Acceptable sources: official Microsoft documentation, official Git documentation, and official editor/vendor documentation.
- Evidence that would change the recommendation: official docs recommending a non-`winget` path for Windows clients, WSL requiring a different default posture for Windows 11 development, or official docs showing that recommended commands are too policy-sensitive for a concise guide.
- Stop condition: stop after the first-version baseline tools and the major security/policy caveats are sourced.

## Questions Answered

1. What is the current recommended installation and update path for Windows Terminal, PowerShell, Git for Windows, WSL, and a likely editor?
2. Which package manager should the first guide use as the default, if any?
3. Which commands require administrator privileges or affect machine-wide or policy-sensitive state?
4. Which setup steps vary under common enterprise Windows policies?
5. What minimum walkthrough can verify the first guide on a Windows 11 machine?

## Summary Conclusion

The first version should use a Windows-native baseline: Windows Terminal as the terminal host, PowerShell 7 as the modern shell, `winget` as the default package manager for Windows client installs and upgrades, Git for Windows as the baseline Git distribution, and WSL as an optional layer rather than the default path.

This direction is well supported by official docs and matches the project's concise, auditable identity. The proposal and spec should avoid hidden automation and should label elevation, Store/App Installer availability, WSL feature enablement, execution policy, and enterprise policy controls as visible caveats.

## Evidence Table

| Source | Finding | Confidence | Relevance |
| --- | --- | --- | --- |
| Microsoft Learn: [Use WinGet to install and manage applications](https://learn.microsoft.com/en-us/windows/package-manager/winget/) | WinGet is available on Windows 11 through App Installer and supports discover, install, upgrade, remove, configure, sources, and troubleshooting workflows. It may not be available until first user login registers App Installer. | High | Supports `winget` as the default package manager, with a first-login availability caveat. |
| Microsoft Learn: [Use WinGet to install and manage applications](https://learn.microsoft.com/en-us/windows/package-manager/winget/) | Installer behavior differs by elevation. Non-admin use can prompt for elevation; admin shells suppress those prompts, so trusted packages and cautious admin use matter. | High | The guide should not blindly tell users to run all install commands as administrator. |
| Microsoft Learn: [WinGet](https://learn.microsoft.com/en-us/windows/package-manager/) | WinGet has enterprise security and Group Policy controls, including source control, local development settings, command-line and proxy options, and Microsoft Store certificate-pinning behavior. | High | Enterprise-managed devices may diverge from the simple path; the guide should call this out. |
| Microsoft Learn: [Install PowerShell on Windows](https://learn.microsoft.com/en-us/powershell/scripting/install/install-powershell-on-windows) | WinGet is the recommended install method for PowerShell on Windows clients. PowerShell can be installed with `winget install --id Microsoft.PowerShell --source winget` and upgraded with `winget upgrade --id Microsoft.PowerShell`. | High | Supports PowerShell 7 plus `winget` as a current baseline. |
| Microsoft Learn: [Install PowerShell on Windows](https://learn.microsoft.com/en-us/powershell/scripting/install/install-powershell-on-windows) | PowerShell install packaging can differ by version and package type, and upgrades should generally use the same install method originally used. | High | The guide should include verification before upgrade guidance and avoid assuming one package format forever. |
| Microsoft Learn: [about_Execution_Policies](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies) | Execution policy is Windows-specific, can be set at current user or local machine scopes, and Group Policy can override user changes. | High | Any script-related guidance needs explicit policy caveats; first version should avoid requiring execution-policy changes. |
| Microsoft Learn: [Windows Terminal installation](https://learn.microsoft.com/en-us/windows/terminal/install) | Windows Terminal can be set as the default terminal application on Windows 11. Its default profile is PowerShell after installation, and it auto-creates profiles for WSL distributions or multiple PowerShell versions. | High | Supports Windows Terminal plus PowerShell as the baseline while keeping WSL optional. |
| Microsoft Learn: [Windows Terminal startup settings](https://learn.microsoft.com/en-us/windows/terminal/customize-settings/startup) | The default terminal application is an OS setting and is available on Windows 11. | High | Changing the default terminal should be presented as a user-visible OS preference. |
| Microsoft Learn: [Install WSL](https://learn.microsoft.com/en-us/windows/wsl/install) | WSL install on Windows 11 is available with `wsl --install`, requires administrator PowerShell for the install command, enables required features, installs Ubuntu by default, and requires restart. | High | WSL is valuable but more invasive than the terminal/shell baseline, so optional positioning is justified. |
| Git SCM: [Install Git for Windows](https://git-scm.com/install/windows) | Official Git docs provide a Git for Windows download and a `winget install --id Git.Git -e --source winget` command. | High | Supports Git for Windows as the baseline Git install path. |
| Visual Studio Code: [Installing VS Code on Windows](https://code.visualstudio.com/docs/setup/windows) | VS Code User setup installs under the user's profile and adds `code` to PATH; System setup requires administrator permissions and installs for all users. VS Code docs also describe Windows Terminal and WSL as Windows development tools. | High | Supports presenting VS Code as a common optional editor and distinguishing user-scope vs machine-scope install. |

## Implications For Proposal, Spec, Architecture, And Tests

- Proposal: recommend O1 then O2 from the exploration artifact.
- Proposal: choose Windows Terminal plus PowerShell 7 as the first-version baseline.
- Proposal: position WSL as optional because installation enables Windows features, installs a distribution, and requires elevation and restart.
- Proposal: use `winget` as the default package-manager path for Windows 11 clients, with manual download alternatives for locked-down or Store-restricted environments.
- Spec: identify commands that require administrator rights, may prompt for elevation, change OS settings, or depend on enterprise policy.
- Spec: include verification steps such as `winget --version`, `pwsh --version`, `git --version`, `wt --version`, `wsl --status` or `wsl --version` only when WSL is in scope, and `code --version` only when VS Code is included.
- Spec: avoid requiring execution-policy changes in the first guide unless script execution becomes part of the product surface.
- Architecture: no architecture artifact is needed for a documentation-only guide. Architecture becomes triggered if scripts, generated configs, or machine-changing automation are introduced.
- Tests: before implementation, create a test spec or validation checklist that covers link review, command review, and a manual Windows 11 walkthrough. A full automated test suite is not yet possible without executable artifacts.

## Remaining Uncertainty

- The owner still needs to accept or reject the proposed baseline: Windows Terminal plus PowerShell 7, `winget`, Git for Windows, optional WSL, optional VS Code.
- The first version still needs a package-manager fallback policy for machines where App Installer, Microsoft Store, or WinGet sources are blocked.
- The exact package list should be kept short; adding language runtimes may require separate research.
- The repository still needs a decision on whether `.agents/skills/` remains committed.
- A real Windows 11 walkthrough has not been performed in this environment.

## Recommendation

Proceed to `proposal` with a staged first-version direction:

1. Replace generic README template content with project-specific orientation.
2. Add a concise manual setup guide using Windows Terminal, PowerShell 7, `winget`, and Git for Windows as the baseline.
3. Treat WSL and VS Code as optional sections with clear scope and verification commands.
4. Defer setup scripts until a later proposal, architecture note, test strategy, and dry-run contract exist.
