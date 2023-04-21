resource "pihole_dns_record" "gitea_record" {
  domain = var.proxmox_domain
  ip     = var.proxmox_ip
}