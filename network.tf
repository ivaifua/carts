resource "google_compute_network" "servers-network" {
   project      = var.project_id
   name = var.network_name
}