build {
  sources = ["source.proxmox-iso.debian-11-gitlab"]

  provisioner "shell" {
    inline = [
      "curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | bash",
      "EXTERNAL_URL=\"${var.gitlab_url}\" apt-get install gitlab-ce",
      "mkdir -p /etc/cloud",
    ]
  }

  provisioner "file" {
    destination = "/etc/cloud/cloud.cfg"
    content = templatefile("${path.root}/cloud.cfg.pkrtpl.hcl",
      {
        ci_username = var.ci_username
        ci_pubkey   = var.ci_pubkey
        gitlab_url  = var.gitlab_url
      }
    )
  }
}