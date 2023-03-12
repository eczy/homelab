build {
  sources = ["source.proxmox-iso.debian-11-base"]

  provisioner "shell" {
    inline = [
      "mkdir -p /etc/cloud",
    ]
  }

  provisioner "file" {
    destination = "/etc/cloud/cloud.cfg"
    content = templatefile("${path.root}/cloud.cfg.pkrtpl.hcl",
      {
        ci_username = var.ci_username
        ci_pubkey   = var.ci_pubkey
      }
    )
  }
}