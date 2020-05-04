variable "digitalocean_api_token" {
  type        = string
  description = "The DigitalOcean token API"
}

variable "digitalocean_public_ssh_key_name" {
  type        = string
  description = "The DigitalOcean public SSH key name"
}

variable "digitalocean_instance_name" {
  type        = string
  description = "The DigitalOcean instance name"
}

variable "digitalocean_domain_name" {
  type        = string
  description = "The DigitalOcean instance domain name"
}

variable "digitalocean_image_name" {
  type        = string
  description = "The DigitalOcean instance image name"
}