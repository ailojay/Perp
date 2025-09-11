terraform {
  backend "s3" {
    bucket         = "perp-tfstate-dev"
    key            = "myproject/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "perp-locks"
    encrypt        = true
  }
}