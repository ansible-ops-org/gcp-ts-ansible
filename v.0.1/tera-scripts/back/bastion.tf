data "google_compute_image" "my_ima" {
  family  = "tera-demo"
  project = "connector-2-250114"
}


resource "google_compute_instance" "bastion-instance" {
  count        = "1"
  name         = "${var.bastion-instance-name}"
  machine_type = "${var.node_type}"
  zone         = "${var.zone_a}"

  tags = [
    "nat-instance",
    "${var.network}-bastion-firewall-ssh",
    "${var.network}-bastion-firewall-http",
    "${var.network}-bastion-firewall-https",
    "${var.network}-bastion-firewall-icmp",
  ]


 boot_disk {
    initialize_params {
      image = "${data.google_compute_image.my_ima.self_link}"
    }
  }
  metadata {
    hostname = "${lookup(var.hostname, "host${count.index}")}"
    sshKeys = "${var.gce_ssh_user}:${file(var.gce_ssh_pub_key_file)}"
  }



  can_ip_forward = true

  network_interface {
    subnetwork = "${google_compute_subnetwork.my_public_subnetwork.name}"

    access_config {
      // Ephemeral IP
    }
  }
}
