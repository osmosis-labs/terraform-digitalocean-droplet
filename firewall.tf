resource "digitalocean_firewall" "in" {

  name        = format("%s-fw-in", var.name)
  droplet_ids = digitalocean_droplet.this.*.id

  dynamic "inbound_rule" {
    for_each = var.firewall_inbound_rules
    content {
      protocol                  = inbound_rule.value.protocol
      port_range                = inbound_rule.value.port_range
      source_addresses          = inbound_rule.value.source_addresses
      source_droplet_ids        = inbound_rule.value.source_droplet_ids
      source_load_balancer_uids = inbound_rule.value.source_load_balancer_uids
      source_tags               = inbound_rule.value.source_tags
    }
  }
}

resource "digitalocean_firewall" "out" {

  name        = format("%s-fw-out", var.name)
  droplet_ids = digitalocean_droplet.this.*.id

  dynamic "outbound_rule" {
    for_each = var.firewall_outbound_rules
    content {
      protocol                = outbound_rule.value.protocol
      port_range              = outbound_rule.value.port_range
      destination_addresses   = outbound_rule.value.destination_addresses
      destination_droplet_ids = outbound_rule.value.destination_droplet_ids
      destination_tags        = outbound_rule.value.destination_tags
    }
  }
}
