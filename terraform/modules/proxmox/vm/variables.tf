variable "vm_name" {
  description = "The name of the VM within Proxmox."
  type        = string
}

variable "description" {
  description = "VM description to be displayed in Proxmox."
  type        = string
  default     = null
}

variable "proxmox_target_node" {
  description = "The name of the Proxmox node on which to place the VM."
  type        = string
}

variable "clone_vm_name" {
  description = "VM template from which VM will be copied."
  type        = string
}

variable "agent" {
  description = "Set to 1 to enable the QEMU Guest Agent. Note, you must run the qemu-guest-agent daemon in the guest for this to have any effect."
  type        = number
  default     = 0
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
  description = "Proxmox disk configuration. See telmate/proxmox documentation for details."
  type = list(object({
    type        = string
    storage     = string
    size        = string
    format      = optional(string, "raw")
    cache       = optional(string, "none")
    backup      = optional(bool, true)
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
  description = "Enable booting from specified disk. You shouldn't need to change it under most circumstances."
  type        = string
  default     = null
}

variable "cores" {
  description = "The number of CPU cores per CPU socket to allocate to the VM."
  type        = number
  default     = 1
}

variable "sockets" {
  description = "The number of CPU sockets to allocate to the VM."
  type        = number
  default     = 1
}

variable "memory" {
  description = "The amount of memory to allocate to the VM in Megabytes."
  type        = number
  default     = 1024
}

variable "ciuser" {
  description = "Override the default cloud-init user for provisioning."
  type        = string
}

variable "sshkeys" {
  description = "Newline delimited list of SSH public keys to add to authorized keys file for the cloud-init user."
  type        = string
}

variable "ipconfig" {
  description = "IP address to assign to the guest. Format: [gw=<GatewayIPv4>] [,gw6=<GatewayIPv6>] [,ip=<IPv4Format/CIDR>] [,ip6=<IPv6Format/CIDR>]."
  type        = string
}

