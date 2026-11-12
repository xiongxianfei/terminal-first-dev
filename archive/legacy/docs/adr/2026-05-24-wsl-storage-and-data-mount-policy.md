# ADR: WSL Storage and Data Mount Policy

## Status

accepted

## Context

The workstation setup needs WSL2 Ubuntu storage on `D:` while keeping shared Windows/Linux data distinct from Linux project code.

## Decision

Store the Ubuntu WSL distro under `D:\Software\WSL\Ubuntu`. Support both fresh install with WSL's install-location option and migration with export/import-in-place. Expose `D:\Data` inside Ubuntu at `/home/<user>/data`. Recommend Linux-heavy project code in the WSL filesystem, for example `~/src`.

Disable automatic Windows drive mounts in `/etc/wsl.conf` and use fstab for the documented data path. If direct subdirectory mounting is unreliable, use the documented fallback that mounts `D:` and symlinks `/home/<user>/data` to the `Data` directory.

## Alternatives Considered

- Keep distro data on the default C-drive location: simpler, but conflicts with owner direction and can fill the system drive.
- Put all project code under `D:\Data`: convenient for sharing, but slower and less reliable for Linux-heavy tooling.
- Support arbitrary storage roots: flexible, but too broad for the first slice.

## Consequences

- WSL relocation and fresh install need preflight checks and rollback guidance.
- `wsl --unregister` must be guarded by backup/export verification.
- Data mount behavior needs architecture and test-spec coverage.

## Follow-up

Architecture and test-spec must define non-destructive checks for registered distro location and data mount verification.
