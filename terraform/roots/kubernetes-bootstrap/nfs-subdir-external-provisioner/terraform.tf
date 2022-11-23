terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">=0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=0"
    }
  }
}