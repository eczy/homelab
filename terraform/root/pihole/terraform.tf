terraform {
  required_version = ">=1"
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.11"
    }
  }
}

provider "proxmox" {
  pm_timeout      = 6000
  pm_tls_insecure = true
}