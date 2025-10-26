output "guardduty_detector_id" {
  description = "ID of the GuardDuty detector"
  value       = local.detector_id
}

output "guardduty_detector_arn" {
  description = "ARN of the GuardDuty detector"
  value       = data.aws_guardduty_detector.existing.arn
}

output "guardduty_filter_name" {
  description = "Name of the high severity threats filter"
  value       = aws_guardduty_filter.high_severity_threats.name
}