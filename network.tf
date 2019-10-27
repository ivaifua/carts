resource "google_compute_network" "servers-network" {
   project      = var.project_id
   name = var.instance_network
}

resource "google_compute_subnetwork" "servers-subnetwork" {
   name = var.instance_subnetwork
   network = var.instance_network
   ip_cidr_range = var.subnetwork-ip_cidr_range
   region        = var.subnetwork-region
   secondary_ip_range {
     range_name    = var.subnetwork-range_name
     ip_cidr_range = var.subnetwork-ip_cidr_range
  }
 }

