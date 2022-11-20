variable "vm_name" {
  description = "The name of the VM within Proxmox."
  type        = string
}

variable "proxmox_target_node" {
  description = "The name of the Proxmox Node on which to place the VM."
  type        = string
}

variable "clone_vm_name" {
  description = "VM template from which node will be copied."
  type        = string
}

variable "networks" {
  description = "Proxmox network configuration. See telmate/proxmox documentation for details."
  type = list(object({
    model     = string
    macaddr   = optional(string)
    bridge    = optional(string)
    tag       = optional(number)
    firewall  = optional(bool)
    rate      = optional(number)
    queues    = optional(number)
    link_down = optional(bool)
  }))
}

variable "disks" {
  type = list(object({
    type        = string
    storage     = string
    size        = string
    format      = optional(string)
    cache       = optional(string)
    backup      = optional(number)
    iothread    = optional(number)
    replicate   = optional(number)
    ssd         = optional(number)
    discard     = optional(string)
    mbps        = optional(number)
    mbps_rd     = optional(number)
    mbps_rd_max = optional(number)
    mbps_wr     = optional(number)
    mbps_wr_max = optional(number)
    media       = optional(string)
  }))
}

variable "bootdisk" {
  description = "Proxmox disk configuration. See telmate/proxmox documentation for details."
  type        = string
  default     = null
}

variable "cores" {
  description = "The number of CPU cores per CPU socket to allocate to the VM."
  type        = number
  default     = 2
}

variable "sockets" {
  description = "The number of CPU sockets to allocate to the VM."
  type        = number
  default     = 1
}

variable "memory" {
  description = "The amount of memory to allocate to the VM in Megabytes."
  type        = number
  default     = 2048
}

variable "username" {
  description = "Username used to provision node."
  type        = string
}

variable "private_key_file" {
  description = "SSH private key of user used to provision node."
  type        = string
}

variable "control_plane_endpoint" {
  description = "Must be of the form '<ip or dns name>:<port>'."
  type        = string
}

variable "kubeadm_token" {
  description = "Pregenerated token used to join the cluster."
  type        = string
  sensitive   = true
}

