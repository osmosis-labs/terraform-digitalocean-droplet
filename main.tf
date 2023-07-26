data "digitalocean_ssh_keys" "this" {

  # We always give the devops@osmosis.team team
  # access to the droplets
  filter {
    key    = "name"
    values = concat(["devops@osmosis.team"], var.osmosis_users)
  }
}

resource "digitalocean_droplet" "this" {

  count = var.droplet_count

  name   = format("%s-%s-%s", var.name, var.region, count.index)
  region = var.region
  image  = var.image
  size   = var.size

  monitoring    = true
  droplet_agent = false
  backups       = false

  # Volumes on DigitalOcean are not very fast
  # we generally prefer using local disk instead
  volume_ids = []

  # We leave to the module user the responsibility of
  # create a VPC and pass the UUID to the module
  vpc_uuid = var.vpc_uuid

  # Cloud init configuration is left to the user
  user_data = var.user_data

  ssh_keys = data.digitalocean_ssh_keys.this.ssh_keys.*.fingerprint
  tags     = concat(["terraform"], var.tags)
}
