terraform {
  required_version = ">=1"
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = ">=0"
    }
  }
}

provider "proxmox" {
  pm_timeout      = 6000
  pm_parallel     = 1
  pm_tls_insecure = true
}