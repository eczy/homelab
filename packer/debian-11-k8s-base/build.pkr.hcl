build {
  sources = ["source.proxmox-iso.debian-11-k8s-base"]

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
      }
    )
  }

  provisioner "file" {
    destination = "/etc/containerd/config.toml"
    source      = "containerd-config.toml"
  }

  provisioner "file" {
    destination = "/tmp"
    source      = "./provision-scripts"
  }

  provisioner "shell" {
    inline = [
      "set -o errexit",
      "sh /tmp/provision-scripts/install-containerd.sh",
      "sh /tmp/provision-scripts/install-kubeadm.sh",
      "sh /tmp/provision-scripts/configure-networking.sh",
    ]
  }
}