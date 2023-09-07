// Fetching our custom Centos AMI
// Must exist in the account prior to create any Ec2 

data "aws_ami" "centos-ami" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.ami-name-to-search]
    //values = ["ami-080929c787dc91299"]
  }

  owners = ["self", "amazon", "aws-marketplace", "774944014867"]
}

/*
locals {
  user_data = templatefile("./user-data.tftpl", { timezone = var.timezone, region = var.region })
}

resource "aws_launch_template" "launch-template" {
  name          = "MyTeslaMate-${random_string.grpsuffix.result}"
  image_id      = data.aws_ami.centos-ami.id
  instance_type = var.instance_type

  iam_instance_profile {
    name = aws_iam_instance_profile.instance-profile.id
  }
  vpc_security_group_ids = [aws_security_group.main-access.id, aws_security_group.app-access.id]
  //user_data              = textencodebase64(local.user_data, "UTF-8")

  user_data = <<EOF
Content-Type: multipart/mixed; boundary="frontier"
MIME-Version: 1.0

--frontier
Content-Type: text/cloud-config
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cloud-config.txt"

#cloud-config
timezone: '${var.timezone}'
output : { all : '| tee -a /var/log/cloud-init-output.log' }
system_info:
  default_user:
    name: ec2-user
    lock_passwd: true
    gecos: Cloud User
    groups: [wheel, adm, systemd-journal]
    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
    shell: /bin/bash
  distro: rhel
  paths:
    cloud_dir: /var/lib/cloud
    templates_dir: /etc/cloud/templates
  ssh_svcname: sshd

--frontier
Content-Type: text/x-shellscript; charset=us-ascii
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="user-script.txt"

#!/bin/bash
echo ++++++++++++++++++++++++++++++++++
echo ++++++ Welcome in USER DATA ++++++
echo ++++++++++++++++++++++++++++++++++

echo ++++++++++++++++++++++++++++++++++
echo ++ End                          ++
echo ++++++++++++++++++++++++++++++++++
exit $RC
--frontier--
EOF

  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_type = "gp2"
      volume_size = "550"
      encrypted   = true
    }
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name        = "MyTeslaMate"
      VPC         = "MyTeslaMate"
      Environment = "MyTeslaMate"
      Owner       = var.owner

    }
  }

  tag_specifications {
    resource_type = "volume"

    tags = {
      Name        = "MyTeslaMate"
      VPC         = "MyTeslaMate"
      Environment = "MyTeslaMate"
      Owner       = var.owner
    }
  }

}

resource "aws_autoscaling_group" "autoscaling-group" {
  name_prefix         = "MyTeslaMate-${random_string.grpsuffix.result}"
  vpc_zone_identifier = [aws_subnet.subnet.id, aws_subnet.subnet-ha.id]
  launch_template {
    id      = aws_launch_template.launch-template.id
    version = "$Latest"
  }
  min_size = 0
  max_size = 1

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [launch_configuration]
  }

  tag {
    key                 = "Name"
    value               = "MyTeslaMate"
    propagate_at_launch = true
  }
  tag {
    key                 = "VPC"
    value               = "MyTeslaMate"
    propagate_at_launch = true
  }
  tag {
    key                 = "Owner"
    value               = var.owner
    propagate_at_launch = true
  }
}
*/

resource "aws_instance" "myteslamate" {
  ami                         = data.aws_ami.centos-ami.id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.instance-profile.id
  subnet_id                   = aws_subnet.subnet.id
  vpc_security_group_ids      = [aws_security_group.main-access.id]
  //key_name = data.aws_ssm_parameter.bastion-key-name.value

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      //user_data,
      //instance_type
    ]
  }

  tags = {
    Name        = "MyTeslaMate"
    VPC         = "MyTeslaMate"
    Environment = "MyTeslaMate"
    Owner       = var.owner
  }

  user_data = <<EOF
Content-Type: multipart/mixed; boundary="frontier"
MIME-Version: 1.0

--frontier
Content-Type: text/cloud-config
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cloud-config.txt"

#cloud-config
timezone: '${var.timezone}'
output : { all : '| tee -a /var/log/cloud-init-output.log' }
system_info:
  default_user:
    name: ec2-user
    lock_passwd: true
    gecos: Cloud User
    groups: [wheel, adm, systemd-journal]
    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
    shell: /bin/bash
  distro: rhel
  paths:
    cloud_dir: /var/lib/cloud
    templates_dir: /etc/cloud/templates
  ssh_svcname: sshd

--frontier
Content-Type: text/x-shellscript; charset=us-ascii
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="user-script.txt"

#!/bin/bash
echo ++++++++++++++++++++++++++++++++++
echo ++++++ Welcome in USER DATA ++++++
echo ++++++++++++++++++++++++++++++++++

echo ++++++++++++++++++++++++++++++++++
echo ++ End                          ++
echo ++++++++++++++++++++++++++++++++++
exit $RC
--frontier--
EOF

}

