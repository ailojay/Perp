# SNS Topic for Security Alerts
resource "aws_sns_topic" "security_alerts" {
  name = "security-alerts"
  tags = var.tags
}

# Topic subscription (email)
resource "aws_sns_topic_subscription" "email_sub" {
  topic_arn = aws_sns_topic.security_alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

# SNS Topic policy allows services to publish
resource "aws_sns_topic_policy" "security_alerts_policy" {
  arn    = aws_sns_topic.security_alerts.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

data "aws_iam_policy_document" "sns_topic_policy" {
  statement {
    effect    = "Allow"
    actions   = ["sns:Publish"]
    resources = [aws_sns_topic.security_alerts.arn]

    principals {
      type        = "Service"
      identifiers = ["cloudwatch.amazonaws.com", "events.amazonaws.com", "guardduty.amazonaws.com", "securityhub.amazonaws.com"]
    }
  }
}