resource "kubernetes_namespace" "vault_namespace" {
  metadata {
    name = "vault"
  }
}

resource "helm_release" "vault" {
  depends_on = [
    kubernetes_namespace.vault_namespace,
  ]

  name       = "vault"
  repository = "https://helm.releases.hashicorp.com"
  chart      = "vault"
  namespace  = "vault"
  version    = "0.23.0"

  set {
    name  = "tlsDisable"
    value = false
  }

  set {
    name  = "server.ha.enabled"
    value = true
  }

  set {
    name  = "server.ha.raft.enabled"
    value = true
  }

  # only here temporarily for minikube testing - remove for cluster with >1 node
  set {
    name  = "server.affinity"
    value = ""
  }
}