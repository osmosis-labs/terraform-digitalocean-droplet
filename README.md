<!-- BEGIN_TF_DOCS -->

# Terraform Digitalocean Droplet

This Terraform module creates an opinionated Droplet on Digitalocean for Cosmos Blockchain Nodes.

## Usage Examples

Some examples can be found in this repository:

- [Simple Droplet](./examples/simple-droplet)
- [Droplet with Volume](./examples/droplet-with-volume)
- [Droplet with Floating IP](./examples/droplet-with-floating-ip)
- [Droplet with Monitor Alert](./examples/droplet-with-monitor-alert)


## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| digitalocean | ~> 2.17 |
| tls | ~> 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| digitalocean | 2.17.1 |
| template | 2.2.0 |
| tls | 3.1.0 |

## Inputs

| Name | Description | Default | Required |
|------|-------------|---------|:--------:|
| image | Droplet image name | `"docker-20-04"` | no |
| name | Node name | `"cosmos-droplet"` | no |
| region | Digitalocean Region | `"nyc3"` | no |
| size | Droplet sizing. Find slugs with: `doctl compute size list` | `"s-4vcpu-8gb"` | no |
| tags | A list of the tags to be applied to the node. | `[]` | no |
| tls\_private\_key | Path to private tls key - automatically generated if empty | `""` | no |
| tls\_public\_key | Path to public tls key - automatically generated if empty | `""` | no |
| volume\_ids | A list of volume IDs to attach to the node. | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Droplet ID |
| ip | Droplet IP |
| name | Droplet name |
| tls\_private\_key | TLS private key for connect to the droplet |
| urn | Droplet uniform resource name (URN) |

## Usage

```hcl
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
```
<!-- END_TF_DOCS -->