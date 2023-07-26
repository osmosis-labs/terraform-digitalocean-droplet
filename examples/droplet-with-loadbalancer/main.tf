terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}

module "nodes" {
  source = "../../"

  droplet_count = 2
  name          = "nodes"
  region        = "fra1"
  size          = "s-1vcpu-1gb-amd"

  tags = ["example"]

  inbound_rules = [
    {
      protocol         = "tcp"
      port_range       = "22"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol         = "tcp"
      port_range       = "26656"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol                  = "tcp"
      port_range                = "1317"
      source_load_balancer_uids = [digitalocean_loadbalancer.this.id]
    },
    {
      protocol                  = "tcp"
      port_range                = "26657"
      source_load_balancer_uids = [digitalocean_loadbalancer.this.id]
    },
    {
      protocol                  = "tcp"
      port_range                = "9090"
      source_load_balancer_uids = [digitalocean_loadbalancer.this.id]
    },
    {
      protocol                  = "tcp"
      port_range                = "8080"
      source_load_balancer_uids = [digitalocean_loadbalancer.this.id]
    },
  ]
}

resource "digitalocean_loadbalancer" "this" {

  name   = "nodes-fra1-lb"
  region = "fra1"

  size_unit = 1
  size      = "lb-small"
  algorithm = "least_connections"

  forwarding_rule {
    entry_protocol  = "tcp"
    entry_port      = 26657
    target_protocol = "tcp"
    target_port     = 26657
  }

  healthcheck {
    port     = "26656"
    protocol = "tcp"
  }

  droplet_ids           = module.nodes.droplets_ids
  enable_proxy_protocol = false
}

# Outputs

output "droplet_ips" {
  value       = module.nodes.droplets_ips
  description = "Droplet IPs"
}

output "loadbalancer_ip" {
  value       = digitalocean_loadbalancer.this.ip
  description = "Droplet IPs"
}
