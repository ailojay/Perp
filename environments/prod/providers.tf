# terraform {
#   required_version = ">= 1.5.0"
#   
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 5.0"
#     }
#   }
#   
#   # Production would use remote state management
#   # backend "s3" {
#   #   bucket = "perp-terraform-state-prod"
#   #   key    = "prod/terraform.tfstate"
#   #   region = "us-east-1"
#   #   encrypt = true
#   # }
# }

# provider "aws" {
#   region = var.region
#   
#   default_tags {
#     tags = {
#       Project     = "perp"
#       Environment = "prod"
#       ManagedBy   = "terraform"
#       CostCenter  = "production"
#     }
#   }
# }