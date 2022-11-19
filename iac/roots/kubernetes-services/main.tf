module "metallb" {
  source = "./metallb"
}

module "traefik" {
  source = "./traefik"
}

module "argocd" {
  source = "./argocd"
}

module "argo" {
  source = "./argo"
}