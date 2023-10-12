variable "profile" {
  description = "The AWS Credential ID to use"
  default     = "default"
}

variable "region" {
  description = "the region in which the current terraform object will be created."
  default     = "eu-west-3"
}

variable "owner" {
  description = "Tags the objects"
  default     = "MyTeslaMate Archi Project"
}

variable "az" {
  // 'a/b/c'. The AZ in which the primary subnet will be created in.
  default = "a"
}

variable "azha" {
  // 'a/b/c'. The AZ in which the secundary subnet (for High Availabilty) will be created in. CANNOT be same as 'az'.
  default = "b"
}

variable "aztier" {
  // 'a/b/c'. The AZ in which the third subnet (for High Availabilty) will be created in. CANNOT be same as 'az'.
  default = "c"
}

variable "cidr" {
  // The main CIDR range of the VPC
  default = "172.31.0.0/16"
}

variable "allowed-ip-map" {
  // This is the main security filter, as we use the AWS IP filtering to secure the application access.
  // In this map, add your private IP address, or IP range to allow incoming connexion.
  // You can add several IPs.
  default = {
    myip = "82.67.14.30"
  }
}

variable "teslamate-port" {
  // The listening port of Teslamate.
  // You can change it to 
  default = 3000
}

variable "grafana-port" {
  // The listening port of Grafana
  default = 4000
}

variable "timezone" {
  default = "Europe/Paris"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami-name-to-search" {
  default = "al202?-ami-202*-kernel-6.1-x86_64*"
}

resource "random_string" "sgsuffix" {
  length  = 12
  upper   = true
  numeric = true
  lower   = false
  special = false
}