terraform {
  required_version = ">= 1.0.0"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.17"
    }
    http = {
      source  = "hashicorp/http"
      version = "~> 3.0"
    }
  }
}
