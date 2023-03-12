packer {
  required_plugins {
    proxmox = {
      version = ">=0"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}