# CloudTrail Outputs
output "cloudtrail_bucket_name" {
  value = aws_s3_bucket.cloudtrail_logs.bucket
}
output "cloudtrail_bucket_arn" {
  value = aws_s3_bucket.cloudtrail_logs.arn
}

# Config Outputs
output "config_aggregator_name" {
  value = aws_config_configuration_aggregator.org.name
}

output "config_recorder_name" {
  value = aws_config_configuration_recorder.main.name
}

# VPC Flow Logs Outputs

output "vpc_flow_logs_log_group_name" {
  description = "The name of the CloudWatch Log Group for VPC Flow Logs"
  value       = aws_cloudwatch_log_group.vpc_flow_logs.name
}

output "vpc_flow_logs_log_group_arn" {
  description = "The ARN of the CloudWatch Log Group for VPC Flow Logs"
  value       = aws_cloudwatch_log_group.vpc_flow_logs.arn
}

output "vpc_flow_logs_role_arn" {
  description = "The IAM Role ARN used by VPC Flow Logs"
  value       = aws_iam_role.vpc_flow_logs_role.arn
}

output "vpc_id_logging_enabled" {
  description = "The VPC ID where flow logging is enabled"
  value       = data.aws_vpc.default.id
}


output "alerts_sns_topic_arn" {
  description = "SNS topic ARN for security alerts"
  value       = aws_sns_topic.guard_alerts.arn
}

output "alerts_sns_topic_name" {
  value = aws_sns_topic.guard_alerts.name
}

output "alerts_subscription_endpoint" {
  description = "Email endpoint subscribed for alerts"
  value       = aws_sns_topic_subscription.email_sub.endpoint
}

output "guardduty_event_rule" {
  value = aws_cloudwatch_event_rule.guardduty_findings.name
}

output "securityhub_event_rule" {
  value = aws_cloudwatch_event_rule.securityhub_findings.name
}
