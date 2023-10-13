// -----------------------------------------------------------------------------------------------------
// Security
// -----------------------------------------------------------------------------------------------------
// Acls, not so much security here, Firewalling using SGs.
// -----------------------------------------------------------------------------------------------------
resource "aws_default_network_acl" "default-acl" {
  default_network_acl_id = aws_vpc.vpc.default_network_acl_id

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  subnet_ids = [aws_subnet.subnet.id, aws_subnet.subnet-ha.id, aws_subnet.subnet-tier.id]

  tags = {
    Name  = upper("myteslamate")
    Owner = var.owner
  }
}