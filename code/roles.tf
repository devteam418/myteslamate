// -----------------------------------------------------------------------------------------------------
// Add here in the list the arn of the Managed Policy you wanna add to your Jenkins instance.
// -----------------------------------------------------------------------------------------------------
data "aws_caller_identity" "current" {
  // The AWS account information
}

locals {
  managed-policies-4-roles = [
    //"arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM", 
    //"arn:aws:iam::aws:policy/AmazonEC2FullAccess", // Allow slave to manage its ec2
    //"arn:aws:iam::aws:policy/AmazonRoute53AutoNamingFullAccess", // Allow Slave to delete and recreate its recordset in Route53
    //"arn:aws:iam::aws:policy/AmazonRoute53ReadOnlyAccess", // Allow Slave to delete and recreate its recordset in Route53
    //"arn:aws:iam::${data.aws_caller_identity.current.id}:policy/AllowECRFull",  // Allow Slave to pull/push our DXC.GT Docker images
    //"arn:aws:iam::aws:policy/AmazonS3FullAccess", // Allow Slave to copy files from s3 to s3
    "arn:aws:iam::aws:policy/AmazonSSMFullAccess", // Allow Slave to execute SSM RunCommand
    //"arn:aws:iam::aws:policy/AmazonRDSFullAccess", // Allow Slave to stop/start RDS
    "arn:aws:iam::aws:policy/AdministratorAccess", // Allow Slave to run Terraform create / remove ...
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