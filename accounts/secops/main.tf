module "compliance" {
  source = "../../modules/security/compliance"
  #config
  environment           = "secops"
  config_s3_bucket_name = "perp-org-logs"
  #security hub
  security_hub_regions    = ["us-east-1"]
  enable_cis_standard     = true
  enable_aws_foundational = true

  tags = {
    Project = "perp"
    Service = "compliance"
  }
}

module "detection" {
  source = "../../modules/security/detection"

  enable_s3_protection      = var.enable_s3_protection
  enable_malware_protection = var.enable_malware_protection
  enable_runtime_monitoring = var.enable_runtime_monitoring
}

module "monitoring" {
  source = "../../modules/security/monitoring"

  environment = var.environment
  alert_email = var.alert_email

  tags = {
    Project     = "perp"
    Service     = "monitoring"
    environment = "secops"
  }
}

module "logging" {
  source = "../../modules/security/logging"

  environment            = var.environment
  s3_bucket_name         = "perp-org-logs"
  vpc_flow_logs_role_arn = module.iam_roles.vpc_flow_logs_role_arn

  tags = {
    Project = "perp"
    Service = "logging"
  }
}

module "remediation" {
  source = "../../modules/security/remediation"

  environment                 = var.environment
  remediation_lambda_role_arn = module.iam_roles.remediation_lambda_role_arn

  tags = {
    Project = "perp"
    Service = "remediation"
  }
}

module "iam_roles" {
  source = "../../modules/iam/iam_roles"

  environment = var.environment

  tags = {
    Project = "perp"
    Service = "iam"
  }
}

