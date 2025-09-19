module "iam" {
  source           = "./iam" # This references your local iam/ subdirectory
  github_org_name  = var.github_org_name
  github_repo_name = var.github_repo_name
}

module "cloudtrail" {
  source = "./cloudtrail"
}
