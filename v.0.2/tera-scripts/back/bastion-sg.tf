resource "google_compute_firewall" "bastion_allow_ssh" {
  name    = "${var.network}-bastion-firewall-ssh"
  network = "${google_compute_network.my_network.name}"
  project = "${var.project-name}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags   = ["${var.network}-bastion-firewall-ssh"]
  source_ranges = ["0.0.0.0/0"]
}


resource "google_compute_firewall" "bastion_allow_http" {
  name    = "${var.network}-bastion-firewall-http"
  network = "${google_compute_network.my_network.name}"
  project = "${var.project-name}"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  target_tags   = ["${var.network}-bastion-firewall-http"]
  source_ranges = ["0.0.0.0/0"]
}










