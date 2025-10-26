# CloudWatch Alarm for high GuardDuty findings
resource "aws_cloudwatch_metric_alarm" "guardduty_high_findings" {
  alarm_name          = "${var.environment}-guardduty-high-findings"
  alarm_description   = "Alerts when GuardDuty detects high severity findings"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "TotalFindings"
  namespace           = "AWS/GuardDuty"
  period              = 300
  statistic           = "Sum"
  threshold           = 0
  alarm_actions       = [aws_sns_topic.security_alerts.arn]

  dimensions = {
    Severity = "High"
  }

  tags = var.tags
}