data "google_compute_image" "my_imag" {
  family  = "tera-ami"
  project = "connector-2-250114"
}
resource "google_compute_instance" "pub-instance" {
  count        = "2"
  name         = "${var.pub-instance-name}-${count.index}"
  machine_type = "${var.node_type}"
  zone         = "${lookup(var.zones, "zone${count.index}")}"
  #zone         = "${var.zone_a}"
  tags         = [
    "nginx-nodes",
    "tomcat-nodes",
    "nat-instance",
    "${var.network}-pub-firewall-ssh",
    "${var.network}-pub-firewall-http",
    "${var.network}-pub-firewall-https",
    "${var.network}-pub-firewall-icmp",
  ]
  
  boot_disk {
    initialize_params {
      image = "${data.google_compute_image.my_imag.self_link}"
    }
  }
  metadata {
    hostname = "${lookup(var.hostname, "host${count.index}")}"
    sshKeys = "${var.gce_ssh_user}:${file(var.gce_ssh_pub_key_file)}"
  }
 can_ip_forward = true
  metadata_startup_script = "sudo yum -y update; sudo yum  -y install nginx ; sudo pip install ansible==2.7.10"
  network_interface {
    subnetwork = "${google_compute_subnetwork.my_public_subnetwork.name}"
    access_config {
      // Ephemeral IP
    }
  }
}
resource "google_compute_instance_group" "web-nodes" {
  count       = "2" 
  name        = "web-nodes-${count.index}"
  instances   = ["${google_compute_instance.pub-instance.*.self_link[count.index]}"]#["${element(google_compute_instance.pub-instance.*.self_link, count.index)}"]
  network     = "${google_compute_network.my_network.self_link}"
  zone        = "${lookup(var.zones, "zone${count.index}")}"
  #zone         = "${var.zone_a}"
  
  named_port {
    name = "http"
    port = "80"
  }
  named_port {
    name = "https"
    port = "443"
  }

 





}
