variable "cluster_name" {
  description = "Name of the kubernetes cluster. Prefixes node names and control plane endpoint."
  type        = string
}

variable "proxmox_target_node" {
  description = "The name of the Proxmox Node on which to place the cluster."
  type        = string
}

variable "control_plane_nodes" {
  description = "Control plane node configuration."
  type = object({
    count         = number
    clone_vm_name = string
    cores         = number
    sockets       = number
    memory        = number
    bootdisk      = string
    networks = list(object({
      model     = string
      macaddr   = optional(string)
      bridge    = optional(string)
      tag       = optional(number)
      firewall  = optional(bool)
      rate      = optional(number)
      queues    = optional(number)
      link_down = optional(bool)
    }))
    disks = list(object({
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
  })
}

variable "worker_nodes" {
  description = "Worker node configuration."
  type = object({
    count         = number
    clone_vm_name = string
    cores         = number
    sockets       = number
    memory        = number
    bootdisk      = string
    networks = list(object({
      model     = string
      macaddr   = optional(string)
      bridge    = optional(string)
      tag       = optional(number)
      firewall  = optional(bool)
      rate      = optional(number)
      queues    = optional(number)
      link_down = optional(bool)
    }))
    disks = list(object({
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
  })
}

variable "nfs_servers" {
  description = "Worker node configuration."
  type = object({
    count         = number
    clone_vm_name = string
    cores         = number
    sockets       = number
    memory        = number
    bootdisk      = string
    networks = list(object({
      model     = string
      macaddr   = optional(string)
      bridge    = optional(string)
      tag       = optional(number)
      firewall  = optional(bool)
      rate      = optional(number)
      queues    = optional(number)
      link_down = optional(bool)
    }))
    disks = list(object({
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
  })
}

variable "control_plane_endpoint" {
  description = "Must be an ip address of the form '<ip or dns name>:<port>'."
  type        = string
}

variable "pod_network_cidr" {
  description = "Subnet for pods."
  type        = string
}

variable "kubeadm_token" {
  description = "Pregenerated token used to join the cluster."
  type        = string
  sensitive   = true
}

variable "kubeadm_cert" {
  description = "Pregenerated cert used to join the cluster."
  type        = string
  sensitive   = true
}

variable "kube_proxy_arch" {
  description = "kube-proxy architecture to pull."
  type        = string
  default     = "amd64"
}

variable "kube_proxy_version" {
  description = "kube-proxy version to pull."
  type        = string
  default     = "1.23.4"
}

variable "username" {
  description = "Username used to provision node."
  type        = string
}

variable "private_key_file" {
  description = "SSH private key of user used to provision node."
  type        = string
}
