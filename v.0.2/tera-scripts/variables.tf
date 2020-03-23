variable "region" { default = "us-central1" }
variable "project-name" { default = "connector-2-250114" }
variable "project" { default = "connector-2-250114" }
variable "subnetwork-region" { default = "us-central1" }
variable "tera-network" { default = "my-network" }
variable "network" { default = "my-network" }
variable "vm_type" { default { "512gig" = "f1-micro" } }
variable "node_type" { default     = "f1-micro" }
variable "source_imag" { default =  "tera-demo" }
variable "os" { default = "tera-demo" }
variable "pri-instance-name" { default = "pri-instance" }
variable "pub-instance-name" { default = "pub-instance" }
variable "bastion-instance-name" { default = "bastion-instance" }


variable "public-cidr" { default = "10.0.1.0/24" }
variable "private-cidr" { default = "10.0.2.0/24" }
variable "gce_ssh_user" { default = "sudipta1436" }
variable "gce_ssh_pub_key_file" { default = "/opt/gcp-tera-ansible/keys/google_cloud_compute-public.pub" }
variable "service_account" { default = "/opt/gcp-tera-ansible/sa/connector-2-250114-2686add953e4.json" }
variable "internet-lb-name" { default = "http-backend" }
variable "group1_region" { default = "us-central1" }
variable "zone_a" { default = "us-central1-a" }
variable "zone_b" { default = "us-central1-b" }
variable "network_name" { default = "tera-net" }
variable "instance_count" { default = "2" }
variable "name" { default = "web" }
variable "machine_type" { default = "n1-standard-1" }
variable "source_image" { default = "" }
variable "source_image_project" { default = ""}
variable "disk_size_gb" { default = "10"}
variable "disk_type" { default = "pd-standard"}
variable "tags" {
  type        = "list"
  default     = []
}



variable "metadata" {
  type        = "map"
  description = "Map of custom metadata key value pairs e.g. startup_script_url"
  default     = {}
}


variable "zones" { 
  default = {
    zone0 = "us-central1-a"
    zone1 = "us-central1-b"
  }
}

variable "hostname" {
  default = {
    host0 = "host1"
    host1 = "host2"
    host2 = "pubnode"
  }
}


variable "routes" {
  description = "List of routes being created in this VPC"
  default     = []
}



