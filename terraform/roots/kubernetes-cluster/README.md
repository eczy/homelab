# Kubernetes Cluster

The following environment variables must be set:
- `PM_API_URL`
  - Full url to Proxmox API endpoint e.g. `https://pve.example.lan:8006/api2/json`
- `PM_API_TOKEN_ID`
  - Full Proxmox token ID with adequate permissions e.g. `terraform@pam!terraform0`
- `PM_API_TOKEN_SECRET`
  - Proxmox API token with adequate permissions

A template `.envrc` file has been provided at `.envrc.template`.

A template `.tfvars` file has also been provided at `variables.tfvars.template` with some values filled in for a minimal HA kubernetes cluster.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | >=0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_additional_control_plane_nodes"></a> [additional\_control\_plane\_nodes](#module\_additional\_control\_plane\_nodes) | ../../modules/proxmox/kubernetes/control-plane | n/a |
| <a name="module_first_control_plane_node"></a> [first\_control\_plane\_node](#module\_first\_control\_plane\_node) | ../../modules/proxmox/kubernetes/control-plane | n/a |
| <a name="module_worker_nodes"></a> [worker\_nodes](#module\_worker\_nodes) | ../../modules/proxmox/kubernetes/worker | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_clone_vm_name"></a> [clone\_vm\_name](#input\_clone\_vm\_name) | VM template from which nodes will be copied. | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the kubernetes cluster. Prefixes node names and control plane endpoint. | `string` | n/a | yes |
| <a name="input_control_plane_endpoint"></a> [control\_plane\_endpoint](#input\_control\_plane\_endpoint) | Must be an ip address of the form '<ip or dns name>:<port>'. | `string` | n/a | yes |
| <a name="input_control_plane_nodes"></a> [control\_plane\_nodes](#input\_control\_plane\_nodes) | Control plane node configuration. | <pre>object({<br>    count    = number<br>    cores    = number<br>    sockets  = number<br>    memory   = number<br>    bootdisk = string<br>    networks = list(object({<br>      model     = string<br>      macaddr   = optional(string)<br>      bridge    = optional(string)<br>      tag       = optional(number)<br>      firewall  = optional(bool)<br>      rate      = optional(number)<br>      queues    = optional(number)<br>      link_down = optional(bool)<br>    }))<br>    disks = list(object({<br>      type        = string<br>      storage     = string<br>      size        = string<br>      format      = optional(string)<br>      cache       = optional(string)<br>      backup      = optional(number)<br>      iothread    = optional(number)<br>      replicate   = optional(number)<br>      ssd         = optional(number)<br>      discard     = optional(string)<br>      mbps        = optional(number)<br>      mbps_rd     = optional(number)<br>      mbps_rd_max = optional(number)<br>      mbps_wr     = optional(number)<br>      mbps_wr_max = optional(number)<br>      media       = optional(string)<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_kube_proxy_arch"></a> [kube\_proxy\_arch](#input\_kube\_proxy\_arch) | kube-proxy architecture to pull. | `string` | `"amd64"` | no |
| <a name="input_kube_proxy_version"></a> [kube\_proxy\_version](#input\_kube\_proxy\_version) | kube-proxy version to pull. | `string` | `"1.23.4"` | no |
| <a name="input_kubeadm_cert"></a> [kubeadm\_cert](#input\_kubeadm\_cert) | Pregenerated cert used to join the cluster. | `string` | n/a | yes |
| <a name="input_kubeadm_token"></a> [kubeadm\_token](#input\_kubeadm\_token) | Pregenerated token used to join the cluster. | `string` | n/a | yes |
| <a name="input_pod_network_cidr"></a> [pod\_network\_cidr](#input\_pod\_network\_cidr) | Subnet for pods. | `string` | n/a | yes |
| <a name="input_private_key_file"></a> [private\_key\_file](#input\_private\_key\_file) | SSH private key of user used to provision node. | `string` | n/a | yes |
| <a name="input_proxmox_target_node"></a> [proxmox\_target\_node](#input\_proxmox\_target\_node) | The name of the Proxmox Node on which to place the cluster. | `string` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | Username used to provision node. | `string` | n/a | yes |
| <a name="input_worker_nodes"></a> [worker\_nodes](#input\_worker\_nodes) | Worker node configuration. | <pre>object({<br>    count    = number<br>    cores    = number<br>    sockets  = number<br>    memory   = number<br>    bootdisk = string<br>    networks = list(object({<br>      model     = string<br>      macaddr   = optional(string)<br>      bridge    = optional(string)<br>      tag       = optional(number)<br>      firewall  = optional(bool)<br>      rate      = optional(number)<br>      queues    = optional(number)<br>      link_down = optional(bool)<br>    }))<br>    disks = list(object({<br>      type        = string<br>      storage     = string<br>      size        = string<br>      format      = optional(string)<br>      cache       = optional(string)<br>      backup      = optional(number)<br>      iothread    = optional(number)<br>      replicate   = optional(number)<br>      ssd         = optional(number)<br>      discard     = optional(string)<br>      mbps        = optional(number)<br>      mbps_rd     = optional(number)<br>      mbps_rd_max = optional(number)<br>      mbps_wr     = optional(number)<br>      mbps_wr_max = optional(number)<br>      media       = optional(string)<br>    }))<br>  })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
