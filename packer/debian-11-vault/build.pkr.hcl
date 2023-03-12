build {
  sources = ["source.proxmox-iso.debian-11-vault"]

  provisioner "shell" {
    inline = [
      "mkdir -p /etc/cloud",
      "mkdir -p /etc/vault.d",
      "mkdir -p /opt/vault/data",
    ]
  }

  provisioner "file" {
    destination = "/etc/systemd/system/vault.service"
    source      = "./vault.service"
  }

  provisioner "file" {
    destination = "/etc/vault.d/config.hcl"
    source      = "./vault-config.hcl"
  }

  provisioner "file" {
    destination = "/etc/cloud/cloud.cfg"
    content = templatefile("${path.root}/cloud.cfg.pkrtpl.hcl",
      {
        ci_username = var.ci_username
        ci_pubkey   = var.ci_pubkey
        ip_addr     = var.ip_addr
        gateway     = var.gateway
        nameserver  = var.nameserver
      }
    )
  }
}