terraform {
  backend "s3" {
    bucket         = "perp-prod-state"
    key            = "global/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "perp-prod-state-lock"
    encrypt        = true
  }
}
