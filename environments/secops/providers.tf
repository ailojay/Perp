provider "aws" {
  region = "us-east-1"
}

# Cross-account provider for SCP management in root account
provider "aws" {
  alias  = "org_root"
  region = "us-east-1"
}

data "aws_caller_identity" "current" {}