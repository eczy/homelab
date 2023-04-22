locals {
  concourse_url   = "concourse.home.lan"
  worker_pubkey   = file("${var.worker_ssh_key_path}.pub")
  web_pubkey      = file("${var.web_ssh_key_path}.pub")
  postgres_pubkey = file("${var.postgres_ssh_key_path}.pub")
}

module "postgres" {
  source = "../../modules/proxmox/vm"

  vm_name             = "concourse-db"
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
      size    = "128G"
    }
  ]
  cores   = 2
  memory  = 1024
  ciuser  = "debian"
  sshkeys = <<EOF
${local.postgres_pubkey}
  EOF
}

module "web" {
  source = "../../modules/proxmox/vm"

  vm_name             = "concourse-web"
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
      size    = "4G"
    }
  ]
  cores   = 4
  memory  = 4096
  ciuser  = "debian"
  sshkeys = <<EOF
${local.web_pubkey}
  EOF
}

module "worker" {
  count  = var.num_workers
  source = "../../modules/proxmox/vm"

  vm_name             = "concourse-worker"
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
      size    = "128G"
    }
  ]
  cores   = 2
  memory  = 1024
  ciuser  = "debian"
  sshkeys = <<EOF
${local.worker_pubkey}
  EOF
}

module "inventory" {
  source = "../../modules/ansible/inventory"

  groups = {
    postgres = [module.postgres.vm.default_ipv4_address]
    web      = [module.web.vm.default_ipv4_address]
    worker   = [for vm in module.worker : vm.vm.default_ipv4_address]
  }
  group_vars = {
    postgres = {
      ansible_ssh_private_key = var.postgres_ssh_key_path
    }
    web = {
      ansible_ssh_private_key = var.web_ssh_key_path
    }
    worker = {
      ansible_ssh_private_key = var.worker_ssh_key_path
    }
  }
}