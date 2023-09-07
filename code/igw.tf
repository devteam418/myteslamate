// -----------------------------------------------------------------------------------------------------
// Internet Gateway and Routing
// -----------------------------------------------------------------------------------------------------
resource "aws_internet_gateway" "vpc-igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name  = upper("myteslamate")
    Owner = var.owner
  }
}