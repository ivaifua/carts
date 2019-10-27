
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
  default     = ["http-server","https-server","externalport-8081","externalport-443"]
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
  default     = ["http-server","https-server","externalport-27017"]
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

variable "javaserver_instance_network" {
  description = "The network to deploy the javaserver VM in"
  default     = "default"
}

variable "mongoserver_instance_network" {
  description = "The network to deploy the javaserver VM in"
  default     = "servers-network"
}

