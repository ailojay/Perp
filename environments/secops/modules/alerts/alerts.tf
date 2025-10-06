# SNS Topic for Security Alerts
   resource "aws_sns_topic" "security_alerts" {
     name = "security-alerts"
   }

   # Topic subscription (email). Confirm the subscription via email.
   resource "aws_sns_topic_subscription" "email_sub" {
     topic_arn = aws_sns_topic.security_alerts.arn
     protocol  = "email"
     endpoint  = var.alert_email
   }

   # SNS Topic policy allows EventBridge to publish
   resource "aws_sns_topic_policy" "security_alerts_policy" {
     arn    = aws_sns_topic.security_alerts.arn
     policy = file("${path.root}/policies/sns/allow_eventbridge_publish.json")
   }

   # ============================
   # EventBridge Rules
   # ============================

   # Security Hub Findings (filter only HIGH & CRITICAL severities)
   resource "aws_cloudwatch_event_rule" "securityhub_findings" {
     name        = "${var.environment}-securityhub-high-critical-findings"
     description = "Forward only HIGH/CRITICAL Security Hub findings to SNS"
     event_pattern = jsonencode({
       "source" : ["aws.securityhub"],
       "detail-type" : ["Security Hub Findings - Imported"],
       "detail" : {
         "findings" : {
           "Severity" : {
             "Label" : ["HIGH", "CRITICAL"]
           }
         }
       }
     })
   }

   # ============================
   # EventBridge Targets
   # ============================

   resource "aws_cloudwatch_event_target" "securityhub_to_sns" {
     rule      = aws_cloudwatch_event_rule.securityhub_findings.name
     target_id = "securityhub-sns"
     arn       = aws_sns_topic.security_alerts.arn

     input_transformer {
       input_paths = {
         "detail" = "$.detail"
       }
       input_template = <<-EOT
       {
         "source": "SecurityHub",
         "severity": "HIGH/CRITICAL",
         "detail": <detail>
       }
       EOT
     }
   }