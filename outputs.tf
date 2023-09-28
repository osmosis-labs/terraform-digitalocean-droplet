output "droplets_ip" {
  description = "Droplet IP"
  value       = digitalocean_droplet.this.ipv4_address
}

output "droplets_id" {
  description = "Droplet IP"
  value       = digitalocean_droplet.this.id
}

output "urn" {
  description = "URNs of all the created resources"
  value       = digitalocean_droplet.this.urn
}

output "server_name" {
  description = "NAMEs of all the created resources"
  value       = digitalocean_droplet.this.name
}

output "region" {
  description = "REGIONs of all the created resources"
  value       = digitalocean_droplet.this.region
}
