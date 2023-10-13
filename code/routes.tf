// -----------------------------------------------------------------------------------------------------
// Routing to Internet
// -----------------------------------------------------------------------------------------------------
resource "aws_route" "to-internet" {
  route_table_id         = aws_route_table.to-internet.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc-igw.id
  depends_on             = [aws_internet_gateway.vpc-igw]
}

resource "aws_route_table" "to-internet" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc-igw.id
  }
  tags = {
    Name  = upper("myteslamate-to-internet")
    Owner = var.owner
  }
  lifecycle {
    ignore_changes = [
      route
    ]
  }
}

// -----------------------------------------------------------------------------------------------------
// Assign APP subnets to Internet
// -----------------------------------------------------------------------------------------------------
resource "aws_route_table_association" "app-route-table-association" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.to-internet.id
}


resource "aws_route_table_association" "app-ha-route-table-association" {
  subnet_id      = aws_subnet.subnet-ha.id
  route_table_id = aws_route_table.to-internet.id
}

resource "aws_route_table_association" "app-tier-route-table-association" {
  subnet_id      = aws_subnet.subnet-tier.id
  route_table_id = aws_route_table.to-internet.id
}