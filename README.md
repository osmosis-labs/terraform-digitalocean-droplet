<!-- BEGIN_TF_DOCS -->

# Terraform DigitalOcean Droplet Module

The Terraform DigitalOcean Droplet Module is designed to automate the creation of DigitalOcean droplets
with opinionated and standardized configurations for different deployment scenarios.
The primary objective of this module is to promote the DRY (Don't Repeat Yourself) principle,
reducing code duplication through the use of abstractions and avoiding unnecessary redundancies.

## Usage

```hcl
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
```

### Examples

The following examples are available:

- [Simple Droplet](./examples/simple-droplet)
- [Droplet with Volume](./examples/droplet-with-volume)
- [Droplet with Load Balancer](./examples/droplet-with-loadbalancer)
- [Droplet with Firewall Rules](./examples/droplet-with-firewall-rules)

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| digitalocean | ~> 2.17 |
| http | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| digitalocean | 2.29.0 |

## Inputs

| Name | Description | Default | Required |
|------|-------------|---------|:--------:|
| droplet\_count | Number of droplets to create | `1` | no |
| firewall\_inbound\_rules | List of inbound rule configurations for the digitalocean\_firewall resource. | ```[ { "port_range": "22", "protocol": "tcp", "source_addresses": [ "0.0.0.0/0", "::/0" ] }, { "port_range": "80", "protocol": "tcp", "source_addresses": [ "0.0.0.0/0", "::/0" ] }, { "port_range": "443", "protocol": "tcp", "source_addresses": [ "0.0.0.0/0", "::/0" ] } ]``` | no |
| firewall\_outbound\_rules | List of outbound rule configurations for the digitalocean\_firewall resource. | ```[ { "destination_addresses": [ "0.0.0.0/0", "::/0" ], "protocol": "icmp" }, { "destination_addresses": [ "0.0.0.0/0", "::/0" ], "port_range": "1-65535", "protocol": "tcp" }, { "destination_addresses": [ "0.0.0.0/0", "::/0" ], "port_range": "1-65535", "protocol": "udp" } ]``` | no |
| image | Droplet image name | `"ubuntu-22-04-x64"` | no |
| name | Droplet name | n/a | yes |
| osmosis\_users | List of users that will have access to the droplets | ```[ "devops@osmosis.team" ]``` | no |
| region | Digitalocean Region | `"fra1"` | no |
| size | Droplet sizing. Find slugs with: `doctl compute size list` | `"m3-4vcpu-32gb"` | no |
| tags | A list of the tags to be applied to the node. | `[]` | no |
| user\_data | A string of the desired User Data for the Droplet. | `null` | no |
| vpc\_uuid | The ID of the VPC where the Droplet will be located. | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| droplets\_ids | Droplet IPs |
| droplets\_ips | Droplet IPs |
| urns | URNs of all the created resources |
<!-- END_TF_DOCS -->
