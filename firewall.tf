resource "google_compute_firewall" "externalport-8081" {
  name    = "${var.javaserver_instance_name}-external-tcp-8081"
  project = var.project_id
  network = var.javaserver_instance_network
  allow {
    protocol = "tcp"
    ports    = ["8081"]
  }

  source_ranges           = var.javaserver_instance_access_cidrs
}

resource "google_compute_firewall" "externalport-443" {
  name    = "${var.javaserver_instance_name}-external-tcp-443"
  project = var.project_id
  network = var.javaserver_instance_network
  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges           = var.javaserver_instance_access_cidrs
}

resource "google_compute_firewall" "externalport-27017" {
  name    = "mongoserver-${var.mongoserver_instance_name}-external-tcp-443"
  project = var.project_id
  network = var.mongoserver_instance_network

  allow {
    protocol = "tcp"
    ports    = ["27017"]
  }

  source_ranges           = var.mongoserver_instance_access_cidrs
}

resource "google_compute_firewall" "externalport-22" {
  name    = "external-tcp-22"
  project = var.project_id
  network = "${google_compute_network.serversnetwork.self_link}"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  
}

