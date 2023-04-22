variable "postgres_ssh_key_path" {
  description = "Path to RSA key pair used for Concourse database server."
  type        = string
}

variable "web_ssh_key_path" {
  description = "Path to RSA key pair used for Concourse web server."
  type        = string
}

variable "worker_ssh_key_path" {
  description = "Path to RSA key pair used for Concourse worker servers."
  type        = string
}

variable "session_signing_key_path" {
  description = "Path to session signing key used by the web node to verify user session tokens."
  type        = string
}

variable "tsa_host_key_path" {
  description = "Path to RSA key pair used by the web node for ssh worker registration."
  type        = string
}

variable "worker_key_path" {
  description = "Path to RSA key pair used by worker node to verify its registration with the web node."
  type        = string
}

variable "num_workers" {
  description = "Number of worker nodes to provision."
  type        = number
  default     = 1
}