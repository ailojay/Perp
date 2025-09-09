terraform {
  backend "s3" {
    bucket         = var.state_bucket
    key            = "${var.project_name}/${var.environment}/terraform.tfstate"
    region         = var.region
    dynamodb_table = "perp-locks"
    encrypt        = true
  }
}