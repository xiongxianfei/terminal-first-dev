---
id: 2026-06-16-remaining-guides-template-rollout
title: Apply the How-To Guide Template to Remaining First-Slice Guides
status: accepted
created: 2026-06-16
repo: xiongxianfei/terminal-first-windows-dev
proposal_path: docs/proposals/2026-06-16-remaining-guides-template-rollout.md
related:
  - docs/proposals/2026-06-07-guides-two-speed-how-to-structure.md
  - docs/proposals/2026-06-15-how-to-guide-template-best-practices.md
  - specs/guides-two-speed-how-to-structure.md
  - specs/how-to-guide-template-best-practices.md
  - docs/templates/how-to-guide.md
---

# Apply the How-To Guide Template to Remaining First-Slice Guides

## Status

accepted

## Problem

The project now has an accepted two-speed guide structure, an approved how-to guide template spec, a canonical template at `docs/templates/how-to-guide.md`, a reference exemplar in `docs/guides/proxy-setup.md`, and a portability pilot in `docs/guides/03-ubuntu-baseline.md`.

That settles the authoring contract, but the rest of the first-slice guides still mostly use the older shape:

- `docs/guides/01-windows-host.md`
- `docs/guides/02-wsl2-ubuntu.md`
- `docs/guides/04-neovim.md`
- `docs/guides/05-tmux.md`
- `docs/guides/06-uv.md`
- `docs/guides/99-verification.md`
- `docs/guides/README.md`

Those guides already contain useful setup content, safety notes, verification commands, and rollback sections. The problem is structural drift, not missing intent. Readers who open those guides do not yet get the settled visible metadata block, fast path, walkthrough, per-step expected results, explicit backup placement, and failure-point troubleshooting links consistently.

The next decision is how to continue guide conversion without accidentally reopening settled command contracts or turning a documentation-shape rollout into a broad rewrite of Windows, WSL, Neovim, tmux, uv, or verification behavior.

The rollout also has a sequencing problem. `02-wsl2-ubuntu.md` is high risk because it includes fresh WSL install, custom location behavior, migration, export, unregister warnings, and import-in-place recovery. `04-neovim.md`, `05-tmux.md`, and `06-uv.md` are smaller but still touch user-owned configuration and package sources. `99-verification.md` is partly a guide and partly a proof surface. Treating all of these as identical conversion tasks would hide real risk.

## Goals

- Continue the accepted guide-template work across the remaining first-slice guides.
- Preserve approved setup behavior and command semantics while changing guide structure.
- Convert guides toward the visible metadata, `Fast path`, `Walkthrough`, expected-result, backup, rollback, and troubleshooting-link contract.
- Sequence conversion by risk and dependency rather than converting every guide in one large rewrite.
- Keep existing numbered guide paths usable during migration.
- Keep the router useful while both numbered compatibility paths and task-scoped guide targets coexist.
- Identify where guide splitting or renaming is a separate migration decision instead of forcing it into the first conversion slice.
- Strengthen static documentation checks only around stable structure and links, not command execution.
- Maintain the documentation-first posture and avoid introducing scripts, generated docs, or one-command setup automation.

## Non-goals

- Changing the underlying PowerShell, WSL, Ubuntu, Neovim, tmux, uv, sudoers, fstab, package-source, or proxy command contracts.
- Executing guide command blocks in CI.
- Creating a generated documentation site, wizard, scaffold command, or installer.
- Removing numbered guide paths without a compatibility route.
- Completing every task-scoped filename rename in the same slice as body conformance.
- Creating deep troubleshooting content inside guide pages.
- Expanding guides into tutorials for beginners.
- Replacing `proxy-setup.md` or `03-ubuntu-baseline.md` as the settled exemplar and portability pilot for the template itself.
- Rewriting unrelated README, vision, constitution, or release policy content.

## Vision fit

fits the current vision

This proposal fits the current vision because it keeps the repository concise, auditable, terminal-first, and documentation-first. It makes existing setup guidance quicker to use without hiding machine-changing steps behind automation.

The proposal is a continuation of the accepted guide-structure and guide-template direction. It does not broaden the project into a general Windows productivity guide, a Linux migration manual, or a dotfiles distribution.

## Context

The accepted two-speed guide proposal established that `docs/guides/` should contain task-oriented how-to documents with a fast path, walkthrough, inline troubleshooting links, and a router-style index. It also records the migration direction toward stable, descriptive, lowercase, hyphenated task-scoped filenames.

The accepted template proposal and approved spec narrowed that direction into a contributor-facing contract at `docs/templates/how-to-guide.md`. It also corrected a validation circularity: `proxy-setup.md` is the reference exemplar because the template was partly shaped from it, while `03-ubuntu-baseline.md` is the portability pilot.

The merged implementation already converted or checked:

- `docs/templates/how-to-guide.md` as the canonical template;
- `docs/guides/proxy-setup.md` as the demanding reference exemplar;
- `docs/guides/03-ubuntu-baseline.md` as a non-exemplar portability pilot;
- `tests/markdown/how-to-guide-template-best-practices.test.sh` for template and pilot structure.

The remaining guide set is not uniform:

- `01-windows-host.md` covers Windows Terminal, PowerShell, WinGet, WSL availability, and optional PowerShell profile behavior.
- `02-wsl2-ubuntu.md` covers WSL fresh install, custom location, migration/import, export verification, and destructive unregister warnings.
- `04-neovim.md` covers Windows and Ubuntu installs, shared config strategy, plugin baseline, fallback tarball install, and user-local config rollback.
- `05-tmux.md` covers Ubuntu-only tmux install, config placement, manual key checks, and rollback.
- `06-uv.md` covers optional uv install, update, index configuration, and credential-sensitive package-source examples.
- `99-verification.md` consolidates proof commands, result vocabulary, publication gates, static checks, and rollback coverage.
- `docs/guides/README.md` already acts as a migration-aware router, but it still points to old numbered compatibility paths for most tasks.

Because these guides are machine-sensitive, the rollout should preserve command contracts from `specs/terminal-first-workstation-setup.md` and only change structure unless a later accepted spec authorizes behavior changes.

## Options Considered

### Option A: Convert all remaining guides in one broad rewrite

Rewrite every remaining guide to the new template shape in one implementation slice, update the router, and add or adjust static checks at the same time.

Pros:

- Fastest path to a visually consistent guide set.
- Reduces the period where old and new guide shapes coexist.
- Lets reviewers see the final intended documentation experience in one diff.

Cons:

- Large diff makes command-contract drift harder to detect.
- High-risk WSL migration content would be reviewed alongside lower-risk tmux and uv formatting changes.
- Router, body structure, troubleshooting links, and static checks could all fail at once.
- More likely to produce broad prose rewrites instead of structural conversion.

### Option B: Convert only the simplest guides first

Start with `05-tmux.md` and `06-uv.md`, then convert Neovim, Windows host, WSL, and verification later.

Pros:

- Low-risk way to practice the template on smaller guides.
- Keeps early diffs readable.
- Quickly improves two focused task guides.

Cons:

- Delays the highest-value and riskiest guide conversions.
- Does not exercise Windows host or WSL migration behavior soon enough.
- May optimize the rollout around easy guides rather than the guides that most need safety, backup, and rollback clarity.

### Option C: Convert the highest-risk guide first

Convert `02-wsl2-ubuntu.md` before the smaller guides because it has the most severe state-changing behavior and the greatest need for explicit backup, scope, safety, verification, and rollback.

Pros:

- Addresses the biggest user-risk surface first.
- Forces the template to handle complex alternative paths.
- Improves reviewability for WSL custom-location and migration guidance.

Cons:

- High effort and high review risk as the first post-template conversion.
- Could stall broader migration if WSL splitting or filename migration questions dominate.
- May require more detailed spec and review work before any visible rollout progress.

### Option D: Risk-tiered rollout with compatibility paths

Convert the remaining guides in small reviewed slices, ordered by risk and dependency. Preserve current numbered paths during body conformance, update the router as each guide changes, and defer final unnumbered filename migration until the content shape is stable.

Recommended initial order:

1. `05-tmux.md`, `04-neovim.md`, and `06-uv.md` as smaller tool guides that exercise user-owned config, optional tooling, and package-source safety.
2. `01-windows-host.md` as the Windows host guide that exercises PowerShell, WinGet, Windows Terminal, and enterprise-policy notes.
3. `02-wsl2-ubuntu.md` as the high-risk WSL install and migration guide, potentially split by path only if review shows the single guide cannot stay skimmable.
4. `99-verification.md` and `docs/guides/README.md` as the final proof and routing surfaces after the converted guides settle.

Pros:

- Keeps diffs reviewable.
- Converts lower-risk guides before the highest-risk WSL guide without ignoring the WSL guide.
- Preserves existing links while guide bodies converge on the template.
- Lets static checks expand incrementally.
- Keeps filename migration as a deliberate compatibility step instead of incidental churn.

Cons:

- Old and new guide shapes coexist for longer.
- Reviewers must track migration state across several slices.
- Some numbered paths remain temporarily even though the target guide architecture prefers unnumbered task-scoped names.

### Option E: Rename and split guides before body conversion

Create the final task-scoped filename set first, such as `windows-terminal-setup.md`, `powershell-setup.md`, `wsl-ubuntu-setup.md`, `neovim-setup.md`, `tmux-setup.md`, `verification.md`, and `fresh-setup.md`, then move content into those files.

Pros:

- Aligns quickly with the accepted task-scoped naming direction.
- Makes the router point at final names sooner.
- Forces guide boundaries to be resolved early.

Cons:

- Mixes content conversion with link migration and compatibility handling.
- Increases risk of broken bookmarks or duplicate guidance.
- Can distract from the more urgent need to make the existing guide bodies safer and quicker to use.
- Requires stronger migration and redirect-stub decisions before the body shape is proven across all topics.

## Recommended Direction

Choose Option D: risk-tiered rollout with compatibility paths.

The project should continue guide-template work by converting remaining first-slice guide bodies in small slices while preserving existing numbered paths. The initial conversion work should focus on structure, not command semantics. If a command appears wrong, outdated, unsafe, or underspecified during conversion, record it as a separate spec or follow-up unless the correction is a narrow documentation bug that does not change setup behavior.

The rollout should treat current numbered guide files as compatibility paths during the first body-conformance slices. This is a temporary migration posture. It avoids link churn while reviewers check whether each guide now provides:

- visible prerequisites, time, outcome, and verification;
- a short fast path;
- a walkthrough with the same high-level step order;
- explicit Windows PowerShell, Ubuntu, Neovim, tmux, or config-file context;
- expected results near meaningful commands;
- backup guidance before user-owned or system-owned file edits;
- rollback for persistent changes;
- inline troubleshooting links where stable anchors exist.

The first implementation slice should convert smaller tool guides before the WSL migration guide:

```text
docs/guides/05-tmux.md
docs/guides/04-neovim.md
docs/guides/06-uv.md
```

That slice is useful because it exercises user-owned config files, package installation, optional tooling, and command context without immediately taking on WSL unregister/import behavior. The next slices should convert Windows host, WSL2 Ubuntu, and verification in that order unless proposal review identifies a better sequence.

The final filename migration should be a later compatibility slice. It can create unnumbered task-scoped guide paths, preserve old numbered paths as stubs or router links, and introduce `fresh-setup.md` only after the converted guide bodies are stable enough to route through.

The WSL guide is the exception where splitting may happen during body conformance, because fresh install and migration are materially different safety paths. This exception does not authorize broad filename migration for the rest of the guide set.

## Expected Behavior Changes

After downstream implementation:

- More guides start with reader-visible prerequisites, time, outcome, and verification.
- Experienced readers can use fast paths without reading walkthrough prose.
- Newer readers can use walkthroughs with the same high-level task flow and more context.
- Guides state where each command or snippet runs.
- User-owned and system-owned file edits have backup guidance before the edit or a specific not-applicable reason.
- Persistent machine-changing guides expose rollback guidance earlier and more consistently.
- The router reflects which guides have been converted and which remain compatibility paths.
- Static checks cover converted guide structure and troubleshooting links without executing setup commands.

## Architecture Impact

This proposal affects documentation architecture, not runtime architecture.

Expected repository surfaces:

```text
docs/guides/01-windows-host.md       # future body-conformance slice
docs/guides/02-wsl2-ubuntu.md        # future high-risk body-conformance slice
docs/guides/04-neovim.md             # first-slice candidate
docs/guides/05-tmux.md               # first-slice candidate
docs/guides/06-uv.md                 # first-slice candidate
docs/guides/99-verification.md       # final proof-surface conversion
docs/guides/README.md                # migration-aware router updates
docs/troubleshooting/*.md            # linked recovery targets, reused where anchors exist
tests/markdown/*.sh                  # static guide structure and link checks
specs/*                              # downstream rollout requirements and checks
```

Boundary rules:

- The template remains the contributor-facing authoring contract.
- Guides remain reader-facing task instructions.
- Troubleshooting remains the owner of deep recovery.
- Existing setup specs continue to govern command semantics.
- Static checks prove structure and links, not machine setup correctness.
- Filename migration remains separate from body conformance unless a downstream spec explicitly combines them.

## Testing and Verification Strategy

The downstream spec and test spec should define layered validation:

- Static checks for converted guides: visible metadata, `Fast path`, `Walkthrough`, expected result text, rollback where relevant, and absence of contributor placeholders.
- Link checks for troubleshooting files and anchors referenced by converted guides.
- Review checklist checks for fast path and walkthrough parity.
- Review checklist checks for backup guidance before user-owned or system-owned file edits.
- Manual or dry-run command review for high-risk guide conversions, especially WSL migration and package-source guidance.
- No setup-command execution in CI during this rollout unless a later accepted artifact defines command contracts and runner assumptions.

Pilot evidence from the prior template work should remain relevant but not sufficient. Each newly converted guide should receive its own conversion evidence because guide-specific safety and command-context risks differ.

## Rollout and Rollback

Rollout:

- Add this proposal under `docs/proposals/`.
- Review the proposal before drafting the rollout spec.
- Write a downstream spec that identifies the conversion order, conformance rules for already-published guides, compatibility-path policy, and validation checks.
- Write a test spec before changing guide bodies.
- Convert the first smaller-guide slice: `05-tmux.md`, `04-neovim.md`, and `06-uv.md`.
- Update `docs/guides/README.md` only as needed to reflect converted guide status.
- Convert `01-windows-host.md`.
- Convert or split `02-wsl2-ubuntu.md` after the smaller slices prove the pattern.
- Convert `99-verification.md` and final router behavior after the setup guides stabilize.
- Decide final unnumbered filename migration in a later compatibility slice.

Rollback:

- If a conversion makes a guide less usable, restore that guide's previous body while preserving the accepted template and already-converted guides.
- If static checks produce false positives, narrow them to converted guides and keep broader checks advisory until guide migration completes.
- If a numbered compatibility path causes confusion, update the router to label migration state more clearly before renaming files.
- If the WSL guide cannot stay readable as one file, stop that slice and write a focused split proposal or spec amendment.

## Risks and Mitigations

| Risk | Impact | Mitigation |
| --- | --- | --- |
| Conversion changes command semantics | Readers may run behavior that was not approved by the setup spec | Treat command-contract changes as out of scope and route real command defects to a separate spec or bugfix |
| Large guide diffs hide safety regressions | Review may miss missing backup, rollback, or warnings | Use small slices and require guide-specific review evidence |
| Numbered compatibility paths linger too long | The guide set remains partly inconsistent with the task-scoped filename direction | Track filename migration as a follow-on compatibility slice |
| Fast paths become too long | Experienced readers lose the quick-configuration benefit | Keep context in walkthroughs and review fast-path skimmability |
| WSL guide complexity blocks rollout | The highest-risk guide may stall all other improvements | Convert smaller guides first and allow WSL split decisions to be made separately |
| Troubleshooting anchors are missing | Guides may contain weak failure routing | Link only to stable anchors and record missing troubleshooting entries as follow-ups |
| Backup guidance appears only in walkthroughs | Fast-path users may edit files without preserving state | Apply the accepted backup-before-edit rule to every path that tells readers to edit |
| Verification guide becomes a reference dump | Readers may not know the minimum checks to run | Convert verification as a proof task with a fast path and keep detailed matrix content in the walkthrough |
| uv package-index examples imply unsafe credential handling | Users may paste private indexes or secrets into docs or shell history | Keep examples credential-free and warn against private hostnames, tokens, and committed secrets |
| Static checks overreach | Documentation checks may block useful edits for template nuance | Start with stable section/link checks and leave judgment-heavy checks to review |

## Open Questions

None blocking proposal review or spec authoring.

Resolved decisions to carry into the spec:

- `02-wsl2-ubuntu.md` should split during its WSL conversion into task-scoped fresh-install and migration guides, while the numbered file remains as a short compatibility router/stub.
- `01-windows-host.md` should remain one guide during body conformance; any Windows Terminal / PowerShell split is deferred to the later filename-migration slice.
- `06-uv.md` should remain under `docs/guides/` for the first rollout and be labeled optional; a separate optional-tools area is a follow-up only if optional guides grow.
- Final filename migration should use short redirect-style stubs for old numbered paths plus router updates. Full duplicate retained files and router-only compatibility are rejected.

## Decision Log

| Date | Decision | Reason | Alternatives rejected |
| --- | --- | --- | --- |
| 2026-06-16 | Continue guide-template work as a new rollout proposal | The template contract is accepted, but most first-slice guides still use the older shape | Treating the merged template proposal as sufficient for broad migration |
| 2026-06-16 | Preserve numbered paths during body conformance | Existing links remain usable while guide bodies are converted and reviewed | Immediate rename and split of all guides |
| 2026-06-16 | Recommend risk-tiered rollout | Small reviewed slices reduce command-drift and safety-regression risk | One broad rewrite of all remaining guides |
| 2026-06-16 | Convert smaller tool guides before WSL migration | tmux, Neovim, and uv exercise important template behavior with lower destructive risk | Starting with the high-risk WSL migration guide |
| 2026-06-16 | Defer command-execution CI | Existing accepted specs already keep first-slice validation static and review-based until runner assumptions are defined | Executing setup commands in CI during this rollout |
| 2026-06-16 | Defer final unnumbered filename migration | Filename compatibility is separate from body readability and safety | Combining rename, split, router, and body conversion in one slice |
| 2026-06-16 | Split WSL install and migration during the WSL conversion slice | Fresh install and migration have different starting states, destructive risks, rollback, and verification needs | One large `02-wsl2-ubuntu.md` with multiple long paths |
| 2026-06-16 | Keep `01-windows-host.md` unified during body conformance | Windows Terminal, PowerShell, WinGet, and WSL availability form one host-baseline task | Splitting Windows Terminal and PowerShell during the body-conformance slice |
| 2026-06-16 | Keep `06-uv.md` under `docs/guides/` as an optional guide | It remains a setup how-to; optional-tools taxonomy is not needed until optional guide count grows | Moving it before a broader optional-tools taxonomy exists |
| 2026-06-16 | Use short redirect-style stubs for numbered path compatibility | Direct links stay useful without duplicating commands or preserving stale content | Router-only notes; full duplicated retained numbered guides |

## Initial Intent Preservation

| Initial user goal | Proposal treatment | Where recorded |
| --- | --- | --- |
| Continue work for other guides after the template PR merged | in scope | Problem, Goals, Recommended Direction |
| Use the proposal workflow stage instead of jumping directly to implementation | in scope | Status, Next Artifacts, Readiness |
| Apply the accepted guide-template direction beyond the exemplar and pilot | in scope | Context, Expected Behavior Changes |
| Preserve quick configuration and safety for machine-changing guides | in scope | Goals, Recommended Direction, Risks and Mitigations |
| Avoid broad behavior changes while restructuring docs | in scope | Non-goals, Architecture Impact, Decision Log |

## Scope Budget

| Work item | Treatment | Reason |
| --- | --- | --- |
| Remaining guide rollout direction | core to this proposal | This proposal chooses how to continue guide-template work across other guides |
| Conversion order | core to this proposal | Sequencing affects review risk and user safety |
| Smaller tool guide conversion | first-slice candidate | tmux, Neovim, and uv are useful lower-risk conversions that still exercise important template rules |
| Windows host guide conversion | separate implementation slice | It has Windows policy and package-source concerns and should be reviewed separately |
| WSL2 Ubuntu guide conversion | separate implementation slice | It contains destructive migration behavior and may need split decisions |
| Verification guide conversion | separate implementation slice | It depends on the final shape of converted setup guides |
| Router updates | same-slice dependency | The router should reflect conversion state without becoming a separate content rewrite |
| Final unnumbered filename migration | deferable follow-up | Compatibility and rename strategy should follow stable body conformance |
| New troubleshooting entries | deferable follow-up | Missing anchors should be tracked without inventing recovery content inside guides |
| Command-contract fixes | separate proposal | Behavior changes need their own spec or bugfix path |
| Command-execution CI | deferable follow-up | Runner assumptions and command specs are not settled |
| Generated guide tooling | out of scope | The project remains plain Markdown and documentation-first |

## Next Artifacts

- `docs/changes/2026-06-16-remaining-guides-template-rollout/reviews/proposal-review.md` for proposal review.
- `specs/remaining-guides-template-rollout.md` for conversion order, conformance rules, compatibility policy, and validation scope after proposal review.
- `specs/remaining-guides-template-rollout.test.md` for structure, link, backup, and review-check coverage after spec review.
- `docs/plans/2026-06-16-remaining-guides-template-rollout.md` for implementation slices after test-spec approval.
- Static test updates under `tests/markdown/` for converted-guide checks after the test spec is approved.
- Converted guide slices for `05-tmux.md`, `04-neovim.md`, and `06-uv.md` as the first implementation candidate.

## Follow-on Artifacts

- `specs/remaining-guides-template-rollout.md`

## Readiness

Approved for spec after the resolved decisions above are recorded in this proposal.

Ready for `specs/remaining-guides-template-rollout.md` once the governing how-to template spec's backup-before-edit requirement is resolved or explicitly carried as a prerequisite.

Not ready for planning or implementation until the rollout spec and test spec are reviewed.
