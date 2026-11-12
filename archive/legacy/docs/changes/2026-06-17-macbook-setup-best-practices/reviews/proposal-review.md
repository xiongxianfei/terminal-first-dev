---
id: 2026-06-17-macbook-setup-best-practices-proposal-review
proposal: docs/proposals/2026-06-17-macbook-setup-best-practices.md
review_status: approved
created: 2026-06-17
repo: xiongxianfei/terminal-first-windows-dev
---

# Proposal Review: MacBook Setup Best Practices Direction

## Result

- Skill: proposal-review
- Review status: approved
- Material findings: none
- Recording status: recorded locally for review use; repository commit pending
- Recording blocker: none for local artifact generation
- Review record: `docs/changes/2026-06-17-macbook-setup-best-practices/reviews/proposal-review.md`
- Review log: not created in this local artifact because no implementation review was supplied
- Review resolution: not required; there are no material findings
- Open blockers: none after the resolved decisions below are recorded in the proposal
- Immediate next stage: revise the proposal to record decisions, then decide whether to author a macOS companion spec

## Review summary

The proposal is directionally sound. It correctly frames MacBook setup as useful but potentially out of scope for the current Windows-first repository. It gives a reasonable option set, avoids prematurely adding commands, and names the important macOS risks: backup, FileVault, privacy settings, package-source trust, credentials, MDM/corporate policy, Apple silicon versus Intel compatibility, and manual verification.

The recommended direction should remain a separate macOS companion surface, not a silent appendix inside `terminal-first-windows-dev` and not an immediate cross-platform rewrite of the current repository.

## Review dimensions

| Dimension | Verdict | Notes |
|---|---|---|
| Problem clarity | pass | The proposal states the actual problem: MacBook setup is valuable, but it conflicts with a Windows-first repo identity unless scoped deliberately. |
| User value | pass | It preserves reusable MacBook setup direction without turning the current repo into a general workstation catalog. |
| Option diversity | pass | The options cover chat-only, appendix, cross-platform expansion, and separate companion surface. |
| Decision rationale | pass | Option D follows from the stated goals: preserve focus while allowing future macOS work. |
| Scope control | pass | Non-goals prevent commands, Brewfiles, dotfiles, automation, enterprise MDM, and broad productivity-app scope in this proposal. |
| Architecture awareness | pass | The proposal correctly notes that scripts, Brewfiles, generated config, or automation would require downstream architecture work. |
| Testability | pass | It does not claim command success and requires later manual walkthrough evidence on a real Mac. |
| Risk honesty | pass | The risk table names scope creep, personal-app drift, Homebrew trust, corporate policy, Apple silicon/Intel differences, and unverified commands. |
| Rollout realism | pass | Rollout starts with an owner product-surface decision and does not imply implementation. |
| Readiness for spec | pass after decisions recorded | The proposal is ready for a macOS companion spec after the open questions are replaced by resolved decisions. |

## Resolved open questions

| Open question | Decision | Rationale |
|---|---|---|
| Should MacBook setup live in this repository, a separate companion repository, or chat-only guidance? | Use a separate companion repository. Recommended slug: `terminal-first-macos-dev`. | This keeps `terminal-first-windows-dev` focused while preserving a durable place for MacBook/macOS setup best practices. A separate repo also avoids mixing Windows and macOS commands in the same reader path. |
| If it lives here, should `VISION.md` become cross-platform or should macOS be scoped as a companion track? | It should not live here by default. If the owner later insists on one repo, revise `VISION.md` into an explicit cross-platform workstation vision before adding macOS guides. | A hidden companion track inside a Windows vision is too easy to misread. Cross-platform scope should be a deliberate vision change, not an incidental docs addition. |
| What MacBook audience is primary? | Personal developer MacBook first. Corporate-managed Mac is a separate proposal or clearly marked policy-dependent path. | MDM, endpoint security, FileVault policy, certificates, proxy, and restricted admin rights vary by organization and should not be implied as safe defaults. |
| Which package-management default should downstream guidance choose? | Use Apple-supported system paths for macOS updates and Apple developer tooling; use Homebrew as the default third-party developer CLI package manager; defer Mac App Store automation and `mas` to a later optional-tools decision. | This avoids treating Homebrew as responsible for Apple-owned system tooling, while still giving developers a practical, auditable package manager for terminal tools. Mac App Store automation adds Apple Account/session assumptions and is not necessary for the first setup slice. |
| Which developer stack should the first macOS setup slice cover? | General terminal baseline only, with a minimal editor availability check. Defer web development, Python, containers, cloud tooling, and full editor configuration to role-specific follow-ups. | A first slice should make the Mac safe, updated, backed up, terminal-ready, Git/SSH-ready, Homebrew-ready, and verifiable before adding role stacks. |
| What real macOS machine and version will be used for manual verification? | Primary verification should use one real Apple silicon MacBook running the latest stable macOS offered by Software Update for that device. Record exact `sw_vers`, hardware model, CPU architecture, Xcode Command Line Tools state, Homebrew prefix, and verification date. Add Intel verification only if the guide claims Intel support. | This gives the project a modern primary target without overstating compatibility. Intel behavior should not be claimed from an Apple silicon-only test. |

## Best-practice MacBook setup direction to carry into spec

A future macOS companion spec should cover this first slice:

1. Confirm ownership context: personal Mac versus managed/corporate Mac.
2. Identify hardware and CPU architecture: Apple silicon first; Intel only if explicitly supported.
3. Confirm backup posture before system updates or package-manager/bootstrap changes.
4. Update macOS through Software Update; avoid beta guidance in the default path.
5. Review FileVault, recovery-key handling, Apple Account, and administrator-account assumptions.
6. Review Privacy & Security settings at a high level, especially developer tools that request filesystem, network, or automation permissions.
7. Install or verify Apple Command Line Tools / Xcode tooling before package-manager-dependent setup.
8. Install Homebrew as the default third-party developer CLI package manager, using the default supported prefix for the architecture.
9. Configure shell boundaries conservatively: zsh profile files, PATH changes, Homebrew shell environment, and no opaque dotfile bootstrap in the first slice.
10. Configure Git identity and SSH key handling, including credential storage expectations.
11. Verify with terminal checks: `sw_vers`, architecture, Command Line Tools path, Git, SSH, Homebrew prefix, `brew doctor`, and editor launch.
12. Keep language runtimes, containers, cloud CLIs, GUI app bundles, and full Neovim configuration as follow-up modules.

## Suggested proposal edits

### 1. Update `Vision fit`

Replace:

```markdown
## Vision fit

proposes a vision revision
```

with:

```markdown
## Vision fit

may conflict with the current vision
```

Then add:

```markdown
This proposal does not revise `VISION.md` by default. The resolved direction is to keep `terminal-first-windows-dev` Windows-first and create a separate macOS companion surface. If the owner later chooses to host macOS setup in this repository, that should be handled by a separate vision-revision proposal before adding macOS guides.
```

### 2. Replace `Open Questions`

```markdown
## Open Questions

None blocking for the first macOS companion spec after the resolved decisions below are recorded.

Resolved decisions:

- MacBook setup should live in a separate companion repository, recommended as `terminal-first-macos-dev`.
- The current repository should not add macOS guides unless a separate vision-revision proposal intentionally makes the project cross-platform.
- The first audience is a personal developer MacBook. Corporate-managed Macs are policy-dependent and should be handled by a separate proposal or clearly marked troubleshooting path.
- The first package-management default is Apple-supported system/update tooling for Apple-owned components plus Homebrew for third-party developer CLI tools. Defer Mac App Store automation and `mas`.
- The first developer stack is the general terminal baseline, with only a minimal editor availability check. Defer web, Python, containers, cloud tooling, and full editor configuration.
- Manual verification uses a real Apple silicon MacBook running the latest stable macOS offered by Software Update for that device. Record exact `sw_vers`, model, architecture, Command Line Tools state, Homebrew prefix, and verification date. Add Intel verification only if Intel support is claimed.
```

### 3. Add decision-log rows

```markdown
| 2026-06-17 | Keep MacBook setup out of `terminal-first-windows-dev` by default | Preserves the current Windows-first identity while allowing reusable macOS guidance | Chat-only guidance; appending macOS setup to Windows guide pages |
| 2026-06-17 | Use a separate macOS companion repository, recommended as `terminal-first-macos-dev` | Gives macOS its own compatibility, security, package-source, and verification assumptions | Immediate cross-platform rewrite of the existing repo |
| 2026-06-17 | Target personal developer MacBooks first | Keeps the first slice practical and avoids unsafe assumptions about MDM, certificates, proxy, FileVault policy, and admin rights | Treating corporate-managed Macs as the default path |
| 2026-06-17 | Use Homebrew for third-party developer CLI tooling, not Apple-owned system setup | Apple system updates and Apple developer tooling have their own supported paths; Homebrew is best suited for third-party terminal tools | Homebrew-only for everything; Mac App Store automation in the first slice |
| 2026-06-17 | Limit the first macOS setup slice to the terminal baseline | Keeps the first spec reviewable and avoids becoming a broad language/runtime/container/cloud setup catalog | Web/Python/container/cloud/editor-heavy first slice |
| 2026-06-17 | Require real Apple silicon MacBook verification before command claims | Prevents untested command contracts and gives contributors reproducible evidence | Claiming compatibility from chat-only reasoning or unverified commands |
```

### 4. Update `Readiness`

```markdown
## Readiness

Approved as a direction after the resolved decisions are recorded.

Ready for a macOS companion spec if the owner accepts a separate companion repository. Not ready for implementation planning. If the owner instead wants macOS setup inside `terminal-first-windows-dev`, the next artifact should be a vision-revision proposal before any macOS setup spec or guide content is written.
```

## Recommendation

Approve the proposal direction after recording the resolved decisions above.

Do not proceed directly to implementation. The next useful artifact is a macOS companion spec covering the personal developer MacBook terminal baseline, with manual verification evidence on a real Apple silicon MacBook before command claims are published.
