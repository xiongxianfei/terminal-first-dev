# Spec Review Resolution: How-To Guide Template Best Practices

## HGT-SR-001 - Backup guidance not testable for published file-editing guides

- Finding ID: HGT-SR-001
- Disposition: addressed
- Resolution summary: The spec now makes backup guidance a published-guide conformance requirement for user-owned file edits, system-owned file edits, and hard-to-undo persistent state changes. Backup guidance must appear before the edit or change in every path that instructs the reader to perform it, or the guide must explicitly state why backup is not applicable.
- Spec changes: backup guidance definition, R18, R35a, Error and boundary behavior, AC2, AC9, AC10, and test-spec readiness notes.
- Pilot change: `docs/guides/proxy-setup.md` fast path now includes a backup cue before the `%UserProfile%\.wslconfig` edit; walkthrough backup guidance remains in place.
- Owner decision needed: none.
- Required next review: none for HGT-SR-001; second-pass spec-review approved the disposition.
