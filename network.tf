resource "google_compute_network" "servers-network" {
   project      = var.project_id
   name = var.instance_network
}

resource "google_compute_subnetwork" "servers-subnetwork" {
   project      = var.project_id
   name = var.instance_subnetwork
   network = var.instance_network
   
  }
 }

