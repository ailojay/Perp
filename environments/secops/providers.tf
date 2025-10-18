terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.14"
    }
  }
}

# Single provider - everything deploys to us-east-1
provider "aws" {
  region = "us-east-1"
}