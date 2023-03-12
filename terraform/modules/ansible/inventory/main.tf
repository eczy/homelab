resource "local_sensitive_file" "inventory" {
  content = templatefile("${path.module}/inventory.yml.tftpl", {
    groups = var.groups
  })
  filename = "${path.root}/inventories/${var.name}/hosts.yml"
}

resource "local_sensitive_file" "group_vars" {
  for_each = var.group_vars
  content = templatefile("${path.module}/group_vars.yml.tftpl", {
    vars = each.value
  })
  filename = "${path.root}/inventories/${var.name}/group_vars/${each.key}.yml"
}

resource "local_sensitive_file" "host_vars" {
  for_each = var.host_vars
  content = templatefile("${path.module}/host_vars.yml.tftpl", {
    vars = each.value
  })
  filename = "${path.root}/inventories/${var.name}/host_vars/${each.key}.yml"
}