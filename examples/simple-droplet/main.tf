terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}

module "simple_droplet" {
  source = "../../"

  name   = "simple-droplet"
  region = "fra1"
  size   = "s-1vcpu-1gb-amd"

  tags = ["example"]
}

output "ips" {
  value       = module.simple_droplet.droplets_ips
  description = "Droplet IPs"
}
