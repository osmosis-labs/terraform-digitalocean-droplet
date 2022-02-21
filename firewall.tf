resource "digitalocean_firewall" "in_ssh" {
  name        = "${var.name}-allow-ssh-in"
  droplet_ids = [digitalocean_droplet.cosmos_droplet.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
}

resource "digitalocean_firewall" "in_tendermint" {
  name        = "${var.name}-allow-tendermint-ports-in"
  droplet_ids = [digitalocean_droplet.cosmos_droplet.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "26656"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "26657"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "1317"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "9090"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
}


resource "digitalocean_firewall" "out_all" {
  name        = "${var.name}-allow-out-all"
  droplet_ids = [digitalocean_droplet.cosmos_droplet.id]

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}