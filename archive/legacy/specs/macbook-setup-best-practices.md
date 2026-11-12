# MacBook Setup Best Practices

## Status

approved

## Related proposal

- Proposal: `docs/proposals/2026-06-17-macbook-setup-best-practices.md`
- Proposal review: `docs/changes/2026-06-17-macbook-setup-best-practices/reviews/proposal-review-r2.md`
- Intended product surface: separate macOS companion repository, recommended as `terminal-first-macos-dev`

## Goal and context

This spec defines the first-slice contract for a concise, terminal-first MacBook setup guide aimed at a personal developer MacBook.

The accepted proposal keeps `terminal-first-windows-dev` Windows-first. This spec therefore describes the behavior expected from the macOS companion surface, not a guide to be added to this repository by default. If macOS setup is later hosted inside this repository, a separate vision-revision proposal is required before guide implementation.

The first slice focuses on a safe, auditable terminal baseline: ownership context, hardware identification, backup posture, stable macOS update path, FileVault and privacy/security review, Apple developer tooling, Homebrew for third-party developer CLI tools, conservative shell boundaries, Git/SSH readiness, minimal editor availability, and manual verification evidence.

## Glossary

- Apple silicon: A Mac using Apple-designed ARM-based processors, reported by `uname -m` as `arm64`.
- Intel Mac: A Mac using an Intel processor, reported by `uname -m` as `x86_64`.
- Managed Mac: A Mac controlled by an organization through MDM, endpoint security, certificate policy, proxy policy, restricted administrator rights, or similar controls.
- Personal developer MacBook: A MacBook controlled by the developer, where the developer can make user-local setup choices and has administrator access unless noted otherwise.
- Apple-owned system tooling: macOS updates, Software Update, Xcode, Command Line Tools, Apple Account, FileVault, and system privacy/security controls.
- Third-party developer CLI tooling: Command-line tools not supplied as part of macOS or Apple developer tooling, commonly installed through Homebrew in this first slice.
- Terminal baseline: The setup state where the Mac is safe to use for command-line development, can install and verify third-party CLI tooling, and has Git/SSH/editor availability without role-specific runtime stacks.

## Examples first

Example E1: personal Apple silicon MacBook reaches the terminal baseline
Given a personal Apple silicon MacBook with administrator access
When the reader follows the companion guide's first-slice path
Then the guide records ownership context, backup posture, current stable macOS update status, FileVault review, Privacy & Security review, Command Line Tools state, Homebrew prefix, Git identity readiness, SSH key handling, minimal editor availability, and terminal verification results.

Example E2: corporate-managed MacBook is detected before setup changes
Given a MacBook where MDM, endpoint security, certificate policy, proxy policy, or restricted administrator rights apply
When the reader reaches ownership-context checks
Then the guide marks the default personal-Mac path as not directly applicable and routes the reader to policy-dependent notes or a future managed-Mac proposal before package-manager, shell, credential, or security-sensitive changes.

Example E3: Intel Mac compatibility is not claimed without verification
Given the guide has only been manually verified on an Apple silicon MacBook
When the guide describes compatibility
Then it states Apple silicon as the verified target and does not claim Intel support unless separate Intel verification evidence is recorded.

Example E4: Homebrew setup remains auditable
Given the reader is about to install or verify Homebrew
When the guide presents Homebrew setup
Then it identifies Homebrew as third-party CLI package management, separates it from Apple-owned system tooling, shows what trust assumptions apply, records the architecture-specific prefix expectation, and provides verification and rollback notes.

## Requirements

R1. The companion guide MUST identify the Mac ownership context before any setup step that changes package sources, shell configuration, credentials, privacy permissions, encryption state, or machine-wide settings.

R2. The companion guide MUST treat personal developer MacBooks as the first-slice default audience.

R3. The companion guide MUST NOT present corporate-managed Mac setup as the default path.

R4. The companion guide MUST identify hardware model and CPU architecture before compatibility-sensitive guidance.

R5. The companion guide MUST use Apple silicon as the primary verified target unless separate verification evidence proves another target.

R6. The companion guide MUST NOT claim Intel Mac support unless Intel-specific manual verification evidence is recorded.

R7. The companion guide MUST require backup posture confirmation before system updates, package-manager installation, shell profile edits, credential changes, or other persistent setup changes.

R8. The companion guide MUST use Apple's Software Update path for macOS updates in the default path.

R9. The companion guide MUST NOT recommend beta macOS releases in the default setup path.

R10. The companion guide MUST include FileVault review and recovery-key handling as visible setup concerns.

R11. The companion guide MUST include Apple Account and administrator-account assumptions before steps that depend on them.

R12. The companion guide MUST include a high-level Privacy & Security review for developer tools that request filesystem, network, automation, or local-network permissions.

R13. The companion guide MUST install or verify Apple Command Line Tools or Xcode tooling before package-manager-dependent developer setup.

R14. The companion guide MUST distinguish Apple-owned system tooling from third-party developer CLI tooling.

R15. The companion guide MUST use Homebrew as the first-slice default for third-party developer CLI package management.

R16. The companion guide MUST NOT use Homebrew as the mechanism for Apple-owned macOS updates or Apple system security settings.

R17. The companion guide MUST defer Mac App Store automation and `mas` to a later optional-tools decision.

R18. The companion guide MUST make Homebrew trust assumptions, install-script review expectations, default prefix expectations, update behavior, and uninstall or rollback notes visible near the Homebrew setup section.

R19. The companion guide MUST configure shell boundaries conservatively by explaining zsh profile files, PATH changes, and Homebrew shell environment changes before asking the reader to edit shell startup files.

R20. The companion guide MUST NOT include opaque dotfile bootstrap in the first slice.

R21. The companion guide MUST cover Git identity readiness and SSH key handling, including credential-storage expectations.

R22. The companion guide MUST include only a minimal editor availability check in the first slice.

R23. The companion guide MUST defer web development, Python, containers, cloud tooling, GUI app bundles, and full editor configuration to follow-up modules.

R24. The companion guide MUST include terminal verification checks for macOS version, CPU architecture, Command Line Tools path, Git availability, SSH readiness, Homebrew prefix, Homebrew health, and minimal editor launch.

R25. Manual verification evidence MUST record exact `sw_vers`, hardware model, CPU architecture, Command Line Tools state, Homebrew prefix, verification date, and whether the Mac was personal or managed.

R26. The companion guide MUST NOT claim command success, setup compatibility, or setup completion until the relevant manual walkthrough or documented check has been run.

R27. The companion guide SHOULD keep each setup step auditable by stating what persistent state changes and how to inspect or reverse them.

R28. The companion guide MUST route managed/corporate Mac concerns, including MDM, endpoint security, proxy, certificate trust, FileVault policy, and restricted admin privileges, to policy-dependent notes or a separate proposal.

R29. The companion guide MUST state that this first slice does not change the `terminal-first-windows-dev` repository vision or add macOS guides to that repository by default.

## Inputs and outputs

Inputs:

- Reader-provided ownership context: personal MacBook or managed/corporate Mac.
- Hardware and platform information from system inspection.
- Backup status as confirmed by the reader.
- macOS update status as reported by Software Update.
- FileVault, Apple Account, administrator-account, and Privacy & Security state as observed by the reader.
- Command Line Tools or Xcode tooling state.
- Homebrew install or verification state.
- Git identity and SSH key readiness.
- Minimal editor availability.

Outputs:

- A first-slice companion guide or guide contract for `terminal-first-macos-dev`.
- A documented terminal-baseline verification transcript or checklist.
- Clear compatibility statement naming verified hardware and macOS context.
- Visible safety, trust, rollback, and policy-dependent notes.
- Follow-up routes for managed Mac setup and role-specific developer stacks.

## State and invariants

- The default path remains documentation-first and auditable.
- The first slice remains personal-developer-MacBook-first.
- Apple-owned system updates and security settings remain separate from third-party package management.
- Homebrew is scoped to third-party developer CLI tooling.
- Setup guidance does not claim Intel compatibility without Intel verification evidence.
- Setup guidance does not claim managed/corporate Mac safety without policy-specific review.
- No first-slice step depends on hidden dotfile bootstrap or unattended setup automation.
- No macOS guide is added to `terminal-first-windows-dev` unless a later vision-revision proposal accepts that scope change.

## Error and boundary behavior

- If the Mac is managed or corporate-controlled, the guide MUST stop before policy-sensitive package-manager, credential, certificate, proxy, FileVault, or shell changes and route to policy-dependent guidance.
- If backup posture is unknown or missing, the guide MUST stop before persistent setup changes and instruct the reader to resolve backup status.
- If Software Update offers a beta release, the default path MUST avoid it and remain on stable macOS guidance.
- If administrator privileges are unavailable, the guide MUST identify which steps are blocked or require alternate policy-approved handling.
- If Command Line Tools or Xcode tooling cannot be installed or verified, the guide MUST stop before package-manager-dependent setup.
- If Homebrew prefix or health checks do not match the expected architecture context, the guide MUST stop and route to troubleshooting before installing additional tooling.
- If SSH key handling depends on organization-specific policy or credentials, the guide MUST avoid generic credential advice and route to policy-dependent guidance.
- If manual verification is incomplete, the guide MUST mark command success and compatibility claims as unverified.

## Compatibility and migration

- Primary compatibility target: one real Apple silicon MacBook running the latest stable macOS offered by Software Update for that device at verification time.
- Intel Mac compatibility is optional and unclaimed until separately verified.
- Managed/corporate Macs are out of the first-slice default path and require policy-dependent handling.
- Existing Windows setup guidance remains unchanged.
- Existing `terminal-first-windows-dev` readers should not see macOS guide content unless a later vision revision changes repository scope.
- Migration from chat-only MacBook advice to durable companion guidance happens through this spec, followed by spec review and downstream companion artifacts.
- Rollback for this spec is documentation rollback: archive or abandon the spec if the companion surface is rejected. No machine state changes are introduced by the spec itself.

## Observability

- The guide MUST include a verification checklist or transcript template.
- Verification evidence MUST include `sw_vers`, hardware model, CPU architecture, Command Line Tools state, Homebrew prefix, Homebrew health result, Git availability, SSH readiness result, minimal editor launch result, verification date, and verifier context.
- The guide SHOULD distinguish verified, manually checked, skipped, blocked, and policy-dependent steps.
- The guide MUST keep command-success claims tied to recorded verification evidence.

## Security and privacy

- The guide MUST identify when setup steps affect encryption, recovery keys, credentials, SSH keys, package sources, shell startup files, developer-tool permissions, network access, or automation permissions.
- The guide MUST NOT ask users to paste secrets, tokens, private keys, or credential material into shell history.
- The guide MUST describe Homebrew source-trust assumptions before install or verification steps that rely on it.
- The guide MUST treat FileVault recovery-key handling as sensitive and avoid publishing recovery keys, screenshots, or transcripts containing secrets.
- The guide MUST require terminal transcripts and examples to be scrubbed of personal machine names, usernames where unnecessary, private paths, tokens, keys, and organization identifiers before publication.

## Accessibility and UX

- The guide is text-first Markdown and MUST remain usable from a terminal or plain text renderer.
- Commands and expected results MUST identify the execution context, such as Terminal, zsh shell, System Settings, or browser-based Apple support flow.
- The guide MUST avoid hidden setup behavior and MUST place safety or stop conditions before the command or action that depends on them.
- The guide SHOULD keep the default path concise and move role-specific stacks to follow-up modules.

## Performance expectations

- Not applicable for runtime performance. The guide introduces no executable product behavior.
- Documentation checks SHOULD complete in a local contributor workflow without requiring a macOS machine unless they are manual verification checks.
- Manual verification duration SHOULD be recorded as observed evidence rather than asserted as a fixed guarantee.

## Edge cases

EC1. Apple silicon MacBook with no administrator access: the guide identifies blocked administrator-dependent steps and avoids workarounds that bypass policy.

EC2. Managed MacBook with corporate certificates or proxy: the guide stops before generic certificate, proxy, package-source, or credential changes.

EC3. Intel MacBook user reads the guide: the guide states Intel support is unverified unless Intel evidence exists.

EC4. Homebrew already installed with a non-default prefix: the guide requires inspection and troubleshooting before assuming the default architecture prefix.

EC5. Command Line Tools already installed: the guide verifies state instead of reinstalling blindly.

EC6. FileVault already enabled: the guide confirms recovery-key handling and does not ask the reader to rotate or expose keys by default.

EC7. Backup status cannot be confirmed: the guide stops before persistent changes.

EC8. User wants Python, containers, cloud CLIs, GUI apps, or full editor setup: the guide routes to follow-up modules and keeps the terminal baseline first.

EC9. Reader is on a macOS beta: the guide does not use beta behavior as the default contract.

EC10. Verification transcript contains private data: the guide requires scrubbing before publication.

## Non-goals

- Adding macOS guides to `terminal-first-windows-dev` by default.
- Revising `VISION.md` to make this repository cross-platform.
- Covering corporate-managed Mac setup as the default path.
- Covering MDM baselines, compliance images, endpoint-security policy, certificate deployment, or fleet automation.
- Covering web development, Python, containers, cloud tooling, GUI app bundles, Mac App Store automation, or full editor configuration in the first slice.
- Creating a one-command bootstrapper, Brewfile automation, generated dotfiles, or hidden dotfile installer in the first slice.
- Claiming command success or compatibility without real manual verification evidence.

## Acceptance criteria

AC1. A reviewer can trace every first-slice requirement to the accepted MacBook setup proposal and proposal review.

AC2. The spec contains stable requirement IDs for ownership context, hardware identification, backup, Software Update, FileVault, Privacy & Security, Command Line Tools, Homebrew, shell boundaries, Git/SSH, editor availability, verification, compatibility, and non-goals.

AC3. The spec clearly states that the first-slice default is a personal developer Apple silicon MacBook unless additional verification broadens compatibility.

AC4. The spec does not authorize macOS guide content inside `terminal-first-windows-dev` without a later vision-revision proposal.

AC5. The spec does not require or imply scripts, Brewfiles, generated config, or hidden automation.

AC6. The spec defines manual verification evidence required before command success or compatibility is claimed.

AC7. The spec routes managed/corporate Mac behavior out of the default path.

AC8. The spec is ready for `spec-review` with no known blocking open questions.

## Open questions

None blocking.

Non-blocking downstream questions:

- Where will `terminal-first-macos-dev` be initialized or linked?
- Which exact Markdown and link-check commands will the companion repo use?
- Which real Apple silicon MacBook will provide first manual verification evidence?
- Will Intel support be intentionally excluded or added after separate verification?

## Next artifacts

- Spec review for this spec.
- Architecture note if downstream work introduces Brewfiles, scripts, generated shell configuration, or other machine-changing automation.
- Test specification mapping requirements to static checks, link checks, command review, and manual walkthrough evidence.
- Companion guide implementation in `terminal-first-macos-dev` after required downstream artifacts exist.

## Follow-on artifacts

- Spec review: `docs/changes/2026-06-17-macbook-setup-best-practices/reviews/spec-review-r1.md`
- Plan: `docs/plans/2026-06-17-macbook-setup-best-practices.md`
- Test spec: `specs/macbook-setup-best-practices.test.md`

## Readiness

Ready for spec-review.
