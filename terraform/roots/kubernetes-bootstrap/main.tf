module "metallb" {
  source = "./metallb"
}

module "traefik_ingress" {
  depends_on = [
    module.metallb
  ]

  source = "./traefik-ingress"
}

module "nfs_sc_provisioner" {
  source = "./nfs-subdir-external-provisioner-helm"
}

module "argocd" {
  depends_on = [
    module.traefik_ingress
  ]

  source = "./argocd"
}

module "kube_prometheus" {
  depends_on = [
    module.traefik_ingress
  ]

  source = "./kube-prometheus"
}
