terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}

data "http" "cloudflare_ipv4" {
  url = "https://www.cloudflare.com/ips-v4"
}

data "http" "cloudflare_ipv6" {
  url = "https://www.cloudflare.com/ips-v6"
}

data "http" "better_uptime_ips_url" {
  url = "https://uptime.betterstack.com/ips.txt"
}

locals {
  cloudflare_ips_v4 = split("\n", trimspace(data.http.cloudflare_ipv4.body))
  cloudflare_ips_v6 = split("\n", trimspace(data.http.cloudflare_ipv6.body))
  better_uptime_ips = split("\n", trimspace(data.http.better_uptime_ips_url.response_body))
}

module "fullnode" {
  source = "../../"

  name   = "fullnode"
  region = "fra1"
  size   = "s-1vcpu-1gb-amd"

  tags = ["example"]

  inbound_rules = [
    {
      protocol         = "tcp"
      port_range       = "22"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol         = "tcp"
      port_range       = "1317"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol         = "tcp"
      port_range       = "26656"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol         = "tcp"
      port_range       = "26657"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol         = "tcp"
      port_range       = "9090"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol         = "tcp"
      port_range       = "8080"
      source_addresses = local.better_uptime_ips
    },
    {
      protocol         = "tcp"
      port_range       = "443"
      source_addresses = concat(local.cloudflare_ips_v4, local.cloudflare_ips_v6)
    }
  ]
}

# Outputs

output "ips" {
  value       = module.fullnode.droplets_ips
  description = "Droplet IPs"
}
