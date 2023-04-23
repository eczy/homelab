locals {
  groups = { for name, hosts in var.groups : name =>
    {
      hosts : { for host in hosts : "${host}" => "" }
    }
  }
}

resource "local_sensitive_file" "inventory" {
  content  = <<EOF
---
${yamlencode(local.groups)}
EOF
  filename = "${path.root}/inventory/hosts.yml"
}

resource "local_sensitive_file" "group_vars" {
  for_each = var.group_vars
  content  = <<EOF
---
${yamlencode(each.value)}
EOF
  filename = "${path.root}/group_vars/${each.key}.yml"
}

resource "local_sensitive_file" "host_vars" {
  for_each = var.host_vars
  content  = <<EOF
---
${yamlencode(each.value)}
EOF
  filename = "${path.root}/host_vars/${each.key}.yml"
}