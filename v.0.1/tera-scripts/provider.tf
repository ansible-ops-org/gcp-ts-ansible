provider "google" {
  credentials = "${file("/opt/sa/connector-2.json")}"
  version = "~> 2.7.0"
  region  = "${var.region}"
  project = "${var.project-name}"
}

provider "google-beta" {
  credentials = "${file("/opt/sa/connector-2.json")}"
  version = "~> 2.7.0"
  region  = "${var.region}"
  project = "${var.project-name}"
}
