# proxmox
Since pi-hole runs in a VM within Proxmox, this must be run after the pi-hole root module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >=0 |
| <a name="requirement_pihole"></a> [pihole](#requirement\_pihole) | >=0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.63.0 |
| <a name="provider_pihole"></a> [pihole](#provider\_pihole) | 0.0.12 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_inventory"></a> [inventory](#module\_inventory) | ../../modules/ansible/inventory | n/a |

## Resources

| Name | Type |
|------|------|
| [google_service_account.restic](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_key.restic](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_key) | resource |
| [google_storage_bucket.proxmox_backup](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket_iam_member.proxmox_backup_object_admin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_member) | resource |
| [pihole_dns_record.gitea_record](https://registry.terraform.io/providers/ryanwholey/pihole/latest/docs/resources/dns_record) | resource |
| [google_project.backup](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_proxmox_domain"></a> [proxmox\_domain](#input\_proxmox\_domain) | CNAME to assign to proxmox in pi-hole dnsmasq. | `string` | n/a | yes |
| <a name="input_proxmox_ip"></a> [proxmox\_ip](#input\_proxmox\_ip) | IP to which proxmox CNAME will direct. | `string` | n/a | yes |
| <a name="input_proxmox_ssh_key"></a> [proxmox\_ssh\_key](#input\_proxmox\_ssh\_key) | RSA key pair used to access Proxmox via ssh. | `string` | n/a | yes |
| <a name="input_restic_backup_google_project_id"></a> [restic\_backup\_google\_project\_id](#input\_restic\_backup\_google\_project\_id) | GCP project id for backups. | `string` | n/a | yes |
| <a name="input_restic_backup_password_file"></a> [restic\_backup\_password\_file](#input\_restic\_backup\_password\_file) | File containing password used to encrypt restic backups. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
