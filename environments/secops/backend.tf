terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.14" # or the version you’re using
    }
  }
}

terraform {
  backend "s3" {
    bucket         = "perp-secops-state"
    key            = "secops/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "perp-secops-state-lock"
  }
}
