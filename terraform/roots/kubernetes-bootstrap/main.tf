module "metallb" {
  source = "./metallb"
}

module "traefik" {
  source = "./traefik"
}

module "argocd" {
  source = "./argocd"
}

module "local_storage_class" {
  source = "./local-storage-class"
}