provider "digitalocean" {
  token = var.digitalocean_api_token
}

data "digitalocean_ssh_key" "app_ssh_key" {
  name = var.digitalocean_public_ssh_key_name
}

data "digitalocean_image" "app_image" {
  name = var.digitalocean_image_name
}

resource "digitalocean_droplet" "app_instance" {
  name     = var.digitalocean_instance_name
  image    = data.digitalocean_image.app_image.id
  size     = "s-1vcpu-1gb"
  region   = "nyc1"
  ipv6     = true
  ssh_keys = [data.digitalocean_ssh_key.app_ssh_key.id]
}

resource "digitalocean_domain" "app_domain" {
  name       = var.digitalocean_domain_name
  ip_address = digitalocean_droplet.app_instance.ipv4_address
}

resource "digitalocean_record" "app_record_cname" {
  domain = digitalocean_domain.app_domain.name
  type   = "CNAME"
  name   = "www"
  value  = "@"
}