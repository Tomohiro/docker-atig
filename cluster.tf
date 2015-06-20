variable "atlas_token" {}
variable "digitalocean_token" {}
variable "ssh_key_id" {}

atlas {
    name = "tomohiro/cluster"
}

provider "atlas" {
    token = "${var.atlas_token}"
}

provider "digitalocean" {
    token = "${var.digitalocean_token}"
}

resource "digitalocean_droplet" "core-1" {
    image              = "11833262"
    name               = "core-1"
    region             = "sgp1"
    size               = "512mb"
    ipv6               = false
    private_networking = true
    ssh_keys           = ["${var.ssh_key_id}"]
    user_data          = "${file("user-data.yml")}"
}
