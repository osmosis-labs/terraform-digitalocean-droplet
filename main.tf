locals {
  username = "cosmos"
  moniker  = var.name
}

resource "digitalocean_droplet" "cosmos_droplet" {
  name   = var.name
  region = var.region
  image  = var.image
  size   = var.size
  tags   = concat(var.tags, ["terraform"])

  monitoring = true

  # Volumes
  volume_ids = var.volume_ids

  # SSH Access
  ssh_keys = [
    digitalocean_ssh_key.cosmos_droplet.fingerprint
  ]
  droplet_agent = false

  # Initialize node via cloud init
  user_data = data.template_file.cosmos_base.rendered
}

data "template_file" "cosmos_base" {
  template = file("${path.module}/templates/base.yaml")

  vars = {
    ssh_authorized_key = local.create_tls_key ? tls_private_key.cosmos_tls_key.0.public_key_openssh : file(var.tls_public_key)
    username           = local.username
    moniker            = local.moniker
  }
}