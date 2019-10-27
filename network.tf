data "google_compute_network" "server-netvork" {
  name = "server-network"
  subnetworks_self_links = var.javaserver_instance_network, mongoserver_instance_network
  timeouts {
    create = "90s"
    delete = "90s"
  }
}
