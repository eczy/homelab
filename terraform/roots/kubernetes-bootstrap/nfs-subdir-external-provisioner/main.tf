resource "kubernetes_namespace" "nfs_provisioner_namespace" {
  metadata {
    name = "nfs-provisioner"
  }
}


module "kustomize_apply" {
  source = "../../../modules/kubernetes/kustomize_apply"
  depends_on = [
    kubernetes_namespace.nfs_provisioner_namespace,
  ]

  kustomize_path = "${path.module}/kustomize"
}
