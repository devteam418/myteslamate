
// -----------------------------------------------------------------------------------------------------
// The Main Entry Security Group.
// Allowed IPs are added dynamically (see allowed-ip-map variable).
// Port is defined by api-port variable.
// -----------------------------------------------------------------------------------------------------
resource "aws_security_group" "main-access" {
  name        = "myteslamate-main-access"
  description = "Allow API connexion"
  vpc_id      = aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = var.allowed-ip-map
    content {
      from_port   = var.api-port
      to_port     = var.api-port
      protocol    = "tcp"
      cidr_blocks = ["${ingress.value}/32"]
      description = "Allow ${ingress.key} to send requests."
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = upper("myteslamate-main-access")
    Owner = var.owner
  }
}

resource "aws_security_group" "app-access" {
  name        = "myteslamate-app-access"
  description = "Allow EC2 API connexion"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = var.api-port
    to_port     = var.api-port
    protocol    = "tcp"
    cidr_blocks = [var.cidr]
    description = "Allow API requests"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0", var.cidr]
  }

  tags = {
    Name  = upper("myteslamate-app-access")
    Owner = var.owner
  }
}