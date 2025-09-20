terraform {
  backend "s3" {
    bucket         = "perp-secops-state-bucket"
    key            = "secops/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "perp-secops-lock-table"
    encrypt        = true
  }
}