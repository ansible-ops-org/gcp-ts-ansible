data "google_compute_image" "compute_image" {
  family  = "tera-demo"
  project = "connector-2-250114"
}
resource "google_compute_instance" "pri-instance" {
  count        = 1
  name         = "${var.pri-instance-name}-${count.index}"
  machine_type = "${var.vm_type["512gig"]}"
  zone = "${lookup(var.zones, "zone${count.index}")}"
  tags = [
    "private-instances",
    "${var.network}-firewall-ssh",
    "${var.network}-firewall-http",
    "${var.network}-firewall-https",
    "${var.network}-firewall-icmp",
  ]
  boot_disk {
    initialize_params {
      image = "${data.google_compute_image.compute_image.self_link}"
    }
  }
  
  metadata {
    hostname = "${lookup(var.hostname, "host${count.index}")}"
    sshKeys = "${var.gce_ssh_user}:${file(var.gce_ssh_pub_key_file)}"
  }
  can_ip_forward = true
  network_interface {
    subnetwork = "${google_compute_subnetwork.my_private_subnetwork.name}"
  }
}
