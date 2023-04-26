locals {
  pihole_static_ip = "192.168.50.3/24"
  pihole_gateway   = "192.168.50.1"
}

module "vm" {
  source = "../../modules/proxmox/vm"

  vm_name             = "pihole"
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
      type      = "scsi"
      storage   = "local-lvm"
      size      = "4G"
      io_thread = 1
      discard   = "on"
    }
  ]
  cores    = 1
  memory   = 512
  ciuser   = "debian"
  sshkeys  = <<EOF
  ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDevI1r3PifivjoURojkHO1hCkpavz9/uU4RPwl0kp9UDalOm0coaVs9hpLgMkhJ9/jvbdBPm6l/oKyH+Lys9QVPanMqMpIO/l9LeLJhZ+NQ2qtzsAZemh40R3KQ6lbh/s17FfEyw6r1ZgnSKkG5kdHJy5TRHrsH2fytgZWfHghrjlprw8CApZ+kAmEZoZKA/XIMtLVuirkRHp/ra9hUHjnzKJ2DwodEtyF1NvbuF0ZFlVLsWKbK6ld3c2+w4e1OA0z7RLak9vzQDoLI0Hudtk9Iwkw9AzmYVnNr+XxEzxvgtxFbCKjISwrkjAcVS4NWkw584vIYH6n/rBxeFb+JXlGUy5xMaU8rWj1neT9xJ4RBSBc4+O2AapghhQD+DMy2VZyRJePyhpP5StnDGgyIDGWawVvPh9P0+YekzrIBF0PuLILM/CWmrYVgEbXLypWTshJf4V70VPvu0AaYh18BSZ/7we8/0JiGP/BTu70NpqTNi63w8oABcoJ1AByyUEcbJc=
  EOF
  ipconfig = "ip=${local.pihole_static_ip},gw=${local.pihole_gateway}"
}


module "inventory" {
  source = "../../modules/ansible/inventory"

  groups = {
    pihole = {
      hosts = {
        (module.vm.vm.default_ipv4_address) = null
      }
    }
    group_vars = {
      pihole = {
        pihole_static_ip = local.pihole_static_ip
      }
    }
  }
}