<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1 |
| <a name="requirement_pihole"></a> [pihole](#requirement\_pihole) | >=0 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | >=0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_pihole"></a> [pihole](#provider\_pihole) | 0.0.12 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gitea"></a> [gitea](#module\_gitea) | ../../modules/proxmox/vm | n/a |
| <a name="module_inventory"></a> [inventory](#module\_inventory) | ../../modules/ansible/inventory | n/a |

## Resources

| Name | Type |
|------|------|
| [pihole_dns_record.gitea_record](https://registry.terraform.io/providers/ryanwholey/pihole/latest/docs/resources/dns_record) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_gitea_ssh_key"></a> [gitea\_ssh\_key](#input\_gitea\_ssh\_key) | RSA public key. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
