module "network" {
  source       = "../../modules/network"
  project_name = var.project_name
  environment  = var.environment
  cidr_block   = var.cidr_block
}