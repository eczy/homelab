build {
  sources = ["source.proxmox-iso.debian-11-nfs-base"]

  provisioner "shell" {
    inline = [
      "mkdir -p /etc/cloud",
      "mkdir -p /etc/containerd",
    ]
  }

  provisioner "file" {
    destination = "/etc/cloud/cloud.cfg"
    content = templatefile("${path.root}/cloud.cfg.pkrtpl.hcl",
      {
        ci_username = var.ci_username
        ci_pubkey   = var.ci_pubkey
        nfs_export_path = var.nfs_export_path
        nfs_export_string = var.nfs_export_string
      }
    )
  }
}