variable "postgres_ssh_key_path" {
  description = "Path to RSA key pair used for Concourse database server."
  type        = string
}

variable "web_ssh_key_path" {
  description = "Path to RSA key pair used for Concourse web server."
  type        = string
}

variable "worker_ssh_key_paths" {
  description = "Path to RSA key pair used for Concourse worker servers."
  type        = list(string)
}

variable "session_signing_key_path" {
  description = "Path to session signing key used by the web node to verify user session tokens."
  type        = string
}

variable "tsa_host_key_path" {
  description = "Path to RSA key pair used by the web node for ssh worker registration."
  type        = string
}

variable "worker_key_paths" {
  description = "Paths to RSA key pairs used by worker nodes to verify registration with the web node."
  type        = list(string)
}
