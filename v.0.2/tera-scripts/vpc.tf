# resource "google_compute_route" "nat_route" {
#  name                   = "nat-route"
#  dest_range             = "0.0.0.0/0"
#  network                = "${google_compute_network.my_network.name}"
#  next_hop_instance      = "${google_compute_instance.bastion-instance.self_link}"
#  next_hop_instance_zone = "${google_compute_instance.bastion-instance.zone}"
#  tags                   = ["private-instances"]
#  priority               = 100
# }


resource "google_compute_router" "router" {
  name    = "test-router"
  network = "${google_compute_network.my_network.self_link}"
  #region  = "${var.subnetwork-region}"
}

resource "google_compute_address" "project-nat-ips" {
  count   = 2
  name    = "test-compute-address-${count.index}"
  #region  = "${var.subnetwork-region}"
}

resource "google_compute_router_nat" "advanced-nat" {
  name                               = "test-route"
  router                             = "${google_compute_router.router.name}"
  #region                             = "${var.subnetwork-region}"
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = ["${google_compute_address.project-nat-ips.*.self_link}"]
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  #subnetwork {
  #  name                    = "${google_compute_subnetwork.my_private_subnetwork.self_link}"
  #  source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
#  }
}











resource "google_compute_network" "my_network" {
  name                    = "${var.network}"
  project                 = "${var.project-name}"
  description             = "Main global VPC"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "my_public_subnetwork" {
  name          = "${var.network}-public-subnetwork-${var.subnetwork-region}"
  region        = "${var.subnetwork-region}"
  network       = "${google_compute_network.my_network.self_link}"
  ip_cidr_range = "${var.public-cidr}"
}

resource "google_compute_subnetwork" "my_private_subnetwork" {
  name                     = "${var.network}-private-subnetwork-${var.subnetwork-region}"
  region                   = "${var.subnetwork-region}"
  network                  = "${google_compute_network.my_network.self_link}"
  ip_cidr_range            = "${var.private-cidr}"
  private_ip_google_access = true
}










