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
  ip_cidr_range = "255.255.240.0/20"
  region        = var.region
  network       = "${google_compute_network.serversnetwork.self_link}"
}
resource "google_compute_subnetwork" "mongoserver_network" {
  name          = var.mongoserver_instance_network
  project      = var.project_id
  ip_cidr_range = "255.255.240.0/20"
  region        = var.region
 network       = "${google_compute_network.serversnetwork.self_link}"
}
 resource "google_compute_address" "javaserver_internal" {
  name         = var.javaserver_inctance_internalname
  project      = var.project_id
  subnetwork   = "${google_compute_subnetwork.javaserver_network.self_link}"
  address_type = "INTERNAL"
  address      = var.javaserver_inctance_internalip
  region       = var.region
}

resource "google_compute_address" "mongoserver_internal" {
  name         = var.mongoserver_inctance_internalname
  project      = var.project_id
  subnetwork   = "${google_compute_subnetwork.mongoserver_network.self_link}"
  address_type = "INTERNAL"
  address      = var.mongoserver_inctance_internalip
  region       = var.region
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
        nat_ip = "${google_compute_address.javaserver_internal.address}"
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
      nat_ip = "${google_compute_address.mongoserver_internal.address}"
    }
  }
   metadata = {
     ssh-keys = "${var.ssh_user}:${file(var.public_key_path)}"
  }
  
}


# javaserver_startup_script_template = file("${path.module}/templates/javaserver_startup_script.sh.tpl")

#resource "null_resource" "wait_for_javaserver_configuration" {
 # provisioner "local-exec" {
 #   command = "${path.module}/scripts/wait-for-javaserver.sh ${var.project_id} ${var.javaserver_instance_zone} ${var.javaserver_instance_name}"
 # }

 # depends_on = [google_compute_instance.mongoserver]
#}

