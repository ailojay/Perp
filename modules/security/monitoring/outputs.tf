output "sns_topic_arn" {
  description = "ARN of the security alerts SNS topic"
  value       = aws_sns_topic.security_alerts.arn
}

output "sns_topic_name" {
  description = "Name of the security alerts SNS topic"
  value       = aws_sns_topic.security_alerts.name
}

output "guardduty_alarm_name" {
  description = "Name of the GuardDuty high findings alarm"
  value       = aws_cloudwatch_metric_alarm.guardduty_high_findings.alarm_name
}

output "eventbridge_rules" {
  description = "EventBridge rules for security findings"
  value = {
    securityhub_rule = aws_cloudwatch_event_rule.securityhub_findings.name
    guardduty_rule   = aws_cloudwatch_event_rule.guardduty_findings.name
  }
}