# Proxy Pilot Review: Two-Speed How-To Guide Structure

## Status

M2 pilot evidence recorded for code-review handoff.

## Guide under review

`docs/guides/proxy-setup.md`

## Review method

Manual document walkthrough. The commands were reviewed against the existing workstation setup spec and the current Ubuntu baseline guide, but they were not executed against a live Windows + WSL + enterprise proxy environment during this implementation pass.

## Documented starting state

- WSL2 Ubuntu is installed.
- Windows proxy or VPN policy is already configured.
- The reader can edit `%UserProfile%\.wslconfig` for the current Windows user.
- The reader has a policy-approved HTTPS endpoint for verification when GitHub is blocked.
- No proxy credentials, private hostnames, tokens, or certificate material are committed to the repository.

## Fast-path walkthrough result

- Completion result: completable from the documented prerequisites as a reader walkthrough.
- Approximate completion time: ~10 minutes.
- Walkthrough text needed: no. The fast path contains the state-changing edit, WSL restart, verification command, expected results, and failure-point links.
- Command execution status: not executed in this environment.

## Safety and verification context

- Step 1 includes the scope warning for `%UserProfile%\.wslconfig`.
- Step 1 records the expected file content.
- Step 2 records the expected WSL restart behavior.
- Step 3 records an HTTPS verification command and allows a policy-approved endpoint when GitHub is blocked.
- The guide links likely failures to proxy troubleshooting anchors instead of embedding deep recovery instructions.

## Missing context

None identified for the M2 pilot. Real environment validation is still expected to vary by WSL version, VPN, enterprise policy, PAC handling, and certificate trust configuration.

## Advisory command review

- `.wslconfig` command semantics match `docs/guides/03-ubuntu-baseline.md`.
- Automatic proxy mirroring remains the primary path.
- Manual proxy environment variables remain fallback guidance.
- PAC files and corporate CA handling remain troubleshooting-only and are not implemented by the guide.
- No setup command blocks are executed by CI in this slice.
