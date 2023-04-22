# proxmox/gitlab/omnibus
VM running

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
| [proxmox_vm_qemu.vm](https://registry.terraform.io/providers/telmate/proxmox/latest/docs/resources/vm_qemu) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agent"></a> [agent](#input\_agent) | Set to 1 to enable the QEMU Guest Agent. Note, you must run the qemu-guest-agent daemon in the guest for this to have any effect. | `number` | `0` | no |
| <a name="input_bootdisk"></a> [bootdisk](#input\_bootdisk) | Enable booting from specified disk. You shouldn't need to change it under most circumstances. | `string` | `null` | no |
| <a name="input_ciuser"></a> [ciuser](#input\_ciuser) | Override the default cloud-init user for provisioning. | `string` | n/a | yes |
| <a name="input_clone_vm_name"></a> [clone\_vm\_name](#input\_clone\_vm\_name) | VM template from which VM will be copied. | `string` | n/a | yes |
| <a name="input_cores"></a> [cores](#input\_cores) | The number of CPU cores per CPU socket to allocate to the VM. | `number` | `1` | no |
| <a name="input_description"></a> [description](#input\_description) | VM description to be displayed in Proxmox. | `string` | `null` | no |
| <a name="input_disks"></a> [disks](#input\_disks) | Proxmox disk configuration. See telmate/proxmox documentation for details. | <pre>list(object({<br>    type        = string<br>    storage     = string<br>    size        = string<br>    format      = optional(string, "raw")<br>    cache       = optional(string, "none")<br>    backup      = optional(bool, true)<br>    iothread    = optional(number)<br>    replicate   = optional(number)<br>    ssd         = optional(number)<br>    discard     = optional(string)<br>    mbps        = optional(number)<br>    mbps_rd     = optional(number)<br>    mbps_rd_max = optional(number)<br>    mbps_wr     = optional(number)<br>    mbps_wr_max = optional(number)<br>    media       = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_hotplug"></a> [hotplug](#input\_hotplug) | Comma delimited list of hotplug features to enable. Options: network, disk, cpu, memory, usb. Set to 0 to disable hotplug. | `string` | `"0"` | no |
| <a name="input_ipconfig"></a> [ipconfig](#input\_ipconfig) | IP address to assign to the guest. Format: [gw=<GatewayIPv4>] [,gw6=<GatewayIPv6>] [,ip=<IPv4Format/CIDR>] [,ip6=<IPv6Format/CIDR>]. | `string` | `null` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | The amount of memory to allocate to the VM in Megabytes. | `number` | `1024` | no |
| <a name="input_networks"></a> [networks](#input\_networks) | Proxmox network configuration. See telmate/proxmox documentation for details. | <pre>list(object({<br>    model     = string<br>    macaddr   = optional(string)<br>    bridge    = optional(string)<br>    tag       = optional(number)<br>    firewall  = optional(bool)<br>    rate      = optional(number)<br>    queues    = optional(number)<br>    link_down = optional(bool)<br>  }))</pre> | n/a | yes |
| <a name="input_proxmox_target_node"></a> [proxmox\_target\_node](#input\_proxmox\_target\_node) | The name of the Proxmox node on which to place the VM. | `string` | n/a | yes |
| <a name="input_sockets"></a> [sockets](#input\_sockets) | The number of CPU sockets to allocate to the VM. | `number` | `1` | no |
| <a name="input_sshkeys"></a> [sshkeys](#input\_sshkeys) | Newline delimited list of SSH public keys to add to authorized keys file for the cloud-init user. | `string` | n/a | yes |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | The name of the VM within Proxmox. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vm"></a> [vm](#output\_vm) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->