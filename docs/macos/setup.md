# MacBook Terminal Baseline

## Scope

This guide defines the baseline setup path for a personal developer MacBook that will be used for terminal-first development. The default audience is a personal developer MacBook with administrator access.

The intended primary target is Apple silicon. Manual verification is not complete yet, so command-success, setup-completion, Intel compatibility, and managed-Mac compatibility claims remain unverified until recorded evidence exists in [the verification record](verification.md).

This is the macOS setup path within the shared [Terminal-First Development Notes](../../README.md). Windows/WSL instructions and existing Neovim/tmux configurations are not automatically applicable to macOS.

## Traceability

Imported from [terminal-first-macos-dev at commit 8d3521798dde](https://github.com/xiongxianfei/terminal-first-macos-dev/tree/8d3521798dde9af1aec1d803591eda1fbacbf18f) on November 12, 2026. This is a content-only import; source commit history remains in the original repository. The import does not constitute a manual setup test.

| Source path | Destination or status |
| --- | --- |
| `docs/guides/macbook-terminal-baseline.md` | [setup.md](setup.md) |
| `docs/verification/macbook-terminal-baseline.md` | [verification.md](verification.md) |
| `tests/markdown/macbook-setup-best-practices.test.sh` | Previously imported as `tests/markdown/macos.test.sh`; retired with the Markdown content checks |

Copyright 2026 xiongxianfei. The imported material retains its [Apache-2.0 license](../../LICENSE); the [source license](https://github.com/xiongxianfei/terminal-first-macos-dev/blob/8d3521798dde9af1aec1d803591eda1fbacbf18f/LICENSE) records the same notice. Navigation and repository-boundary wording have been adapted; workstation command blocks are unchanged.

Historical proposal, spec, test spec, and plan are retained in Git history, not reinstated as active governance:

- [Proposal](https://github.com/xiongxianfei/terminal-first-dev/blob/f13eb81fe167bd7902d1b707ea1370011e977ff4/archive/legacy/docs/proposals/2026-06-17-macbook-setup-best-practices.md)
- [Spec](https://github.com/xiongxianfei/terminal-first-dev/blob/f13eb81fe167bd7902d1b707ea1370011e977ff4/archive/legacy/specs/macbook-setup-best-practices.md)
- [Test spec](https://github.com/xiongxianfei/terminal-first-dev/blob/f13eb81fe167bd7902d1b707ea1370011e977ff4/archive/legacy/specs/macbook-setup-best-practices.test.md)
- [Plan](https://github.com/xiongxianfei/terminal-first-dev/blob/f13eb81fe167bd7902d1b707ea1370011e977ff4/archive/legacy/docs/plans/2026-06-17-macbook-setup-best-practices.md)

## Verification status

Manual verification is not complete. Treat each terminal command as guidance, not as a verified transcript.

Before any future edit marks a command, compatibility target, or setup state as verified, record the exact evidence in [the verification record](verification.md).

When recording evidence, use explicit status labels: `verified`, `manually checked`, `skipped`, `blocked`, or `policy-dependent`.

## Prerequisites

- Use a personal developer MacBook where you control the setup choices.
- Confirm you can use an administrator account before administrator-dependent steps.
- Use the latest stable macOS offered by Software Update for this Mac. Do not use beta macOS behavior as the default path.
- Keep a current backup before persistent changes.
- Use Terminal with the default zsh shell unless a later guide states otherwise.
- Stop before applying organization-specific policy, certificates, proxy settings, endpoint-security exceptions, or credential rules.

## Outcome

The terminal baseline means the Mac is ready for later role-specific development setup because it has:

- Ownership context recorded.
- Hardware model and CPU architecture identified.
- Backup posture confirmed before persistent changes.
- Apple-owned system tooling reviewed through Apple-supported paths.
- Apple developer tooling installed or verified before third-party package-manager setup.
- Homebrew scoped to third-party developer CLI tooling.
- Shell, Git, SSH, credential, and minimal editor readiness reviewed.
- Verification evidence path established without claiming setup completion yet.

## Safety gates before setup changes

Stop before changing package sources, shell startup files, credentials, privacy permissions, encryption state, or machine-wide settings unless all of these gates are true:

- Ownership context is personal, not managed or corporate-controlled.
- Backup posture is known and current enough for your risk tolerance.
- You understand whether the step changes persistent state and how to inspect or reverse it.
- Administrator access is available for steps that require it.
- Manual verification evidence will be recorded before command-success claims are published.

If backup posture is unknown, resolve backup status first. If administrator privileges are unavailable, do not work around policy; mark the blocked steps and use policy-approved handling.

## Ownership context

Use the personal Mac path only when the Mac is personally controlled and you can make user-local setup choices.

Use the policy-dependent path and stop before state-changing setup when any of these apply:

- MDM enrollment or device-management profiles.
- Endpoint security tools that inspect or restrict developer tooling.
- Corporate certificate or proxy requirements.
- FileVault policy controlled by an organization.
- Restricted administrator rights.
- Organization-specific SSH key, credential, package-source, or network policy.

Managed or corporate Mac setup is not the default path. Follow organization-approved guidance before package-manager, shell, credential, certificate, proxy, FileVault, or privacy changes.

## Hardware and compatibility

Identify hardware model and CPU architecture before compatibility-sensitive guidance.

Suggested checks to record during manual verification:

```bash
system_profiler SPHardwareDataType
uname -m
```

Interpretation for this baseline:

- `arm64` means Apple silicon.
- Apple silicon is the intended primary target; verification requires recorded manual evidence.
- Intel support is unverified unless separate Intel verification evidence is added.

Do not convert this guide into a universal macOS compatibility claim. If hardware model, CPU architecture, or verification evidence does not match the recorded target, stop and route to troubleshooting or a later compatibility decision.

## Backup and Apple-owned system setup

Confirm backup posture before system updates, package-manager installation, shell profile edits, credential changes, or other persistent changes.

Use Apple's Software Update path for macOS updates:

- System Settings -> General -> Software Update.
- Accept stable macOS updates offered for this device.
- Beta releases are not the default setup path.

Source reference:

- Apple Support: [Update macOS on Mac](https://support.apple.com/en-us/108382).

Review these Apple-owned system concerns before package-manager setup:

- FileVault status.
- Recovery-key handling. Treat the recovery key as sensitive and do not publish it in notes, screenshots, or transcripts.
- Apple Account assumptions for Apple-owned downloads or developer tooling.
- Administrator-account availability.
- Privacy & Security settings for developer tools that request filesystem, network, automation, or local-network permissions.

Apple-owned system tooling means macOS updates, Software Update, Xcode, Command Line Tools, Apple Account, FileVault, and system Privacy & Security controls. Do not use Homebrew for Apple-owned macOS updates or Apple system security settings.

## Apple developer tooling

Install or verify Apple Command Line Tools or Xcode tooling before package-manager-dependent developer setup.

Source reference:

- Apple Developer: [Installing the command-line tools](https://developer.apple.com/documentation/xcode/installing-the-command-line-tools).

Suggested checks for the later manual walkthrough:

```bash
xcode-select -p
git --version
```

If Command Line Tools or Xcode tooling cannot be installed or verified, stop before Homebrew-dependent setup. Record the blocked state instead of continuing with package-manager assumptions.

Persistent state:

- What changes: Apple developer tooling may install Apple-owned command-line components and license prompts.
- Inspect: `xcode-select -p` and `git --version`.
- Reverse or troubleshoot: use Apple-supported tooling paths and documented Xcode or Command Line Tools maintenance, not Homebrew.

## Homebrew for third-party CLI tooling

Homebrew is the baseline default for third-party developer CLI tooling only. It is not the mechanism for Apple-owned system updates, FileVault, Privacy & Security settings, or Apple Account setup.

Before installing or changing Homebrew:

- Review the Homebrew install script from the official Homebrew site before running it.
- Understand the package-source trust assumption: Homebrew is a third-party package manager maintained outside Apple.
- On Apple silicon, the expected default prefix is `/opt/homebrew`.
- If Homebrew already exists with a non-default prefix, stop and troubleshoot before installing additional tools.
- Use `brew update` for Homebrew package metadata after Homebrew is installed.
- Use `brew doctor` as the health check before depending on the installation.
- Keep uninstall or rollback notes nearby. Use Homebrew's official uninstall guidance if removal is needed.

Source references:

- Homebrew Documentation: [Installation](https://docs.brew.sh/Installation).
- Homebrew install repository: [Homebrew/install](https://github.com/Homebrew/install).

Suggested checks for the later manual walkthrough:

```bash
brew --prefix
brew update
brew doctor
```

Persistent state:

- What changes: Homebrew creates and manages third-party CLI package state, normally under `/opt/homebrew` on Apple silicon.
- Inspect: `brew --prefix`, `brew config`, and `brew doctor`.
- Reverse or troubleshoot: follow Homebrew's uninstall or troubleshooting guidance; do not manually delete unknown package-manager state.

## Shell, Git, SSH, and editor baseline

Keep shell changes conservative. Explain zsh profile files, PATH changes, and Homebrew shell environment changes before editing startup files.

Shell boundary:

- `.zprofile` is commonly used for login-shell environment setup.
- `.zshrc` is commonly used for interactive-shell behavior.
- PATH changes affect which executable is found first.
- Homebrew shell environment setup should be inspectable before being added to a startup file.

Git identity readiness:

```bash
git config --global user.name
git config --global user.email
```

SSH key handling:

- Confirm whether a personal or organization-specific SSH policy applies before generating, importing, or uploading keys.
- Do not paste private keys, tokens, or credential material into shell history.
- Keep credential storage expectations explicit, such as when macOS Keychain or Git credential helpers are involved.

Minimal editor availability:

```bash
vi --version
code --version
```

Only a minimal editor launch or availability check belongs in this baseline. Full editor configuration is a follow-up module.

Persistent state:

- What changes: zsh startup files, PATH entries, Git global config, SSH key files, known hosts, and credential helper state may persist.
- Inspect: open the relevant startup file, run `echo "$PATH"`, inspect `git config --global --list`, and list SSH public keys.
- Reverse or troubleshoot: remove only the lines or keys you understand, and preserve a backup of edited shell files before changing them.

## Follow-up modules

Defer these topics to later modules:

- Managed or corporate Mac setup, including MDM, endpoint security, proxy, certificate trust, FileVault policy, and restricted administrator rights.
- Mac App Store automation and `mas`; defer Mac App Store automation to an optional-tools decision.
- Web development.
- Python.
- Containers.
- Cloud tooling.
- GUI app bundles.
- Full editor configuration.

Do not add hidden setup automation, one-command bootstrap behavior, generated dotfiles, or opaque dotfile installers to this baseline.
