terraform {
  backend "s3" {
    bucket       = "perp-prod-state"
    key          = "global/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}