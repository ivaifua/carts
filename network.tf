resource "google_compute_network" "servers-network" {
   project      = var.project_id
   name = "servers-network"
   timeouts {
    create = "60s"
    delete = "60s"
  }
  }
