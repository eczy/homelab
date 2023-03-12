data "google_billing_account" "acct" {
  display_name = var.billing_account_name
  open         = true
}

resource "google_project" "gitea_backup" {
  name            = "Gitea Backup"
  project_id      = "eczy-gitea-backup"
  billing_account = data.google_billing_account.acct.id
}