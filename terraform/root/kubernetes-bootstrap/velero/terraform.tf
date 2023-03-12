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
    google = {
      source  = "hashicorp/google"
      version = ">=0"
    }
  }
}

provider "google" {
  project = "my-project-id"
  region  = "us-central1"
}


