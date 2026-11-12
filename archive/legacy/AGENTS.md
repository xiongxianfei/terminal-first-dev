# Agent Guide

This repository is governed by `CONSTITUTION.md`. Read it before making behavior-changing edits.

## Operating Rules

- Keep the project aligned with `VISION.md`: concise, terminal-first Windows 11 development setup guidance.
- Preserve unrelated user changes and avoid broad rewrites.
- Use specs before changing setup behavior, executable scripts, command defaults, security posture, or compatibility assumptions.
- Use tests, dry-runs, linting, link checks, or documented manual walkthroughs as evidence before completion claims.
- Call out assumptions around Windows policy, administrator privileges, package sources, credentials, and machine-wide changes.
- Do not claim CI or setup commands passed unless the relevant check was actually run.

## Current Shape

The project is documentation-first. There are no established build, test, package, or CI commands yet. If a change introduces them, update the durable docs and report the new validation path.
