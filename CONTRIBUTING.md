# Maintaining the Notes

## Where content belongs

Use `docs/windows/`, `docs/linux/`, and `docs/macos/` for platform-specific behavior, `docs/tools/` for shared tool knowledge, and `docs/networking/` for network topics. Put reusable files in `config/` and link to them.

Prefer one note per topic. A long topic may have separate task pages, such as WSL installation and migration; keep them together and linked. Add new notes to the root [topic index](README.md#topics). Keep platform-specific steps separate when commands or assumptions differ; do not label a configuration cross-platform without evidence.

## Small note format

Use the sections the topic actually needs:

```markdown
# Topic

Purpose and applicable platform/version.

## Steps
Commands, prerequisites, and nearby safety/backup notes.

## Verification
Expected results; tested platform/version/date, or explicitly not tested.

## Troubleshooting
Symptoms, checks, fixes, and rollback where relevant.
```

Existing longer guides may retain their fast path and walkthrough. Do not duplicate entire configuration files or invent test dates. Prefer official references for new technical claims.

## Checks

From the repository root, using Python 3.10+ and Bash (for example, in WSL):

```bash
python3 -m unittest discover -s tests -p 'test_*.py' -v
python3 tests/check_docs.py
for test in tests/markdown/*.test.sh; do
  bash "$test" || exit 1
done
```

The Python checker validates maintained Markdown titles, local file links, and heading anchors. Link parsing skips code examples; a separate check validates literal repository file paths used by `test -f`, `bash`, and `python3` commands, including examples. Shell checks cover Windows/WSL, Ubuntu safety guidance, Neovim/tmux configurations, and macOS prerequisites, setup order, and verification boundaries. They do not execute setup commands.

External URLs and historical records are not revalidated. These checks do not prove that Windows, WSL, macOS, package installation, networking, or editor startup works. Report any manual checks separately. The macOS record remains explicitly unverified until a real walkthrough is recorded.

## Changes

Use a focused pull request with the reason, changed topics, and actual check results. No separate specification or review-log hierarchy is required for ordinary notes. Historical records stay in Git history, not in active navigation or a restored archive directory.

When importing content, record the source repository, exact commit, path mapping, and license/attribution near the imported note. Adapt tests to the new paths and scope while retaining meaningful safety checks. See the [macOS import record](docs/macos/setup.md#traceability) for the current example.
