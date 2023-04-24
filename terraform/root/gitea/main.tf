locals {
  gitea_url = "gitea.home.lan"
}

resource "pihole_dns_record" "gitea_record" {
  domain = local.gitea_url
  ip     = module.gitea.vm.default_ipv4_address
}

module "gitea" {
  source = "../../modules/proxmox/vm"

  vm_name             = "gitea"
  proxmox_target_node = "pve"
  clone_vm_name       = "debian-11-base"
  agent               = 1
  networks = [
    {
      model    = "virtio"
      bridge   = "vmbr0"
      firewall = true
    }
  ]
  disks = [
    {
      type    = "scsi"
      storage = "local-lvm"
      size    = "512G"
    }
  ]
  cores   = 2
  memory  = 4096
  ciuser  = "debian"
  sshkeys = <<EOF
${file("${var.gitea_ssh_key}.pub")}
  EOF
}

module "inventory" {
  source = "../../modules/ansible/inventory"

  groups = {
    gitea = {
      hosts = {
        (local.gitea_url) = null
      }
    }
  }
  host_vars = {
    (local.gitea_url) = {
      ansible_ssh_private_key_file = var.gitea_ssh_key
      gitea_user                   = "gitea"
      gitea_http_domain            = local.gitea_url
      gitea_ssh_domain             = local.gitea_url
      gitea_root_url               = "http://${local.gitea_url}"
    }
  }
}
