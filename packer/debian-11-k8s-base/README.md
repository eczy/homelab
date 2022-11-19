## Required Packer Variables
The following variables are required to be defined either via environment variable prefixed with `PKR_VAR_` or via `.pkrvars.hcl` file passed to the `packer build` command.

- `ci_pubkey`
- `proxmox_node`
- `proxmox_host` (can also be assigned with `PROXMOX_URL` environment variable)
- `proxmox_username` (can also be assigned with `PROXMOX_USERNAME`)
- `proxmox_token` (can also be assigned with `PROXMOX_TOKEN`)

