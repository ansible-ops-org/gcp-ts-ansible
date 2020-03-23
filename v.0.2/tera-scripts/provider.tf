provider "google" {
  credentials = "${file("/opt/gcp-tera-ansible/sa/connector-2-250114-2686add953e4.json")}"
  version = "~> 2.7.0"
  region  = "${var.region}"
  project = "${var.project-name}"
}

provider "google-beta" {
  credentials = "${file("/opt/gcp-tera-ansible/sa/connector-2-250114-2686add953e4.json")}"
  version = "~> 2.7.0"
  region  = "${var.region}"
  project = "${var.project-name}"
}
