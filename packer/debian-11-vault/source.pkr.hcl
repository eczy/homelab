source "proxmox-iso" "debian-11-vault" {
  proxmox_url              = "${var.proxmox_host}"
  insecure_skip_tls_verify = true

  template_description = "Debian 11 cloud-init template. Built on ${formatdate("YYYY-MM-DD hh:mm:ss ZZZ", timestamp())}"
  node                 = var.proxmox_node
  network_adapters {
    bridge   = "vmbr0"
    firewall = true
    model    = "virtio"
    vlan_tag = var.network_vlan
  }
  disks {
    disk_size         = var.disk_size
    format            = var.disk_format
    io_thread         = true
    storage_pool      = var.disk_storage_pool
    storage_pool_type = var.disk_storage_pool_type
    type              = "scsi"
  }
  scsi_controller = "virtio-scsi-single"

  iso_url          = var.iso_url
  iso_checksum     = var.iso_checksum
  iso_storage_pool = var.iso_storage_pool
  boot_wait        = "10s"
  http_directory   = "./"
  boot_command     = ["<esc><wait>auto url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg<enter>"]
  unmount_iso      = true

  cloud_init              = true
  cloud_init_storage_pool = var.cloud_init_storage_pool

  vm_name  = "${var.vm_name}"
  cpu_type = "host"
  os       = "l26"
  memory   = var.memory
  cores    = var.cores
  sockets  = var.sockets

  ssh_password = "packer"
  ssh_username = "root"
  ssh_timeout  = "60m"
}
