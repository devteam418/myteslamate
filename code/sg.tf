
// -----------------------------------------------------------------------------------------------------
// The Main Entry Security Group.
// Allowed IPs are added dynamically (see allowed-ip-map variable).
// Port is defined by teslamate-port variable.
// -----------------------------------------------------------------------------------------------------
resource "aws_security_group" "main-access" {
  name        = "myteslamate-main-access-${random_string.sgsuffix.result}"
  description = "Allowing TeslaMate connexion"
  vpc_id      = aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = var.allowed-ip-map
    content {
      from_port   = var.teslamate-port
      to_port     = var.teslamate-port
      protocol    = "tcp"
      cidr_blocks = ["${ingress.value}/32"]
      description = "Allow ${ingress.key} to TeslaMate"
    }
  }

  dynamic "ingress" {
    for_each = var.allowed-ip-map
    content {
      from_port   = var.grafana-port
      to_port     = var.grafana-port
      protocol    = "tcp"
      cidr_blocks = ["${ingress.value}/32"]
      description = "Allow ${ingress.key} to Grafana."
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name  = upper("myteslamate-main-access")
    Owner = var.owner
  }
}
