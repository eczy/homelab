terraform {
  required_version = ">=1"
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = ">=0"
    }
  }
}