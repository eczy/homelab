terraform {
  required_version = ">=1"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">=0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

