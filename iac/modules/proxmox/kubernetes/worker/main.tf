resource "proxmox_vm_qemu" "node" {
  target_node = var.proxmox_target_node

  name       = var.vm_name
  desc       = "Terraform managed k8s worker node. Updated at ${timestamp()}."
  clone      = var.clone_vm_name
  full_clone = true

  dynamic "disk" {
    for_each = var.disks
    content {
      type        = disk.value["type"]
      storage     = disk.value["storage"]
      size        = disk.value["size"]
      format      = disk.value["format"]
      cache       = disk.value["cache"]
      backup      = disk.value["backup"]
      iothread    = disk.value["iothread"]
      replicate   = disk.value["replicate"]
      ssd         = disk.value["ssd"]
      discard     = disk.value["discard"]
      mbps        = disk.value["mbps"]
      mbps_rd     = disk.value["mbps_rd"]
      mbps_rd_max = disk.value["mbps_rd_max"]
      mbps_wr     = disk.value["mbps_wr"]
      mbps_wr_max = disk.value["mbps_wr_max"]
      media       = disk.value["media"]
    }
  }

  dynamic "network" {
    for_each = var.networks
    content {
      model     = network.value["model"]
      macaddr   = network.value["macaddr"]
      bridge    = network.value["bridge"]
      tag       = network.value["tag"]
      firewall  = network.value["firewall"]
      rate      = network.value["rate"]
      queues    = network.value["queues"]
      link_down = network.value["link_down"]
    }
  }

  cores    = var.cores
  sockets  = var.sockets
  memory   = var.memory
  bootdisk = var.bootdisk

  automatic_reboot = true
  onboot           = true

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = var.username
      private_key = file("${path.root}/${var.private_key_file}")
      host        = var.vm_name
    }

    inline = [
      "sudo kubeadm join --token ${var.kubeadm_token} --discovery-token-unsafe-skip-ca-verification ${var.control_plane_endpoint}",
    ]
  }
}