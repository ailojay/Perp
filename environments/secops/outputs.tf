# Security Alerts
output "alerts_sns_topic_arn" {
  value = module.security_alerts.sns_topic_arn
}

output "alerts_sns_topic_name" {
  value = module.security_alerts.sns_topic_name
}

# AWS Config
output "config_role_arn" {
  value = module.iam_roles.config_role_arn
}

output "config_aggregator_role_arn" {
  value = module.iam_roles.config_aggregator_role_arn
}

output "vpc_flow_logs_role_arn" {
  value = module.iam_roles.vpc_flow_logs_role_arn
}