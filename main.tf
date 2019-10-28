provider "google" {
  credentials = "${file("credentials.json")}"
  
 }
resource "google_compute_network" "serversnetwork" {
  name = "serversnetwork"
  project      = var.project_id
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "javaserver_network" {
  name          = var.javaserver_instance_network
  project      = var.project_id
  ip_cidr_range = "10.128.0.0/20"
  region        = var.region
  network       = "${google_compute_network.serversnetwork.self_link}"
}
resource "google_compute_subnetwork" "mongoserver_network" {
  name          = var.mongoserver_instance_network
  project      = var.project_id
  ip_cidr_range = "10.128.0.0/20"
  region        = var.region
 network       = "${google_compute_network.serversnetwork.self_link}"
}

resource "google_compute_instance" "javaserver" {
  project      = var.project_id
  name         = var.javaserver_instance_name
  machine_type = var.javaserver_instance_machine_type
  zone         = var.javaserver_instance_zone

  tags = var.javaserver_instance_tags

  boot_disk {
    initialize_params {
      image = var.javaserver_boot_disk_source_image
    }
  }


  network_interface {
    subnetwork           = "${google_compute_subnetwork.javaserver_network.self_link}"
    subnetwork_project = var.project_id

  access_config {
    }
  
    } 
  metadata = {
     ssh-keys = "${var.ssh_user}:${file(var.public_key_path)}"
  }
  
}


resource "google_compute_instance" "mongoserver" {
  project      = var.project_id
  name         = var.mongoserver_instance_name
  machine_type = var.mongoserver_instance_machine_type
  zone         = var.mongoserver_instance_zone

  tags = var.mongoserver_instance_tags

    boot_disk {
    initialize_params {
      image = var.mongoserver_boot_disk_source_image
    }
  }

  network_interface {
    subnetwork            = "${google_compute_subnetwork.mongoserver_network.self_link}"
    subnetwork_project = var.project_id

    access_config {
 }
  }
   metadata = {
     ssh-keys = "${var.ssh_user}:${file(var.public_key_path)}"
  }
  
}
