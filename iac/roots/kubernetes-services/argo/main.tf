resource "kubernetes_namespace" "argo_namespace" {
  metadata {
    name = "argo"
  }
}

module "kustomize_apply" {
  source = "../../../modules/kubernetes/kustomize_apply"
  depends_on = [
    kubernetes_namespace.argo_namespace
  ]

  kustomize_path = "${path.module}/kustomize/base"
}