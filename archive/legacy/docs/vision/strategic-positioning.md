# Strategic Positioning

## Category

Concise developer setup guide for terminal-first Windows 11 development.

## Primary User

Developers who use Windows 11 as a primary or regular workstation and want a practical command-line-centered setup without adopting a large personal dotfiles project.

## Primary Pain

Windows development setup guidance is often scattered, overly broad, too beginner-oriented, or shaped around one person's machine automation. Users need a short path they can inspect and adapt.

## Primary Promise

Help a developer make a fresh or inconsistent Windows 11 machine usable for daily terminal-first development with clear defaults, visible tradeoffs, and minimal project overhead.

## Core Mechanism

An opinionated, compact sequence of setup decisions, commands, and checks that keep the terminal workflow central while calling out assumptions that depend on local preference or policy.

## Alternatives

- General Windows productivity setup guides.
- Personal dotfiles and bootstrap repositories.
- Enterprise workstation images or device-management playbooks.
- Linux migration or WSL-only guides.

## Tradeoff

The project chooses concise, auditable guidance over exhaustive coverage or full automation. That makes it easier to read and adapt, but it will not satisfy users who need a complete managed workstation platform.

## Compatibility Surfaces

- Windows 11 versions and policy settings.
- Windows Terminal, PowerShell, WSL, Git, package managers, editors, and shells.
- Local security posture around execution policy, credentials, package sources, and machine-wide changes.
- Repository format, Markdown documentation, scripts, and CI if added later.

## Refusals

- No broad operating-system tweaking guide.
- No unrelated app recommendation catalog.
- No opaque one-command bootstrapper as the main identity.
- No enterprise fleet-management scope.
- No hidden tradeoffs around security-sensitive or machine-wide changes.

## Falsifiability

The positioning fails if the project cannot remain short while producing a credible terminal-first Windows 11 development environment, if the guidance depends on unexplained personal preferences, if it breaks on current Windows 11 machines, or if the setup becomes so elaborate that users need separate orientation material to understand it.
