source "digitalocean" "app_snapshot" {
  api_token     = var.digitalocean_api_token
  snapshot_name = var.digitalocean_snapshot_name
  image         = "ubuntu-20-04-x64"
  region        = "nyc1"
  size          = "s-1vcpu-1gb"
  communicator  = "ssh"
  ssh_username  = "root"
}

build {
  sources = [
    "source.digitalocean.app_snapshot"
  ]

  provisioner "ansible" {
    playbook_file = "ansible/main.yml"
    keep_inventory_file = true
  }
}