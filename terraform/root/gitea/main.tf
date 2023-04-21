locals {
  gitea_url = "gitea.home.lan"
}

data "google_project" "gitea_backup" {
  project_id = "eczy-gitea-backup"
}

resource "pihole_dns_record" "gitea_record" {
  domain = local.gitea_url
  ip     = module.gitea.vm.default_ipv4_address
}

resource "google_service_account" "gitea_backup" {
  account_id   = "gitea-backup"
  display_name = "gitea Backup"
  project      = data.google_project.gitea_backup.project_id
}

resource "google_service_account_key" "gitea_backup" {
  service_account_id = google_service_account.gitea_backup.id
}

resource "google_storage_bucket" "bucket" {
  name     = "eczy-gitea-backup"
  location = "US"
  project  = data.google_project.gitea_backup.project_id
}

resource "google_storage_bucket_iam_member" "gitea_backup_member" {
  bucket = google_storage_bucket.bucket.id
  role   = "roles/storage.objectAdmin"
  member = google_service_account.gitea_backup.member
}

module "inventory" {
  source = "../../modules/ansible/inventory"

  groups = {
    gitea = [local.gitea_url]
  }
  host_vars = {
    "gitea.home.lan" = {
      gitea_user : "gitea"
      gitea_http_domain : "gitea.home.lan"
      gitea_root_url : "http://gitea.home.lan"
      restic_google_project_id : google_service_account_key.gitea_backup.id
      restic_google_application_credentials : google_service_account_key.gitea_backup.private_key
    }
  }
}

module "gitea" {
  source = "../../modules/proxmox/vm"

  vm_name             = "gitea"
  proxmox_target_node = "pve"
  clone_vm_name       = "debian-11-base"
  agent               = 1
  cores               = 2
  memory              = 4096

  networks = [
    {
      model    = "virtio"
      bridge   = "vmbr0"
      firewall = true
    }
  ]
  disks = [
    {
      type      = "scsi"
      storage   = "local-lvm"
      size      = "512G"
      io_thread = 1
      discard   = "on"
    }
  ]
}

