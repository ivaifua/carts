provider "google" {
  credentials = "${file("credentials.json")}"
  
}

  resource "google_compute_network" "servers-network" {
   project      = var.project_id
   name = var.network_name
}

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
    subnetwork         = var.instance_subnetwork
    subnetwork_project = var.project_id

    access_config {
    }
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
    subnetwork         = var.instance_subnetwork
    subnetwork_project = var.project_id

    access_config {
    }
  }
}


# javaserver_startup_script_template = file("${path.module}/templates/javaserver_startup_script.sh.tpl")

#resource "null_resource" "wait_for_javaserver_configuration" {
 # provisioner "local-exec" {
 #   command = "${path.module}/scripts/wait-for-javaserver.sh ${var.project_id} ${var.javaserver_instance_zone} ${var.javaserver_instance_name}"
 # }

 # depends_on = [google_compute_instance.mongoserver]
#}

