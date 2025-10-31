# Production Backend Configuration
# NOTE: Commented out since prod environment is not deployed
# Uncomment when production AWS account is available

# terraform {
#   backend "s3" {
#     bucket = "perp-terraform-state-prod"
#     key    = "prod/terraform.tfstate"
#     region = "us-east-1"
#     encrypt = true
#     
#     # DynamoDB table for state locking
#     dynamodb_table = "perp-terraform-locks-prod"
#   }
# }