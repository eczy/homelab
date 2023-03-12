module "vm" {
  source = "../vm"

  vm_name             = var.vm_name
  proxmox_target_node = var.proxmox_target_node
  clone_vm_name       = var.clone_vm_name
  agent               = var.agent
  cores               = var.cores
  memory              = var.memory
  networks            = var.networks
  disks               = var.disks
}