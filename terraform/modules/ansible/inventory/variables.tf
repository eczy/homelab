variable "name" {
  description = "Inventory name."
  type        = string
}

variable "groups" {
  description = "Groups of hosts."
  type        = map(list(string))
}

variable "group_vars" {
  description = "Group vars."
  type        = map(map(string))
  default     = {}
}

variable "host_vars" {
  description = "Host vars."
  type        = map(map(string))
  default     = {}
}