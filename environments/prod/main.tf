# Production Environment - Enterprise Architecture Showcase
# NOTE: This demonstrates production patterns but is not deployed (no AWS account)
# All testing is done in dev account to save costs
# Uncomment when production AWS account is available

# module "network" {
#   source = "../../modules/infrastructure/network"
#   
#   project_name = var.project_name
#   environment  = "prod"
#   cidr_block   = "10.2.0.0/16"  # Different CIDR from dev
#   
#   # Production gets enhanced networking
#   enable_nat_gateway = true
#   multi_az_subnets = true
# }

# module "compute" {
#   source = "../../modules/infrastructure/compute"
#   
#   project_name      = var.project_name
#   environment       = "prod"
#   instance_type     = "t3.medium"  # Larger than dev
#   subnet_id         = module.network.private_subnet_ids[0]
#   security_group_id = module.network.app_security_group_id
# }

# module "storage" {
#   source = "../../modules/infrastructure/storage"
#   
#   project_name = var.project_name
#   environment  = "prod"
#   
#   # Production gets enhanced backup and versioning
#   backup_enabled = true
#   versioning_enabled = true
# }

# # Production would have full security features enabled
# module "security" {
#   source = "../../modules/security/detection"
#   
#   environment = "prod"
#   
#   # All GuardDuty features for production
#   enable_s3_protection      = true
#   enable_malware_protection = true
#   enable_runtime_monitoring = true
# }

# module "monitoring" {
#   source = "../../modules/security/monitoring"
#   
#   environment = "prod"
#   alert_email = var.alert_email
#   
#   # Enhanced monitoring for production
#   enable_detailed_monitoring = true
#   alert_threshold = "low"  # More sensitive alerts
# }