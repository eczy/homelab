resource "kubernetes_namespace" "nfs_provisioner_namespace" {
  metadata {
    name = "nfs-provisioner"
  }
}

resource "helm_release" "nfs_subdir_external_provisioner_helm" {
  depends_on = [
    kubernetes_namespace.nfs_provisioner_namespace,
  ]

  name       = "nfs-subdir-external-provisioner"
  repository = "https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner"
  chart      = "nfs-subdir-external-provisioner"
  namespace  = kubernetes_namespace.nfs_provisioner_namespace.id
  version    = "4.0.17"

  set {
    name  = "nfs.server"
    value = "k8s-nfs-0"
  }

  set {
    name  = "nfs.path"
    value = "/share"
  }

  set {
    name  = "storageClass.defaultClass"
    value = true
  }

  set {
    name  = "storageClass.provisionerName"
    value = "k8s-sigs.io/nfs-subdir-external-provisioner"
  }
}