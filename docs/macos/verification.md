# MacBook Terminal Baseline Verification

## Status

No command-success or compatibility claims are verified yet.

This file is the manual verification template for a future walkthrough on a real Apple silicon MacBook running the latest stable macOS offered by Software Update for that device. Do not record secrets, private keys, recovery keys, tokens, private machine names, organization identifiers, or unnecessary private paths.

Use the [MacBook setup guide](setup.md) for prerequisites and safety gates. See its [import record](setup.md#traceability) for the original source and license. Static repository tests are not evidence that macOS setup succeeded.

## Required evidence fields

Record these fields before marking any setup claim as verified:

- Verification date:
- Verifier context:
- Ownership context: personal or managed
- macOS version from `sw_vers`:
- Hardware model:
- CPU architecture:
- Command Line Tools state:
- Homebrew prefix:
- Homebrew health result:
- Git availability:
- SSH readiness result:
- Minimal editor launch result:
- Skipped, blocked, or policy-dependent steps:
- Transcript scrubbed for sensitive data:

## Manual walkthrough record

Use one row per check. Keep status values explicit: `verified`, `manually checked`, `skipped`, `blocked`, or `policy-dependent`.

| Check | Status | Evidence or notes |
| --- | --- | --- |
| Ownership context is personal or managed |  |  |
| Latest stable macOS offered by Software Update is identified |  |  |
| `sw_vers` recorded |  |  |
| Hardware model recorded |  |  |
| CPU architecture recorded |  |  |
| Command Line Tools state recorded |  |  |
| Homebrew prefix recorded |  |  |
| Homebrew health result recorded |  |  |
| Git availability recorded |  |  |
| SSH readiness result recorded |  |  |
| Minimal editor launch result recorded |  |  |
| Skipped, blocked, or policy-dependent steps recorded |  |  |
| Transcript scrubbed for sensitive data |  |  |

## Verification checklist

Run or record the equivalent evidence during the future manual walkthrough:

```bash
sw_vers
system_profiler SPHardwareDataType
uname -m
xcode-select -p
git --version
brew --prefix
brew doctor
ssh -T git@github.com
vi --version
code --version
```

If a check is skipped, blocked, or policy-dependent, record that status instead of converting it into a verified claim.

## Transcript scrubbing

Before committing any transcript, remove or redact:

- Tokens.
- Private keys.
- Recovery keys.
- Private machine names.
- Usernames where unnecessary.
- Organization identifiers.
- Private paths.
- Certificate, proxy, or credential material.

## Claim boundary

Until this template is completed on a real Apple silicon MacBook, the [setup guide](setup.md) must keep command-success, setup-completion, and compatibility language unverified.

Verified wording must link back to exact recorded evidence in this file. If evidence is missing, incomplete, skipped, blocked, policy-dependent, or from a managed Mac, keep claims limited to that recorded context.
