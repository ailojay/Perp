terraform {
  backend "s3" {
    bucket         = "prod-secops-state"
    key            = "global/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "perp-secops-state-lock"
    encrypt        = true
  }
}
