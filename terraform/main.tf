provider "digitalocean" {
  token = var.digitalocean_api_token
}

data "digitalocean_ssh_key" "app_ssh_key" {
  name = var.digitalocean_public_ssh_key_name
}

resource "digitalocean_droplet" "app_instance" {
  name     = var.digitalocean_instance_name
  image    = "ubuntu-20-04-x64"
  size     = "s-1vcpu-1gb"
  region   = "nyc1"
  ipv6     = true
  ssh_keys = [data.digitalocean_ssh_key.app_ssh_key.id]
}