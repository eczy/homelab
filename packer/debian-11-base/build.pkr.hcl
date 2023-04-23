build {
  sources = ["source.proxmox-iso.debian-11-base"]

  provisioner "shell" {
    inline = ["sudo cloud-init clean"]
  }
}