terraform {
  backend "s3" {
    bucket         = "perp-prod-tfstate-bucket"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "perp-prod-tf-locks"
    encrypt        = true
  }
}
