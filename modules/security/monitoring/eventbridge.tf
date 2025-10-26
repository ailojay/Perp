# Security Hub Findings (HIGH & CRITICAL only)
resource "aws_cloudwatch_event_rule" "securityhub_findings" {
  name        = "${var.environment}-securityhub-high-critical-findings"
  description = "Forward HIGH/CRITICAL Security Hub findings to SNS"

  event_pattern = jsonencode({
    source      = ["aws.securityhub"]
    detail-type = ["Security Hub Findings - Imported"]
    detail = {
      findings = {
        Severity = {
          Label : ["HIGH", "CRITICAL"]
        }
      }
    }
  })
}

# GuardDuty Findings (MEDIUM and above)
resource "aws_cloudwatch_event_rule" "guardduty_findings" {
  name        = "${var.environment}-guardduty-findings"
  description = "Forward GuardDuty findings to SNS"

  event_pattern = jsonencode({
    source      = ["aws.guardduty"]
    detail-type = ["GuardDuty Finding"]
    detail = {
      severity = [4, 5, 6, 7, 8, 9] # Medium and above
    }
  })
}

# EventBridge Targets
resource "aws_cloudwatch_event_target" "securityhub_to_sns" {
  rule      = aws_cloudwatch_event_rule.securityhub_findings.name
  target_id = "SecurityHubToSNS"
  arn       = aws_sns_topic.security_alerts.arn
}

resource "aws_cloudwatch_event_target" "guardduty_to_sns" {
  rule      = aws_cloudwatch_event_rule.guardduty_findings.name
  target_id = "GuardDutyToSNS"
  arn       = aws_sns_topic.security_alerts.arn
}