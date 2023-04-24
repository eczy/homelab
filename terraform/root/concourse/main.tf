locals {
  concourse_url          = "concourse.home.lan"
  worker_pubkeys         = [for f in var.worker_ssh_key_paths : file("${f}.pub")]
  web_pubkey             = file("${var.web_ssh_key_path}.pub")
  postgres_pubkey        = file("${var.postgres_ssh_key_path}.pub")
  tsa_authorized_pubkeys = join("\n", [for f in var.worker_key_paths : file("${f}.pub")])
}

resource "pihole_dns_record" "gitea_record" {
  domain = local.concourse_url
  ip     = module.web.vm.default_ipv4_address
}

# module "postgres" {
#   source = "../../modules/proxmox/vm"

#   vm_name             = "concourse-postgres"
#   proxmox_target_node = "pve"
#   clone_vm_name       = "debian-11-base"
#   agent               = 1
#   networks = [
#     {
#       model    = "virtio"
#       bridge   = "vmbr0"
#       firewall = true
#     }
#   ]
#   disks = [
#     {
#       type    = "scsi"
#       storage = "local-lvm"
#       size    = "128G"
#     }
#   ]
#   cores   = 2
#   memory  = 1024
#   ciuser  = "debian"
#   sshkeys = <<EOF
# ${local.postgres_pubkey}
#   EOF
# }

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
      size    = "8G"
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
  count  = length(var.worker_ssh_key_paths)
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
${local.worker_pubkeys[count.index]}
  EOF
}

module "inventory" {
  source = "../../modules/ansible/inventory"

  groups = merge(
    {
      # postgres = [module.postgres.vm.default_ipv4_address]
      web    = [module.web.vm.default_ipv4_address]
      worker = [for vm in module.worker : vm.vm.default_ipv4_address]
    },
    # need an individual group for each worker since ip isn't known until apply time
    { for i in range(length(module.worker)) : "worker${i}" => [module.worker[i].vm.default_ipv4_address] }
  )
  group_vars = merge(
    {
      # postgres = {
      #   ansible_ssh_private_key_file = var.postgres_ssh_key_path
      # }
      web = {
        ansible_ssh_private_key_file       = var.web_ssh_key_path
        concourse_session_signing_key_file = var.session_signing_key_path
        concourse_tsa_host_key_file        = var.tsa_host_key_path
        concourse_tsa_authorized_keys      = local.tsa_authorized_pubkeys
        concourse_external_url             = local.concourse_url
      }
      worker = {
        concourse_tsa_public_key_file = "${var.tsa_host_key_path}.pub"
        concourse_tsa_host            = "${module.web.vm.default_ipv4_address}:2222"
      }
    },
    { for i in range(length(module.worker)) : "worker${i}" =>
      {
        ansible_ssh_private_key_file          = var.worker_ssh_key_paths[i]
        concourse_tsa_worker_private_key_file = var.worker_key_paths[i]
      }
    }
  )
}