locals {
  gitolite_url = "git.homelab.lan"
}

resource "pihole_dns_record" "gitolite_record" {
  domain = local.gitolite_url
  ip     = module.gitolite.vm.default_ipv4_address
}

module "gitolite" {
  source = "../../modules/proxmox/vm"

  vm_name             = "gitolite"
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
${file("${var.gitolite_ssh_key}.pub")}
  EOF
}

module "inventory" {
  source = "../../modules/ansible/inventory"

  groups = {
    gitolite = {
      hosts = {
        (local.gitolite_url) = null
      }
    }
  }
  host_vars = {
    (local.gitolite_url) = {
      ansible_ssh_private_key_file = var.gitolite_ssh_key
    }
  }
}