resource "pihole_dns_record" "gitea_record" {
  domain = var.proxmox_domain
  ip     = var.proxmox_ip
}

module "inventory" {
  source = "../../modules/ansible/inventory"

  groups = {
    proxmox = {
      hosts = {
        (var.proxmox_ip) = null
      }
    }
  }
  host_vars = {
    (var.proxmox_ip) = {
      ansible_ssh_private_key_file = var.proxmox_ssh_key

      pbs_storage_id  = "pbs"
      pbs_server      = var.pbs_server
      pbs_username    = var.pbs_username
      pbs_password    = var.pbs_password
      pbs_datastore   = var.pbs_datastore
      pbs_fingerprint = var.pbs_fingerprint # "18:c9:fb:62:a4:60:7f:6d:e5:c2:fc:66:fe:0c:12:07:ec:f3:ef:72:63:f9:f4:71:5d:1d:76:66:75:99:ef:2c"

      restic_repository          = "gs:${google_storage_bucket.proxmox_backup.name}:/proxmox"
      restic_repository_password = var.restic_repository_password
      restic_backup_dir          = "/var/lib/vz/dump"
    }
  }
}