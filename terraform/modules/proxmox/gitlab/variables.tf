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
  default     = 1
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
  default = [
    {
      model    = "virtio"
      bridge   = "vmbr0"
      firewall = true
    }
  ]
}

variable "disks" {
  description = "Proxmox disk configuration. See telmate/proxmox documentation for details."
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
  default = [
    {
      type      = "scsi"
      storage   = "local-lvm"
      size      = "512G"
      io_thread = 1
      discard   = "on"
    }
  ]
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
  default     = 4096
}
