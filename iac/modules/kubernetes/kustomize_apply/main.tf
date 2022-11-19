# reapply the kustomize every time we run terraform apply
resource "random_string" "random" {
  length = 16
  keepers = {
    timestamp = timestamp()
  }
}

# this is gross but necessary to manage kustomize this under terraform
# (kubernetes, kubectl, kustomize providers aren't sufficient)
resource "null_resource" "kustomize" {
  triggers = {
    random = random_string.random.result
  }

  provisioner "local-exec" {
    command = "kubectl apply -k ${var.kustomize_path}"
  }
}