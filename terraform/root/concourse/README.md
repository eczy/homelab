<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1 |
| <a name="requirement_pihole"></a> [pihole](#requirement\_pihole) | >=0 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | >=0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_inventory"></a> [inventory](#module\_inventory) | ../../modules/ansible/inventory | n/a |
| <a name="module_postgres"></a> [postgres](#module\_postgres) | ../../modules/proxmox/vm | n/a |
| <a name="module_web"></a> [web](#module\_web) | ../../modules/proxmox/vm | n/a |
| <a name="module_worker"></a> [worker](#module\_worker) | ../../modules/proxmox/vm | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_num_workers"></a> [num\_workers](#input\_num\_workers) | Number of worker nodes to provision. | `number` | `1` | no |
| <a name="input_postgres_ssh_key_path"></a> [postgres\_ssh\_key\_path](#input\_postgres\_ssh\_key\_path) | Path to RSA key pair used for Concourse database server. | `string` | n/a | yes |
| <a name="input_session_signing_key_path"></a> [session\_signing\_key\_path](#input\_session\_signing\_key\_path) | Path to session signing key used by the web node to verify user session tokens. | `string` | n/a | yes |
| <a name="input_tsa_host_key_path"></a> [tsa\_host\_key\_path](#input\_tsa\_host\_key\_path) | Path to RSA key pair used by the web node for ssh worker registration. | `string` | n/a | yes |
| <a name="input_web_ssh_key_path"></a> [web\_ssh\_key\_path](#input\_web\_ssh\_key\_path) | Path to RSA key pair used for Concourse web server. | `string` | n/a | yes |
| <a name="input_worker_key_path"></a> [worker\_key\_path](#input\_worker\_key\_path) | Path to RSA key pair used by worker node to verify its registration with the web node. | `string` | n/a | yes |
| <a name="input_worker_ssh_key_path"></a> [worker\_ssh\_key\_path](#input\_worker\_ssh\_key\_path) | Path to RSA key pair used for Concourse worker servers. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
