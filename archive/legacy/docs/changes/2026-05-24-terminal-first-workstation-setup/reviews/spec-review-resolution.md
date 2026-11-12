# Spec Review Resolution: Terminal-First Workstation Setup

## SR-001 Disposition

Status: addressed

Resolution: R9 now defines the primary fresh-install custom-location command contract as `wsl --install --distribution <UbuntuLtsDistroName> --location "D:\Software\WSL\Ubuntu"`. R14 now requires publication-time validation against official Microsoft documentation and `wsl --help`. The blocking open question about `wsl --install Ubuntu --location ...` versus `wsl --install --distribution Ubuntu --location ...` has been removed and replaced with a resolved decision.

Owner decision needed: no

Follow-up: test-spec should add static and manual checks for the command contract before implementation relies on the spec.
