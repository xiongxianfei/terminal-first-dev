# Agent Guide

This is a personal development knowledge base, organized by platform and tool. The [README](README.md) is the current scope and navigation; [CONTRIBUTING](CONTRIBUTING.md) describes editing and checks.

- Keep changes small. Prefer an existing topic over a new folder or duplicate note.
- Keep reusable configurations in `config/`; do not change their behavior during a documentation-only reorganization.
- Keep platform assumptions explicit. WSL-specific settings are not generic Linux defaults. Imported macOS notes and existing shared configurations are not evidence of tested macOS compatibility.
- Keep elevation, destructive actions, trust changes, and machine-wide effects visible beside the relevant commands. Preserve prerequisites, backups, verification, and rollback guidance.
- Never commit secrets, credentials, private machine identifiers, or exported certificate material.
- Record meaningful behavior changes and validation in the pull request. Notes do not require separate proposals, specifications, architecture documents, or review logs.
- Run the documented checks and inspect the diff. Distinguish static documentation checks from actual Windows/WSL/macOS execution; never invent test results.
- Preserve source attribution and pinned provenance links for imported notes. Historical records in Git history are not active governing rules; do not restore removed archive files or rewrite their claims as current guidance.
