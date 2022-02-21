output "name" {
  value       = digitalocean_droplet.cosmos_droplet.name
  description = "Droplet name"
}

output "ip" {
  value       = digitalocean_droplet.cosmos_droplet.ipv4_address
  description = "Droplet IP"
}

output "id" {
  value       = digitalocean_droplet.cosmos_droplet.id
  description = "Droplet ID"
}

output "urn" {
  value       = digitalocean_droplet.cosmos_droplet.urn
  description = "Droplet uniform resource name (URN)"
}

output "tls_private_key" {
  value       = local.create_tls_key ? tls_private_key.cosmos_tls_key.0.private_key_pem : file(var.tls_private_key)
  description = "TLS private key for connect to the droplet"
}