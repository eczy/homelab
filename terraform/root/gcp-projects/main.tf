data "google_billing_account" "acct" {
  display_name = var.billing_account_name
  open         = true
}

resource "google_project" "proxmox_backup" {
  name            = "Proxmox Backup"
  project_id      = "eczy-proxmox-backup"
  billing_account = data.google_billing_account.acct.id
}