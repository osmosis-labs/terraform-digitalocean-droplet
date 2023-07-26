# resource "digitalocean_loadbalancer" "this" {
#   name   = var.name
#   region = var.region

#   size_unit = 10
#   size      = "lb-small"
#   algorithm = "least_connections"

#   forwarding_rule {
#     entry_protocol  = "http"
#     entry_port      = 80
#     target_protocol = "http"
#     target_port     = 80
#   }

#   forwarding_rule {
#     entry_protocol  = "tcp"
#     entry_port      = 9090
#     target_protocol = "tcp"
#     target_port     = 9090
#   }

#   healthcheck {
#     port     = "26656"
#     protocol = "tcp"
#   }

#   droplet_ids           = local.droplet_ids
#   enable_proxy_protocol = true
# }
