variable "proxmox_domain" {
  description = "CNAME to assign to proxmox in pi-hole dnsmasq."
  type        = string
}

variable "proxmox_ip" {
  description = "IP to which proxmox CNAME will direct."
  type        = string
}

variable "proxmox_ssh_key" {
  description = "RSA key pair used to access Proxmox via ssh."
  type        = string
}

variable "restic_backup_google_project_id" {
  description = "GCP project id for backups."
  type        = string
}

variable "restic_backup_password_file" {
  description = "File containing password used to encrypt restic backups."
  type        = string
}