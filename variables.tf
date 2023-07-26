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

# Networking

variable "create_loadbalancer" {
  description = "Enable loadbalancer creation."
  default     = false
  type        = bool
}
