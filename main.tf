provider "google" {
  credentials = "${file("credentials.json")}"
  
 }
resource "google_compute_network" "serversnetwork" {
  name = var.serversnetwork_name
  project      = var.project_id
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "prodservers_network" {
  name          = var.prodservers_network_name
  project      = var.project_id
  ip_cidr_range = var.prodservers_ip_cidr_range
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
    subnetwork           = "${google_compute_subnetwork.prodservers_network.self_link}"
    subnetwork_project = var.project_id
    network_ip         = var.javaserver_instance_network_ip

    access_config {
      network_tier     = var.javaserver_instance_network_tier
      nat_ip           = var.nat_ip
 }
    }
  
  provisioner "remote-exec" {
    connection {
      host        = "${google_compute_instance.javaserver.network_interface.0.access_config.0.nat_ip}"
      type        = "ssh"
      user        = "${var.ssh_user}"
      timeout     = "500s"
      private_key = "${file(var.private_key_path)}"
    }

    inline = [
     # "touch /tmp/temp.txt",
    ]
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
    subnetwork         = "${google_compute_subnetwork.prodservers_network.self_link}"
    subnetwork_project = var.project_id
    network_ip         = var.mongoserver_instance_network_ip

    access_config {
      network_tier     = var.mongoserver_instance_network_tier
      nat_ip           = var.nat_ip
 }
  }
   metadata = {
     ssh-keys = "${var.ssh_user}:${file(var.public_key_path)}"
  }
  provisioner "remote-exec" {
    connection {
      host        = "${google_compute_instance.mongoserver.network_interface.0.access_config.0.nat_ip}"
      type        = "ssh"
      user        = "${var.ssh_user}"
      timeout     = "500s"
      private_key = "${file(var.private_key_path)}"
    }

    inline = [
     # "touch /tmp/temp.txt",
    ]
  } 
}
