variable "groups" {
  description = "Groups of hosts."
  type        = any
}

variable "group_vars" {
  description = "Group vars. Each top level map key is assumed to be the name of a group and will result in a distinct file."
  type        = any # map(map(x)) where x can be string, list(string), or map(string)  default     = {}
}

variable "host_vars" {
  description = "Host vars. Each top level map key is assumed to be the name of a host and will result in a distinct file."
  type        = any # map(map(x)) where x can be string, list(string), or map(string)
  default     = {}
}