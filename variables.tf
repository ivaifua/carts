
variable "project_id" {
  description = "The project ID to deploy to"
  default     = "silicon-dialect-245108"
}

variable "region" {
  description = "The region to deploy to"
  default     = "europe-west3"
}

variable "javaserver_instance_name" {
  description = "The name to assign to the javaserver VM"
  default     = "javaserver"
}

variable "javaserver_instance_machine_type" {
  description = "The machine type to provision for javaserver"
  default     = "n1-standard-1"
}

variable "javaserver_boot_disk_source_image" {
  description = "The name of the disk image to use as the boot disk for the javaserver "
  default     = "centos-7-v20190905"
}

variable "mongoserver_boot_disk_source_image" {
  description = "The name of the disk image to use as the boot disk for the javaserver "
  default     = "debian-9-stretch-v20190916"
}

variable "javaserver_instance_zone" {
  description = "The zone to deploy the javaserver VM in"
  default     = "europe-west3-c"
}

variable "javaserver_instance_tags" {
  type        = list(string)
  description = "Tags to assign to the javaserver VM"
  default     = ["http-server","https-server","externalport-8081","externalport-443","externalport-22"]
}


variable "javaserver_instance_access_cidrs" {
  type        = list(string)
  description = "CIDRs to allow to access javaserver over HTTP(s)"
  default     = ["0.0.0.0/0"]
}

variable "mongoserver_instance_name" {
  description = "The name to assign to the javaserver VM"
  default     = "mongoserver"
}

variable "mongoserver_instance_machine_type" {
  description = "The machine type to provision for javaserver"
  default     = "n1-standard-1"
}

variable "mongoserver_instance_tags" {
  type        = list(string)
  description = "Tags to assign to the javaserver VM"
  default     = ["http-server","https-server","externalport-27017","externalport-22"]
}

variable "mongoserver_instance_access_cidrs" {
  type        = list(string)
  description = "CIDRs to allow to access javaserver over HTTP(s)"
  default     = ["0.0.0.0/0"]
}

variable "mongoserver_instance_zone" {
  description = "The zone to deploy the javaserver VM in"
  default     = "europe-west3-c"
}

variable "mongoserver_instance_network" {
  description = "The network to deploy the mongoserver VM in"
  default     = "default"
}

variable "javaserver_instance_network" {
  description = "The network to deploy the javaserver VM in"
  default     = "serversnetwork"
}

variable "instance_network_name" {
  description = "The network to deploy the javaserver VM in"
  default     = "serversnetwork"
}
variable "javaserver_inctance_internalname" {
  description = ""
  default     = "javaserver"
}
variable "mongoserver_inctance_internalip" {
  description = ""
  default     = "10.156.0.32"
}
variable "javaserver_inctance_internalip" {
  description = ""
  default     = "10.156.0.31"
}
variable "mongoserver_inctance_internalname" {
  description = ""
  default     = "mongoserver"
}
variable ssh_user {
  description = "Name of ssh user for connect to host"
  default     = "jenkins"
 }

variable "public_key_path" {
  description = "public key for user Taras"
  default     = "/var/lib/jenkins/.ssh/id_rsa.pub"
}
