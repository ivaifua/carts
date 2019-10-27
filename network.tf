resource "google_compute_network" "servers-network" {
   project      = var.project_id
   name = var.mongoserver_instance_network
   timeouts {
    create = "60s"
    delete = "60s"
  }
  }
