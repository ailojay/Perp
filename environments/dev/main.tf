module "network" {
  source            = "../../modules/network"
  project_name      = var.project_name
  environment       = var.environment
  ssh_allowed_ip    = var.ssh_allowed_ip
  cidr_block        = var.cidr_block
}

module "compute" {
  source            = "../../modules/compute"
  project_name      = var.project_name
  environment       = var.environment
  instance_type     = var.instance_type
  subnet_id         = module.network.public_subnet_id
  security_group    = module.network.security_group
  ssh_key_name      = var.ssh_key_name
}