module "network" {
  source       = "../../modules/network"
  project_name = var.project_name
  environment  = var.environment
  cidr_block   = "0.0.0.0/16"
}

module "compute" {
  source            = "../../modules/compute"
  project_name      = var.project_name
  environment       = var.environment
  instance_type     = var.instance_type
  subnet_id         = module.network.public_subnet_id
  security_group_id = module.network.security_group_id
  region            = var.region
}