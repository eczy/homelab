resource "kubernetes_namespace" "traefik_namespace" {
  metadata {
    name = "traefik-v2"
  }
}

module "kustomize_apply" {
  source = "../../../modules/kubernetes/kustomize_apply"
  depends_on = [
    kubernetes_namespace.traefik_namespace,
  ]

  kustomize_path = "${path.module}/kustomize/base"
}

resource "helm_release" "traefik_helm" {
  depends_on = [
    kubernetes_namespace.traefik_namespace,
    module.kustomize_apply,
  ]

  name       = "traefik"
  repository = "https://traefik.github.io/charts"
  chart      = "traefik"
  namespace  = "traefik-v2"
  version    = "20.5.1"
}