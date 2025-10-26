output "compliance_status" {
  value = "AWS Config and Security Hub enabled in secops account"
}

output "config_bucket" {
  value = "perp-org-logs"
}

output "config_service_role" {
  description = "AWS Config service-linked role details"
  value = {
    arn  = module.compliance.config_service_role_arn
    name = module.compliance.config_service_role_name
  }
}

output "config_components" {
  description = "Details of all AWS Config components"
  value = {
    recorder_status = module.compliance.config_recorder_status
    aggregator_name = module.compliance.config_aggregator_name
    config_rules    = module.compliance.config_rules
  }
}

output "guardduty_detector" {
  description = "GuardDuty detector details"
  value = {
    id  = module.detection.guardduty_detector_id
    arn = module.detection.guardduty_detector_arn
  }
}

output "guardduty_filter" {
  description = "GuardDuty high severity filter name"
  value       = module.detection.guardduty_filter_name
}

output "monitoring_sns_topic" {
  description = "Security alerts SNS topic details"
  value = {
    arn  = module.monitoring.sns_topic_arn
    name = module.monitoring.sns_topic_name
  }
}

output "monitoring_alarms" {
  description = "Security monitoring alarms and rules"
  value = {
    guardduty_alarm   = module.monitoring.guardduty_alarm_name
    eventbridge_rules = module.monitoring.eventbridge_rules
  }
}

output "logging_details" {
  description = "VPC Flow Logs configuration"
  value = {
    cloudwatch_group = module.logging.vpc_flow_logs_cloudwatch_group
    s3_destination   = module.logging.vpc_flow_logs_s3_destination
    vpc_id           = module.logging.vpc_id
  }
}

output "remediation_functions" {
  description = "Automated remediation functions"
  value = {
    s3_remediation   = module.remediation.s3_remediation
    ec2_remediation  = module.remediation.ec2_remediation
    common_resources = module.remediation.common_resources
  }
}

output "iam_roles" {
  description = "IAM roles created for SecOps"
  value = {
    config_role_arn              = module.iam_roles.config_role_arn
    vpc_flow_logs_role_arn       = module.iam_roles.vpc_flow_logs_role_arn
    remediation_lambda_role_arn  = module.iam_roles.remediation_lambda_role_arn
    break_glass_admin_role_arn   = module.iam_roles.break_glass_admin_role_arn
    security_operations_role_arn = module.iam_roles.security_operations_role_arn
  }
}
