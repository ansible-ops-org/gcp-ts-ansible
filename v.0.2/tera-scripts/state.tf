terraform {
  backend "gcs" {
    region = "us-east1"
    bucket = "tera-state-2"
    prefix = "tera"
    credentials = "/opt/gcp-tera-ansible/sa/connector-2-250114-2686add953e4.json"
  }
}



