<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >=0 |
| <a name="requirement_pihole"></a> [pihole](#requirement\_pihole) | >=0 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | >=0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.54.0 |
| <a name="provider_pihole"></a> [pihole](#provider\_pihole) | 0.0.12 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gitea"></a> [gitea](#module\_gitea) | ../../modules/proxmox/vm | n/a |
| <a name="module_inventory"></a> [inventory](#module\_inventory) | ../../modules/ansible/inventory | n/a |

## Resources

| Name | Type |
|------|------|
| [google_service_account.gitea_backup](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_key.gitea_backup](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_key) | resource |
| [google_storage_bucket.bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket_iam_member.gitea_backup_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_member) | resource |
| [pihole_dns_record.gitea_record](https://registry.terraform.io/providers/ryanwholey/pihole/latest/docs/resources/dns_record) | resource |
| [google_project.gitea_backup](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
