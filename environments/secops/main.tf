module "security_alerts" {
  source      = "./modules/alerts"
  environment = var.environment
  alert_email = var.alert_email
}

module "iam_roles" {
  source      = "./modules/iam_roles"
  environment = var.environment
}

module "logging" {
  source                 = "./modules/logging"
  environment            = var.environment
  vpc_flow_logs_role_arn = module.iam_roles.vpc_flow_logs_role_arn
}

module "monitoring" {
  source                     = "./modules/monitoring"
  environment                = var.environment
  config_role_arn            = module.iam_roles.config_role_arn
  config_aggregator_role_arn = module.iam_roles.config_aggregator_role_arn
  s3_bucket_name             = module.logging.cloudtrail_logs_bucket_name
}

module "remediation" {
  source                      = "./modules/remediation"
  environment                 = var.environment
  remediation_lambda_role_arn = module.iam_roles.remediation_lambda_role_arn
}