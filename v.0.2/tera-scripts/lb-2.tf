module "gce-lb-http" {
  source            = "/opt/gcp-tera-ansible/tera-scripts/terraform-google-lb-http"
  name              = "tera-demo-lb"
  target_tags       = "${var.tags}"
  firewall_networks = "${var.network}"
  project           = "${var.project}"
 # backends          = {
 #   "0"             = [
 #     { group = "${google_compute_instance_group.web-nodes.*.self_link}" },
 #   ]
 # }
  backends       = "${google_compute_instance_group.web-nodes.*.self_link}"
  backend_params =  
  {
    "timeout_sec" = 50
    "port_name"   = "http"
    "req_path"    = "/"
    "port"        = 80
  }
#[ "/,http,80,50" ]
}





resource "google_compute_backend_service" "web-nodes" {
  count       = 2#"${length(google_compute_instance_group.web-nodes.*.self_link)}"
  project     = "${var.project}"
  name        = "${var.name}-api-${count.index}"
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 30
  enable_cdn  = false
  backend {
    group = "${google_compute_instance_group.web-nodes.*.self_link[count.index]}"
  }
    health_checks = ["${google_compute_health_check.hc.self_link}"]
}


resource "google_compute_health_check" "hc" {
  project = "${var.project}"
  name    = "${var.name}-hc"
  http_health_check {
    port         = 80
    request_path = "/"
  }
  check_interval_sec = 30
  timeout_sec        = 30
}
















output "load-balancer-ip" {
  value = "${module.gce-lb-http.external_ip}"
}

