# ADR: WSL Certificate Trust Policy

## Status

accepted

## Context

WSL Ubuntu can fail HTTPS requests even when the same endpoint works from Windows. Common symptoms include `SSL certificate problem`, `unable to get local issuer certificate`, and failures from `apt`, `curl`, `git`, language package managers, or Neovim plugin installation.

This often happens on managed Windows 11 workstations where enterprise proxy, VPN, or TLS inspection policy installs trusted root or intermediate certificates into the Windows certificate store, while Ubuntu inside WSL has a separate CA trust store.

The project needs a documented recovery path, but certificate trust changes are security-sensitive and environment-specific.

## Decision

Keep Windows-to-WSL certificate trust repair as manual troubleshooting, not automatic setup.

When WSL needs Windows-managed trust roots, the documented approach is:

1. export public certificate data from Windows PowerShell;
2. write exported certificates into a dedicated local export directory outside the repository;
3. copy PEM files into WSL and convert or rename them to `.crt`;
4. install them into a dedicated Ubuntu CA subdirectory;
5. run `sudo update-ca-certificates`;
6. verify with the failing HTTPS tools;
7. keep rollback explicit.

The certificate export design MUST follow these principles:

- export public certificate data only; do not export private keys;
- prefer the smallest required trust change, such as a known enterprise root or intermediate certificate, before importing every Windows certificate;
- use a dedicated export directory outside the repository;
- recursively scan `Cert:\` only after filtering to real `X509Certificate2` objects;
- name files safely using sanitized subject text plus thumbprint;
- deduplicate certificates by thumbprint;
- install WSL certificates under a project-specific CA directory such as `/usr/local/share/ca-certificates/win11`;
- never commit exported certificate material;
- verify the tools that originally failed;
- provide rollback that removes the project-specific CA directory and refreshes Ubuntu CA state.

## Alternatives Considered

- Do nothing: simpler, but leaves users blocked when WSL cannot trust corporate TLS inspection roots.
- Automatically import Windows certificates into WSL during baseline setup: convenient, but too broad and security-sensitive for a public first-slice guide.
- Import every Windows certificate by default: maximizes compatibility, but expands Ubuntu trust more than necessary and can copy stale or irrelevant trust roots.
- Document only proxy environment variables: helps network routing, but does not solve TLS trust failures.

## Consequences

- Troubleshooting remains explicit and reviewable.
- Users in corporate environments have a recovery path without making broad certificate import part of the happy path.
- The guide must warn that importing all Windows certificates broadly extends Ubuntu's trust store.
- The guide must keep exported certificate files out of the repository.
- Future helpers, if added, must be opt-in, inspectable, and limited to public certificate data.

## Follow-up

- Keep `docs/troubleshooting/proxy.md` aligned with this ADR.
- If certificate handling becomes common enough to automate, write a separate proposal/spec before adding scripts.
