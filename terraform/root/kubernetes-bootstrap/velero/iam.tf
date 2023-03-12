resource "google_project_iam_custom_role" "velero_server" {
  role_id = "velero"
  title   = "Velero Server"
  permissions = [
    "compute.disks.get",
    "compute.disks.create",
    "compute.disks.createSnapshot",
    "compute.snapshots.get",
    "compute.snapshots.create",
    "compute.snapshots.useReadOnly",
    "compute.snapshots.delete",
    "compute.zones.get",
    "storage.objects.create",
    "storage.objects.delete",
    "storage.objects.get",
    "storage.objects.list",
  ]
}

resource "google_storage_bucket_iam_member" "velero_bucket_iam_member" {
  bucket = google_storage_bucket.velero_bucket.name
  role   = "role/storage.objectCreator"
  member = google_service_account.velero
}
