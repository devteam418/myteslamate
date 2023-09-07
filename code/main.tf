// -----------------------------------------------------------------------------------------------------
// We'll use AWS Infrastructure
// -----------------------------------------------------------------------------------------------------
provider "aws" {
  profile = "tumbler"
  region  = var.region
}

// -----------------------------------------------------------------------------------------------------
// Networking
// -----------------------------------------------------------------------------------------------------
resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name  = upper("myteslamate")
    Owner = var.owner
  }
}

// -----------------------------------------------------------------------------------------------------
// Application subnet(s)
// -----------------------------------------------------------------------------------------------------
resource "aws_subnet" "subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "${split(".", var.cidr)[0]}.${split(".", var.cidr)[1]}.0.0/20"
  availability_zone = "${var.region}${var.az}"
  tags = {
    Name  = upper("myteslamate-app")
    Owner = var.owner
  }
}

resource "aws_subnet" "subnet-ha" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "${split(".", var.cidr)[0]}.${split(".", var.cidr)[1]}.16.0/20"
  availability_zone = "${var.region}${var.azha}"
  tags = {
    Name  = upper("myteslamate-app-ha")
    Owner = var.owner
  }
}
