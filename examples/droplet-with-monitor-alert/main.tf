terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}

# More alerts here: https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/monitor_alert
resource "digitalocean_monitor_alert" "cpu_alert" {
  alerts {
    email = ["sammy@digitalocean.com"]
    # slack {
    #   channel   = "Alerts"
    #   url       = "https://hooks.slack.com/services/T1234567/AAAAAAAA/ZZZZZZ"
    # }
  }
  window      = "5m"
  type        = "v1/insights/droplet/cpu"
  compare     = "GreaterThan"
  value       = 90
  enabled     = true
  entities    = [module.cosmos-droplet.id]
  description = "Alert about CPU usage"
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