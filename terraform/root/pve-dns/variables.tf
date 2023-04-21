variable "proxmox_domain" {
  description = "CNAME to assign to proxmox in pi-hole dnsmasq."
  type        = string
}

variable "proxmox_ip" {
  description = "IP to which proxmox CNAME will direct."
  type        = string
}