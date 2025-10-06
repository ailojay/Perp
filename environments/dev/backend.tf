terraform {
  backend "s3" {
    bucket         = "perp-dev-tfstate"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "perp-dev-tfstate-lock"
    encrypt        = true
  }
}
