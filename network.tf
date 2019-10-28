data "google_compute_network" "instance_network" {
  name = "server-network"
  subnetworks_self_links = var.javaserver_instance_network, var.mongoserver_instance_network
  timeouts {
    create = "90s"
    delete = "90s"
  }
}
