variable "iso_url" {
  description = "URL to image used to create base VM"
  type        = string
  default     = "https://cdimage.debian.org/mirror/cdimage/archive/11.5.0/amd64/iso-cd/debian-11.5.0-amd64-netinst.iso"
}

variable "iso_checksum" {
  description = "Checksum of the image specified in iso_url"
  type        = string
  default     = "6a6607a05d57b7c62558e9c462fe5c6c04b9cfad2ce160c3e9140aa4617ab73aff7f5f745dfe51bbbe7b33c9b0e219a022ad682d6c327de0e53e40f079abf66a"
}

variable "vm_name" {
  description = "Name of the virtual machine during creation. If not given, a random uuid will be used."
  type        = string
  default     = "debian-11-base"
}

variable "cloud_init_storage_pool" {
  description = "If true, add a Cloud-Init CDROM drive after the virtual machine has been converted to a template. Defaults to false."
  type        = string
  default     = "local"
}

variable "cores" {
  description = "How many CPU cores to give the virtual machine."
  type        = string
  default     = "1"
}

variable "sockets" {
  description = "How many CPU sockets to give the virtual machine."
  type        = string
  default     = "1"
}

variable "disk_format" {
  description = "The format of the file backing the disk. Can be raw, cow, qcow, qed, qcow2, vmdk or cloop. Defaults to raw."
  type        = string
  default     = "raw"
}

variable "disk_size" {
  description = "The size of the disk, including a unit suffix, such as 10G to indicate 10 gigabytes."
  type        = string
  default     = "4G"
}

variable "disk_storage_pool" {
  description = "Name of the Proxmox storage pool to store the virtual machine disk on. A local-lvm pool is allocated by the installer, for example."
  type        = string
  default     = "local-lvm"
}

variable "disk_storage_pool_type" {
  description = "The type of the pool, can be lvm, lvm-thin, zfspool, cephfs, rbd or directory."
  type        = string
  default     = "lvm"
}

variable "memory" {
  description = "How much memory, in megabytes, to give the virtual machine."
  type        = string
  default     = "512"
}

variable "network_vlan" {
  description = "If the adapter should tag packets."
  type        = string
  default     = ""
}

variable "proxmox_host" {
  description = "URL to the Proxmox API, including the full path, so https://<server>:<port>/api2/json for example. Can also be set via the PROXMOX_URL environment variable."
  type        = string
}

variable "proxmox_node" {
  description = "Which node in the Proxmox cluster to start the virtual machine on during creation."
  type        = string
}

variable "ssh_timeout" {
  description = "The time to wait for SSH to become available. Packer uses this to determine when the machine has booted so this is usually quite long. Example value: 10m."
  type        = string
  default     = "15m"
}

variable "iso_storage_pool" {
  description = "Proxmox storage pool onto which to upload the ISO file."
  type        = string
  default     = "local"
}
