terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}

module "cosmos-droplet" {
  source = "../../"

  name   = "example-cosmos-droplet"
  region = "nyc3"
  size   = "s-4vcpu-8gb"

  tags = ["cosmos", "fullnode"]
}

output "ip" {
  value       = module.cosmos-droplet.ip
  description = "Droplet IP"
}

output "private_key" {
  value       = module.cosmos-droplet.tls_private_key
  sensitive   = true
  description = "Private key to connect to the droplet"
}

output "ssh_help" {
  value       = <<EOT
Get ssh key:
terraform output --raw private_key > droplet.key && chmod 600 droplet.key

Connect to the instance:
ssh cosmos@${module.cosmos-droplet.ip} -i droplet.key 
EOT
  description = "Instructions to connect with the instance"
}