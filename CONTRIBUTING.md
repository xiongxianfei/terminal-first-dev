# Maintaining the Notes

## Where content belongs

Use `docs/windows/` and `docs/linux/` for platform-specific behavior, `docs/tools/` for shared tool knowledge, and `docs/networking/` for network topics. Create `docs/macos/` only with real content. Put reusable files in `config/` and link to them.

Prefer one note per topic. A long topic may have separate task pages, such as WSL installation and migration; keep them together and linked. Add new notes to the root [topic index](README.md#topics).

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

The Python checker validates maintained Markdown titles, local file links, and heading anchors, including the archive index. Link parsing skips code examples; a separate check validates literal repository file paths used by `test -f`, `bash`, and `python3` commands, including examples. The retained shell checks cover Windows/WSL, Ubuntu safety guidance, and Neovim/tmux configurations; they do not execute setup commands.

External URLs and frozen records under `archive/legacy/` are not revalidated. These checks do not prove that Windows, WSL, package installation, networking, or editor startup works. Report any manual checks separately.

## Changes

Use a focused pull request with the reason, changed topics, and actual check results. No separate specification or review-log hierarchy is required for ordinary notes. Keep historical records in [the archive](archive/README.md), not in the active navigation.
