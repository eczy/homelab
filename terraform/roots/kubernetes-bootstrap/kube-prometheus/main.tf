resource "random_string" "random" {
  length = 16
  keepers = {
    timestamp = timestamp()
  }
}

resource "null_resource" "install_kube_prometheus" {
  triggers = {
    random = random_string.random.result
  }

  provisioner "local-exec" {
    command = "sh ${path.module}/install-kube-prometheus.sh ${path.module}"
  }
}

# module "kustomize_apply" {
#   depends_on = [
#     null_resource.install_kube_prometheus
#   ]

#   source = "../../../modules/kubernetes/kustomize_apply"

#   kustomize_path = "${path.module}/kustomize"
# }