output "docker-bot-ext-ip" {
	value = "${google_compute_instance.docker.network_interface.0.access_config.0.assigned_nat_ip}"
}

