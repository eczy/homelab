resource "kubernetes_namespace" "velero_namespace" {
  metadata {
    name = "velero"
  }
}

resource "google_project" "velero_project" {
  name       = "Velero Homelab Backup"
  project_id = "velero-homelab-backup"
}

resource "google_service_account" "velero" {
  account_id   = "velero"
  display_name = "Velero service account"
}

resource "google_storage_bucket" "velero_bucket" {
  name     = "homelab-backup"
  location = "US-CENTRAL1"
  project  = google_project.velero_project.project_id

  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      num_newer_versions = 7
    }
  }
}

resource "helm_release" "velero" {
  depends_on = [
    kubernetes_namespace.velero_namespace,
  ]

  name       = "velero"
  repository = "https://vmware-tanzu.github.io/helm-charts"
  chart      = "velero"
  namespace  = "velero"
  version    = "2.32.4"
}