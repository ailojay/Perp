terraform {
  backend "s3" {
    bucket       = "perp-secops-state"
    key          = "secops/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}