variable "api_token" {}
variable "ssh_key_id" {}

atlas {
    name = "tomohiro/cluster"
}

provider "digitalocean" {
    token = "${var.api_token}"
}

resource "digitalocean_droplet" "core-1" {
    image              = "coreos-stable"
    name               = "core-1"
    region             = "sgp1"
    size               = "512mb"
    ipv6               = false
    private_networking = true
    ssh_keys           = ["${var.ssh_key_id}"]
    user_data          = "${file("cloud-config.yml")}"
}
