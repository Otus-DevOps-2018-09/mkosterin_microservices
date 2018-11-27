provider "google" {
  version = "1.4.0"
  project = "${var.project}"
  region  = "${var.region}"
}

resource "google_compute_instance" "docker" {
  name         = "docker-bot-${count.index}"
  machine_type = "g1-small"
  zone         = "${var.zone}"
  tags         = ["docker-machine"]
  count        = "${var.bot_count}"

  #define bootable disk
  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
    }
  }

  network_interface {
    # networks name
    network = "default"

    # we will use ephemeral IP
    access_config {}
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }

  connection {
    type        = "ssh"
    user        = "appuser"
    agent       = "false"
    private_key = "${file(var.private_key_path)}"
  }
}

resource "google_compute_firewall" "firewall_reddit" {
  name    = "allow-reddit"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }
}
