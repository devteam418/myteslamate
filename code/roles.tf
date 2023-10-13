// -----------------------------------------------------------------------------------------------------
// Add here in the list the arn of the Managed Policy you wanna add to your instance.
// -----------------------------------------------------------------------------------------------------
data "aws_caller_identity" "current" {
  // The AWS account information if needed.
}

locals {
  managed-policies-4-roles = [
    "arn:aws:iam::aws:policy/AmazonSSMFullAccess", // Allows SSM RunCommand / Run Session
    "arn:aws:iam::aws:policy/AdministratorAccess", // Beware : You can do what ever you want from this machine.
  ]
}


// -----------------------------------------------------------------------------------------------------
resource "aws_iam_role_policy_attachment" "role-policy-attachment" {
  count      = length(local.managed-policies-4-roles)
  role       = aws_iam_role.role.name
  policy_arn = local.managed-policies-4-roles[count.index]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_role" "role" {
  name               = "MyTeslaMate-role"
  assume_role_policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
{
"Effect": "Allow",
"Principal": {
"Service": [ "ec2.amazonaws.com" ]
},
"Action": [ "sts:AssumeRole" ],
"Sid": ""
}
]
}
EOF
  path               = "/MyTeslaMate/"
  tags = {
    VPC         = "MyTeslaMate"
    Environment = "MyTeslaMate"
    Owner       = var.owner
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_instance_profile" "instance-profile" {
  name = "MyTeslaMate-instance-profile"
  role = aws_iam_role.role.name
  path = "/MyTeslaMate/"
}