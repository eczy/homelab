<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [local_sensitive_file.group_vars](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |
| [local_sensitive_file.host_vars](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |
| [local_sensitive_file.inventory](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_group_vars"></a> [group\_vars](#input\_group\_vars) | Group vars. Each top level map key is assumed to be the name of a group and will result in a distinct file. | `any` | `{}` | no |
| <a name="input_groups"></a> [groups](#input\_groups) | Groups of hosts. | `any` | n/a | yes |
| <a name="input_host_vars"></a> [host\_vars](#input\_host\_vars) | Host vars. Each top level map key is assumed to be the name of a host and will result in a distinct file. | `any` | `{}` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
