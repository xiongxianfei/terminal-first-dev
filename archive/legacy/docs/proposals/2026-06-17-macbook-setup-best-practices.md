---
id: 2026-06-17-macbook-setup-best-practices
title: MacBook Setup Best Practices Direction
status: accepted
created: 2026-06-17
repo: xiongxianfei/terminal-first-windows-dev
proposal_path: docs/proposals/2026-06-17-macbook-setup-best-practices.md
related:
  - VISION.md
  - CONSTITUTION.md
---

# MacBook Setup Best Practices Direction

## Status

accepted

## Problem

The user asked for the best practices of setting up a MacBook. That is a useful workstation setup topic, but it sits outside the repository's current durable identity: a concise, terminal-first Windows 11 development setup guide.

Without a proposal-level decision, the project could drift in one of two bad directions. It could silently expand into a general cross-platform setup guide, weakening the focused Windows 11 value proposition. Or it could answer the MacBook question only in chat, losing the chance to preserve a reusable direction for future macOS setup work.

The project needs a decision on whether MacBook setup belongs here, and if so, what shape keeps it concise, auditable, terminal-first, and honest about platform-specific security, package-management, and machine-state assumptions.

## Goals

- Record a durable direction for MacBook setup best-practice guidance.
- Preserve the user's request for practical MacBook setup advice.
- Make the scope conflict with the current Windows 11 vision explicit.
- Favor a terminal-first developer workstation setup over a broad macOS productivity checklist.
- Prefer official Apple guidance for operating system update, backup, privacy, and FileVault security posture.
- Prefer auditable package-management guidance over opaque bootstrap automation.
- Call out assumptions around Apple Account use, administrator privileges, package sources, credentials, MDM or corporate policy, and machine-wide changes.
- Keep future setup guidance concise enough to be reviewable on a real MacBook.

## Non-goals

- Changing the repository vision as part of this draft proposal.
- Adding MacBook setup instructions, commands, scripts, Brewfiles, dotfiles, or automation in this proposal.
- Recommending enterprise fleet management, MDM baselines, compliance images, or locked-down corporate setup.
- Creating a general macOS productivity guide covering unrelated apps, window managers, media tools, or personal preferences.
- Replacing the existing Windows 11 setup direction.
- Claiming that any MacBook setup command has been tested locally.

## Vision fit

may conflict with the current vision

The current `VISION.md` defines this repository as a terminal-first Windows 11 development setup guide. A MacBook setup guide would broaden the project into a multi-platform workstation guide unless it is placed in a separate companion project or the vision is revised deliberately.

This proposal does not revise `VISION.md` by default. The resolved direction is to keep `terminal-first-windows-dev` Windows-first and create a separate macOS companion surface. If the owner later chooses to host macOS setup in this repository, that should be handled by a separate vision-revision proposal before adding macOS guides.

## Context

The repository is documentation-first and currently governs setup behavior through proposals, specs, architecture notes, plans, tests, reviews, and verification evidence. `CONSTITUTION.md` requires specs before changing setup behavior, command sequences, package-manager defaults, platform assumptions, security posture, or compatibility claims.

MacBook setup has similar risk categories to the current Windows guide:

- operating system updates and backup state before setup;
- security posture such as disk encryption, privacy permissions, firewall, SSH keys, credential storage, and recovery keys;
- package source trust, especially when using Homebrew or language-specific package managers;
- shell and terminal defaults;
- user-local configuration files and dotfiles;
- developer tools such as Git, editors, runtimes, SDKs, containers, and cloud CLIs;
- corporate policy or MDM conflicts;
- Apple silicon versus Intel compatibility differences.

Current primary-source checks support a conservative baseline:

- Apple documents Software Update as the supported path for macOS updates and recommends backing up before installing new software: <https://support.apple.com/en-us/108382>.
- Apple documents FileVault as an extra security layer even though Apple silicon and T2 Macs encrypt data automatically: <https://support.apple.com/guide/mac-help/protect-data-on-your-mac-with-filevault-mh11785/mac>.
- Apple documents Privacy & Security settings as the place to control what the Mac exposes to apps, the internet, and local networks: <https://support.apple.com/guide/mac-help/change-privacy-security-settings-on-mac-mchl211c911f/mac>.
- Homebrew's public installation page says its installer explains what it will do and pauses before making changes, and that Homebrew does not install files outside its prefix: <https://brew.sh/>.

Those sources support a best-practice direction that is explicit about trust and reversibility instead of presenting MacBook setup as a paste-and-run bootstrap.

## Options Considered

### Option A: Keep the repository Windows-only and answer MacBook setup outside the repo

Keep the current project vision unchanged. Treat MacBook setup as useful advice, but do not add durable macOS artifacts here.

Pros:

- Fully preserves the current Windows 11 focus.
- Avoids cross-platform scope creep.
- Requires no new specs, architecture notes, tests, or guide structure.

Cons:

- The user's MacBook setup request is not captured as reusable project knowledge.
- Future MacBook requests may repeat the same scope debate.
- The project misses an opportunity to reuse its strong setup-governance model on macOS.

### Option B: Add a small MacBook appendix to the existing Windows guide

Add a short macOS appendix or note inside the current guide, focused on high-level differences.

Pros:

- Low effort.
- Gives readers a quick comparison point.
- Avoids creating a full second guide track.

Cons:

- Conflicts with the current Windows 11 identity.
- Encourages platform drift inside Windows setup pages.
- Cannot cover security, package sources, shell configuration, and developer tooling well without becoming too large.
- Makes future validation harder because macOS setup cannot be checked on the same Windows-focused proof path.

### Option C: Revise the project into a cross-platform terminal-first workstation guide

Expand the vision to cover both Windows 11 and macOS as first-class workstation targets.

Pros:

- Directly captures the user's MacBook setup interest.
- Allows shared guide architecture, templates, safety patterns, and verification vocabulary.
- Could help developers who use both Windows and MacBook machines.

Cons:

- Major product-scope change.
- Risks becoming a broad operating-system setup catalog.
- Requires vision revision, downstream specs, likely architecture updates, and separate verification paths.
- Makes concise guidance harder to preserve.

### Option D: Create a separate macOS companion track or companion repo

Keep this repository Windows-first unless the owner revises the vision, but record a recommended MacBook setup model that could become a separate macOS companion guide.

Pros:

- Preserves the current repository identity.
- Keeps MacBook setup eligible for the same concise, auditable, terminal-first treatment.
- Lets macOS guidance have its own compatibility, security, package-source, and verification assumptions.
- Avoids mixing Windows and macOS commands in the same reader path.

Cons:

- Requires a product-surface decision before implementation.
- May create duplicated guide-template and workflow concepts.
- Cross-platform users may need two references instead of one.

## Recommended Direction

Choose Option D: create a separate macOS companion repository, recommended as `terminal-first-macos-dev`. Do not add MacBook setup guidance to `terminal-first-windows-dev` by default. If the owner later wants macOS setup inside this repository, revise `VISION.md` through a separate vision-revision proposal before adding macOS guides.

The recommended MacBook setup direction should be:

1. Start with system safety: identify the Mac model and ownership context, update macOS through Software Update, confirm backup posture, and make FileVault, recovery key, Apple Account, and administrator-account assumptions explicit.
2. Establish a terminal-first baseline: Terminal or a chosen terminal app, zsh defaults, shell profile boundaries, command-line tools, Git identity, SSH key handling, and credential-manager expectations.
3. Add package management deliberately: Homebrew as the default package-manager candidate, with source trust, prefix behavior, install-script review, update behavior, and uninstall or rollback notes visible near the command.
4. Install developer tooling by role: editor, language runtimes, version managers where justified, containers or virtualization only when needed, and cloud CLIs with credential storage called out.
5. Keep configuration auditable: prefer small user-local config snippets, document what each snippet changes, avoid hidden dotfile bootstrap unless a later spec and architecture note approve it.
6. Verify the setup with terminal checks: macOS version, Git, SSH, Homebrew health, editor launch, runtime versions, and any role-specific tool checks.
7. Treat corporate Macs separately: MDM, endpoint security, policy-managed FileVault, proxy, certificate trust, and restricted admin privileges should be clearly marked as policy-dependent rather than assumed.

The first macOS companion spec should cover a personal developer MacBook terminal baseline only. It should make the Mac safe, updated, backed up, terminal-ready, Git/SSH-ready, Homebrew-ready, and verifiable before adding role-specific stacks such as web development, Python, containers, cloud tooling, GUI app bundles, or full editor configuration.

This keeps the answer to "best practices" practical while respecting the current project's governance. It records what a strong MacBook setup guide would prioritize without prematurely adding macOS setup behavior to a Windows-first repository.

## Expected Behavior Changes

If this proposal is accepted and followed downstream:

- MacBook setup guidance is treated as a platform-specific companion surface, not a casual appendix.
- The current repository remains Windows-first unless a separate vision-revision proposal changes that direction.
- Future MacBook setup content starts from security, backup, package-source trust, and terminal-first developer workflow.
- The first macOS setup slice targets personal developer MacBooks and a general terminal baseline.
- Corporate-managed Macs remain a separate proposal or policy-dependent path.
- Any future macOS commands or setup defaults require a spec before implementation in the companion surface.

## Architecture Impact

This proposal has no runtime architecture impact by itself.

Potential downstream architecture impact depends on the selected product surface:

- A separate companion repo would reuse the same documentation-first workflow ideas without changing this repository's architecture.
- A macOS track inside this repository would require new guide boundaries, new specs, likely a project-map update, and separate verification evidence for macOS.
- Any executable macOS helper scripts, Brewfiles, generated dotfiles, or setup automation would require architecture documentation before implementation because they would affect package sources, shell behavior, credentials, filesystem locations, or machine state.

## Testing and Verification Strategy

This proposal is documentation-only. Verification for this artifact should check:

- the proposal includes the required sections;
- the proposal is consistent with `CONSTITUTION.md` and `VISION.md`;
- external source links point to primary sources for Apple and Homebrew claims;
- no setup commands are presented as tested or ready to run.

Future MacBook guide implementation should have a separate validation strategy, likely including Markdown checks, link checks, command review, and a documented manual walkthrough on a real macOS machine. Command success should not be claimed until those checks are run.

## Rollout and Rollback

Rollout starts with proposal review and an owner decision:

- accept a separate macOS companion surface;
- revise the current vision for cross-platform setup;
- reject macOS setup as out of scope for this repository; or
- keep the proposal as archived background.

Rollback is simple at this stage because no setup behavior changes. If the owner rejects the direction, mark this proposal `rejected` or `abandoned` and do not create downstream specs or guides. If a later proposal supersedes this one, record the replacement in this proposal's follow-on artifacts or status metadata.

## Risks and Mitigations

| Risk | Mitigation |
|---|---|
| Scope creep from Windows-only to broad workstation setup | Require an explicit vision decision before any macOS guide implementation. |
| MacBook guidance becomes a personal app checklist | Keep the direction terminal-first, developer-focused, and verification-oriented. |
| Security-sensitive steps are underspecified | Use Apple primary sources for update, backup, privacy, and FileVault guidance; require specs for commands and defaults. |
| Homebrew install guidance hides trust assumptions | Treat package-source trust and install-script review as visible setup concerns. |
| Corporate Mac users receive unsafe advice | Mark MDM, admin privileges, certificates, proxy, FileVault policy, and endpoint tools as policy-dependent. |
| Apple silicon and Intel differences are flattened | Include compatibility assumptions in any downstream spec or guide. |
| Commands are presented without evidence | Do not claim command success without manual walkthrough or automated checks. |

## Open Questions

None blocking for the first macOS companion spec after the resolved decisions below are recorded.

Resolved decisions:

- MacBook setup should live in a separate companion repository, recommended as `terminal-first-macos-dev`.
- The current repository should not add macOS guides unless a separate vision-revision proposal intentionally makes the project cross-platform.
- The first audience is a personal developer MacBook. Corporate-managed Macs are policy-dependent and should be handled by a separate proposal or clearly marked troubleshooting path.
- The first package-management default is Apple-supported system/update tooling for Apple-owned components plus Homebrew for third-party developer CLI tools. Defer Mac App Store automation and `mas`.
- The first developer stack is the general terminal baseline, with only a minimal editor availability check. Defer web, Python, containers, cloud tooling, and full editor configuration.
- Manual verification uses a real Apple silicon MacBook running the latest stable macOS offered by Software Update for that device. Record exact `sw_vers`, model, architecture, Command Line Tools state, Homebrew prefix, and verification date. Add Intel verification only if Intel support is claimed.

## Initial Intent Preservation

| Initial user goal | Proposal treatment | Where recorded |
|---|---|---|
| Identify best practices for setting up a MacBook | in scope | Recommended Direction |
| Preserve a durable proposal artifact because `$proposal` was invoked | in scope | Status, Decision Log, Next Artifacts |
| Fit the answer into the current repository | rejected option | Vision fit, Open Questions |

## Scope Budget

| Work item | Treatment | Reason |
|---|---|---|
| Product-surface decision for MacBook setup | core to this proposal | The current repository vision is Windows 11-specific. |
| MacBook best-practice direction | core to this proposal | This preserves the user's requested outcome without writing setup commands. |
| Vision revision | separate proposal | A cross-platform identity change needs its own explicit decision. |
| macOS setup spec | first-slice candidate | Needed before adding setup behavior, commands, defaults, or compatibility claims. |
| macOS architecture note | same-slice dependency | Required if future work adds scripts, Brewfiles, generated config, or automation. |
| MacBook setup guide implementation | separate implementation slice | Requires accepted direction, spec, and validation strategy first. |
| Enterprise or MDM setup | separate proposal | It has different policy, security, and validation assumptions. |

## Decision Log

| Date | Decision | Reason | Alternatives rejected |
|---|---|---|---|
| 2026-06-17 | Draft a MacBook setup best-practices proposal instead of adding guide content directly. | The request is valuable but conflicts with the current Windows 11 vision and would change setup scope if implemented. | Chat-only answer; silent appendix in the Windows guide. |
| 2026-06-17 | Recommend a separate macOS companion surface unless the owner explicitly revises the vision. | This preserves the current focused project while allowing MacBook guidance to be concise and auditable. | Immediate cross-platform expansion; mixing macOS commands into Windows guide pages. |
| 2026-06-17 | Keep MacBook setup out of `terminal-first-windows-dev` by default. | Preserves the current Windows-first identity while allowing reusable macOS guidance. | Chat-only guidance; appending macOS setup to Windows guide pages. |
| 2026-06-17 | Use a separate macOS companion repository, recommended as `terminal-first-macos-dev`. | Gives macOS its own compatibility, security, package-source, and verification assumptions. | Immediate cross-platform rewrite of the existing repo. |
| 2026-06-17 | Target personal developer MacBooks first. | Keeps the first slice practical and avoids unsafe assumptions about MDM, certificates, proxy, FileVault policy, and admin rights. | Treating corporate-managed Macs as the default path. |
| 2026-06-17 | Use Homebrew for third-party developer CLI tooling, not Apple-owned system setup. | Apple system updates and Apple developer tooling have their own supported paths; Homebrew is best suited for third-party terminal tools. | Homebrew-only for everything; Mac App Store automation in the first slice. |
| 2026-06-17 | Limit the first macOS setup slice to the terminal baseline. | Keeps the first spec reviewable and avoids becoming a broad language/runtime/container/cloud setup catalog. | Web/Python/container/cloud/editor-heavy first slice. |
| 2026-06-17 | Require real Apple silicon MacBook verification before command claims. | Prevents untested command contracts and gives contributors reproducible evidence. | Claiming compatibility from chat-only reasoning or unverified commands. |

## Next Artifacts

- macOS companion spec for the personal developer MacBook terminal baseline, if the owner accepts creating or using `terminal-first-macos-dev`.
- Separate vision-revision proposal before any macOS setup spec or guide content is added to `terminal-first-windows-dev`.
- Architecture note if downstream work introduces Brewfiles, scripts, generated shell configuration, or other machine-changing automation.

## Follow-on Artifacts

- Proposal review: `docs/changes/2026-06-17-macbook-setup-best-practices/reviews/proposal-review.md`
- Spec: `specs/macbook-setup-best-practices.md`

## Readiness

Approved as a direction after the resolved decisions are recorded.

Ready for a macOS companion spec if the owner accepts a separate companion repository. Not ready for implementation planning. If the owner instead wants macOS setup inside `terminal-first-windows-dev`, the next artifact should be a vision-revision proposal before any macOS setup spec or guide content is written.
