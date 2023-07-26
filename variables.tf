variable "name" {
  description = "Droplet name"
  type        = string
}

variable "droplet_count" {
  description = "Number of droplets to create"
  default     = 1
  type        = number
}

variable "region" {
  description = "Digitalocean Region"
  default     = "fra1"
  type        = string
}

variable "image" {
  description = "Droplet image name"
  default     = "ubuntu-22-04-x64"
  type        = string
}

variable "size" {
  description = "Droplet sizing. Find slugs with: `doctl compute size list`"
  default     = "m3-4vcpu-32gb"
  type        = string
}

variable "osmosis_users" {
  description = "List of users that will have access to the droplets"
  default     = ["devops@osmosis.team"]
  type        = list(string)
}

variable "vpc_uuid" {
  description = "The ID of the VPC where the Droplet will be located."
  default     = null
  type        = string
}

variable "user_data" {
  description = "A string of the desired User Data for the Droplet."
  default     = null
  type        = string
}

variable "tags" {
  description = "A list of the tags to be applied to the node."
  default     = []
  type        = list(string)
}

variable "firewall_inbound_rules" {
  type = list(object({
    protocol                  = string
    port_range                = optional(string)
    source_addresses          = optional(list(string))
    source_droplet_ids        = optional(list(string))
    source_tags               = optional(list(string))
    source_load_balancer_uids = optional(list(string))
    source_kubernetes_ids     = optional(list(string))
  }))
  description = "List of inbound rule configurations for the digitalocean_firewall resource."
  default = [
    {
      protocol         = "tcp"
      port_range       = "22"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol         = "tcp"
      port_range       = "80"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol         = "tcp"
      port_range       = "443"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
  ]
}

variable "firewall_outbound_rules" {
  type = list(object({
    protocol                       = string
    port_range                     = optional(string)
    destination_addresses          = optional(list(string))
    destination_droplet_ids        = optional(list(string))
    destination_tags               = optional(list(string))
    destination_load_balancer_uids = optional(list(string))
    destination_kubernetes_ids     = optional(list(string))
  }))

  description = "List of outbound rule configurations for the digitalocean_firewall resource."
  default = [
    {
      protocol              = "icmp"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol              = "tcp"
      port_range            = "1-65535"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol              = "udp"
      port_range            = "1-65535"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    }
  ]
}
