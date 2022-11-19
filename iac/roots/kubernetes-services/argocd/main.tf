resource "kubernetes_namespace" "argocd_namespace" {
  metadata {
    name = "argocd"
  }
}

module "kustomize_apply" {
  source = "../../../modules/kubernetes/kustomize_apply"
  depends_on = [
    kubernetes_namespace.argocd_namespace
  ]

  kustomize_path = "${path.module}/kustomize/base"
}