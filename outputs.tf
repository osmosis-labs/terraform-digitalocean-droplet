output "droplets_ips" {
  description = "Droplet IPs"
  value       = digitalocean_droplet.this.*.ipv4_address
}

output "urns" {
  description = "URNs of all the created resources"
  value       = digitalocean_droplet.this.*.urn
}