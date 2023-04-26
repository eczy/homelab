resource "pihole_dns_record" "gitea_record" {
  domain = var.proxmox_domain
  ip     = var.proxmox_ip
}

data "google_project" "backup" {
  project_id = var.restic_backup_google_project_id
}

resource "google_storage_bucket" "proxmox_backup" {
  name     = "eczy-proxmox-backup"
  location = "US-CENTRAL1"

  project                  = data.google_project.backup.project_id
  public_access_prevention = "enforced"

  lifecycle_rule {
    condition {
      age = 5
    }
    action {
      type = "Delete"
    }
  }
}

resource "google_service_account" "restic" {
  account_id   = "restic"
  display_name = "Restic"
  project      = data.google_project.backup.project_id
}

# TODO: better solution; at least regular rotation
resource "google_service_account_key" "restic" {
  service_account_id = google_service_account.restic.name
}

resource "google_storage_bucket_iam_member" "proxmox_backup_object_admin" {
  bucket = google_storage_bucket.proxmox_backup.name
  role   = "roles/storage.objectAdmin"
  member = google_service_account.restic.member
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
      ansible_ssh_private_key_file          = var.proxmox_ssh_key
      restic_repository                     = "gs:${google_storage_bucket.proxmox_backup.name}:/proxmox"
      restic_repository_password_file       = "./restic-pw"
      restic_google_project_id              = data.google_project.backup.number
      restic_google_application_credentials = google_service_account_key.restic.private_key
      restic_backup_dir                     = "/var/lib/vz/dump"
    }
  }
}