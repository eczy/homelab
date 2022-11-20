<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | >=0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | >=0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [proxmox_vm_qemu.node](https://registry.terraform.io/providers/telmate/proxmox/latest/docs/resources/vm_qemu) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bootdisk"></a> [bootdisk](#input\_bootdisk) | Proxmox disk configuration. See telmate/proxmox documentation for details. | `string` | `null` | no |
| <a name="input_clone_vm_name"></a> [clone\_vm\_name](#input\_clone\_vm\_name) | VM template from which node will be copied. | `string` | n/a | yes |
| <a name="input_control_plane_endpoint"></a> [control\_plane\_endpoint](#input\_control\_plane\_endpoint) | Must be of the form '<ip or dns name>:<port>'. | `string` | n/a | yes |
| <a name="input_cores"></a> [cores](#input\_cores) | The number of CPU cores per CPU socket to allocate to the VM. | `number` | `2` | no |
| <a name="input_disks"></a> [disks](#input\_disks) | n/a | <pre>list(object({<br>    type        = string<br>    storage     = string<br>    size        = string<br>    format      = optional(string)<br>    cache       = optional(string)<br>    backup      = optional(number)<br>    iothread    = optional(number)<br>    replicate   = optional(number)<br>    ssd         = optional(number)<br>    discard     = optional(string)<br>    mbps        = optional(number)<br>    mbps_rd     = optional(number)<br>    mbps_rd_max = optional(number)<br>    mbps_wr     = optional(number)<br>    mbps_wr_max = optional(number)<br>    media       = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_kubeadm_token"></a> [kubeadm\_token](#input\_kubeadm\_token) | Pregenerated token used to join the cluster. | `string` | n/a | yes |
| <a name="input_memory"></a> [memory](#input\_memory) | The amount of memory to allocate to the VM in Megabytes. | `number` | `2048` | no |
| <a name="input_networks"></a> [networks](#input\_networks) | Proxmox network configuration. See telmate/proxmox documentation for details. | <pre>list(object({<br>    model     = string<br>    macaddr   = optional(string)<br>    bridge    = optional(string)<br>    tag       = optional(number)<br>    firewall  = optional(bool)<br>    rate      = optional(number)<br>    queues    = optional(number)<br>    link_down = optional(bool)<br>  }))</pre> | n/a | yes |
| <a name="input_private_key_file"></a> [private\_key\_file](#input\_private\_key\_file) | SSH private key of user used to provision node. | `string` | n/a | yes |
| <a name="input_proxmox_target_node"></a> [proxmox\_target\_node](#input\_proxmox\_target\_node) | The name of the Proxmox Node on which to place the VM. | `string` | n/a | yes |
| <a name="input_sockets"></a> [sockets](#input\_sockets) | The number of CPU sockets to allocate to the VM. | `number` | `1` | no |
| <a name="input_username"></a> [username](#input\_username) | Username used to provision node. | `string` | n/a | yes |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | The name of the VM within Proxmox. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->