module "metallb" {
  source = "./metallb"
}

module "traefik_ingress" {
  source = "./traefik-ingress"
}

module "nfs_sc_provisioner" {
  source = "./nfs-subdir-external-provisioner-helm"
}

module "argocd" {
  source = "./argocd"
}
