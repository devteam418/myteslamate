// -----------------------------------------------------------------------------------------------------
// Uncomment this section to enable terraform backend tfstate sharing and backup 
// You must change the profile and region (can't use var here)
// -----------------------------------------------------------------------------------------------------
/*
terraform {
  backend "s3" {
    bucket                  = "state-backup"
    key                     = "terraform.tfstate"
    profile                 = "tumbler"
    region                  = "eu-west-3"
    dynamodb_table          = "locks-mngt"
    encrypt                 = true
    shared_credentials_file = "~/.aws/credentials"
    workspace_key_prefix    = "myteslamate"
  }
}*/