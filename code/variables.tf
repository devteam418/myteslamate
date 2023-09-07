variable "profile" {
  description = "The AWS Credential ID to use"
  default     = "tumbler"
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
  // 'a/b/c'. The AZ in which the primary subnets will be created in.
  default = "a"
}

variable "azha" {
  // 'a/b/c'. The AZ in which the secundary subnets (for High Availabilty) will be created in. CANNOT be same as 'az'.
  default = "b"
}

variable "cidr" {
  // The main CIDR range of the VPC
  default = "172.31.0.0/16"
}

variable "allowed-ip-map" {
  // In this map, add your private IP address, or IP range to allow incoming connexion.
  default = { myip = "82.67.14.30" }
}

variable "api-port" {
  // The listening port of the API
  default = 3000
}

variable "timezone" {
  default = "Europe/Paris"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami-name-to-search" {
  default = "amzn-ami-2018.03.20230809-amazon-ecs-optimized*"
}

resource "random_string" "grpsuffix" {
  length  = 12
  upper   = true
  numeric = true
  lower   = false
  special = false
}