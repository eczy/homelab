# pve-dns
This simple root module is required since we run pi-hole in a Proxmox VM. This simply assigns a CNAME for the Proxmox IP in the pi-hole DNS.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1 |
| <a name="requirement_pihole"></a> [pihole](#requirement\_pihole) | >=0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_pihole"></a> [pihole](#provider\_pihole) | 0.0.12 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [pihole_dns_record.gitea_record](https://registry.terraform.io/providers/ryanwholey/pihole/latest/docs/resources/dns_record) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_proxmox_domain"></a> [proxmox\_domain](#input\_proxmox\_domain) | CNAME to assign to proxmox in pi-hole dnsmasq. | `string` | n/a | yes |
| <a name="input_proxmox_ip"></a> [proxmox\_ip](#input\_proxmox\_ip) | IP to which proxmox CNAME will direct. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
