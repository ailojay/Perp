# Explicit Security Hub restriction for management account
# Since SCPs don't apply to management account, we enforce this via Terraform

# Only allow Security Hub in us-east-1
terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = "~> 5.0"
      configuration_aliases = [aws.us_east_1]
    }
  }
}

# Configure provider for us-east-1 only
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

# Security Hub in management account (us-east-1 only)
resource "aws_securityhub_account" "management" {
  provider = aws.us_east_1

  # Only enable if explicitly needed in management account
  # Default: false (Security Hub should be managed from SecOps)
  count = 0
}