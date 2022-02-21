variable "region" {
  description = "Digitalocean Region"
  default     = "nyc3"
  type        = string
}

variable "image" {
  description = "Droplet image name"
  default     = "docker-20-04"
  type        = string
}

variable "size" {
  description = "Droplet sizing. Find slugs with: `doctl compute size list`"
  default     = "s-4vcpu-8gb"
  type        = string
}

variable "name" {
  description = "Node name"
  default     = "cosmos-droplet"
  type        = string
}

variable "volume_ids" {
  description = "A list of volume IDs to attach to the node."
  default     = []
  type        = list(string)
}

variable "tags" {
  description = "A list of the tags to be applied to the node."
  default     = []
  type        = list(string)
}

variable "tls_public_key" {
  description = "Path to public tls key - automatically generated if empty"
  default     = ""
  type        = string
}

variable "tls_private_key" {
  description = "Path to private tls key - automatically generated if empty"
  default     = ""
  type        = string
}
