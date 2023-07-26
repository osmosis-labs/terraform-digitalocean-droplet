terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}

module "volume_droplet" {
  source = "../../"

  name   = "volume-droplet"
  region = "fra1"
  size   = "s-1vcpu-1gb-amd"

  tags = ["example"]
}

# Volume

resource "digitalocean_volume" "example" {
  region                  = "fra1"
  name                    = "example-volume"
  size                    = 1
  initial_filesystem_type = "ext4"
}

resource "digitalocean_volume_attachment" "example" {
  volume_id  = digitalocean_volume.example.id
  droplet_id = module.volume_droplet.droplets_ids[0]
}

# Outputs

output "ips" {
  value       = module.volume_droplet.droplets_ips
  description = "Droplet IPs"
}
