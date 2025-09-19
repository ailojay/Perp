provider "aws" {
  alias  = "secops"
  region = "us-east-1"
}

# This data source provides the current AWS account ID
data "aws_caller_identity" "current" {}