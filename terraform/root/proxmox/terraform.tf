terraform {
  required_version = ">=1"

  required_providers {
    pihole = {
      source  = "ryanwholey/pihole"
      version = ">=0"
    }
    google = {
      source  = "hashicorp/google"
      version = ">=0"
    }
  }
}