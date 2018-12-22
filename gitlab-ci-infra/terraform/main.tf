provider "google" {
  version = "1.4.0"
  project = "${var.project}"
  region  = "${var.region}"
}

resource "google_compute_instance" "docker" {
  name         = "docker-bot-${count.index}"
  machine_type = "n1-standard-1"
  zone         = "${var.zone}"
  tags         = ["docker-machine"]
  count        = "${var.bot_count}"

  #define bootable disk
  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
			size = "100"
			type = "pd-standard"
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

resource "google_compute_firewall" "firewall_gitlab-ci" {
  name    = "allow-gitlab-ci"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22", "2222", "80", "443"]
  }
}

