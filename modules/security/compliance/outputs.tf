output "config_service_role_arn" {
  description = "ARN of the AWS Config service-linked role"
  value       = data.aws_iam_role.config_service_role.arn
}

output "config_service_role_name" {
  description = "Name of the AWS Config service-linked role"
  value       = data.aws_iam_role.config_service_role.name
}

output "config_recorder_status" {
  description = "Status of the AWS Config recorder"
  value       = aws_config_configuration_recorder_status.main.is_enabled
}

output "config_aggregator_name" {
  description = "Name of the AWS Config aggregator"
  value       = aws_config_configuration_aggregator.org.name
}

output "config_rules" {
  description = "List of AWS Config rules created"
  value = [
    aws_config_config_rule.s3_encryption.name,
    aws_config_config_rule.cloudtrail_enabled.name,
    aws_config_config_rule.root_access_key.name,
    aws_config_config_rule.mfa_enabled.name,
    aws_config_config_rule.restricted_ssh.name,
    aws_config_config_rule.ec2_volume_inuse.name
  ]
}

# Security Hub Outputs
output "security_hub_arn" {
  description = "ARN of the Security Hub instance"
  value       = aws_securityhub_account.main.arn
}

output "security_hub_standards" {
  description = "List of enabled Security Hub standards"
  value = [
    aws_securityhub_standards_subscription.cis.standards_arn,
    aws_securityhub_standards_subscription.aws_foundational.standards_arn
  ]
}

output "security_hub_finding_aggregator" {
  description = "Security Hub finding aggregator configuration"
  value       = aws_securityhub_finding_aggregator.org_aggregator.linking_mode
}

output "security_hub_regions" {
  description = "Regions monitored by Security Hub"
  value       = var.security_hub_regions
}
