resource "aws_lambda_function" "ec2_security_group_remediation" {
  filename      = "${path.module}/lambdas/ec2_security_group_remediation.zip"
  function_name = "${var.environment}-ec2-security-group-remediation"
  handler       = "ec2_handler.lambda_handler"
  runtime       = var.lambda_runtime
  role          = var.remediation_lambda_role_arn
  timeout       = var.lambda_timeout
  memory_size   = var.lambda_memory_size
  # source_code_hash = filebase64sha256("${path.module}/lambdas/ec2_security_group_remediation.zip")

  dead_letter_config {
    target_arn = aws_sqs_queue.remediation_dlq.arn
  }

  tags = var.tags
}

resource "aws_cloudwatch_log_group" "ec2_lambda_logs" {
  name              = "/aws/lambda/${var.environment}-ec2-security-group-remediation"
  retention_in_days = var.log_retention_days

  tags = var.tags
}

resource "aws_cloudwatch_event_rule" "ec2_security_group_rule" {
  name        = "${var.environment}-ec2-security-group-remediation-rule"
  description = "Triggers when Security Hub reports insecure EC2 security groups"

  event_pattern = jsonencode({
    source      = ["aws.securityhub"]
    detail-type = ["Security Hub Findings - Imported"]
    detail = {
      findings = {
        ProductFields = {
          "aws/securityhub/SeverityLabel" = ["HIGH", "CRITICAL"]
        }
        Title = [{
          prefix = "EC2 security group"
        }]
      }
    }
  })

  tags = var.tags
}

resource "aws_cloudwatch_event_target" "ec2_lambda_target" {
  rule      = aws_cloudwatch_event_rule.ec2_security_group_rule.name
  target_id = "${var.environment}-EC2SecurityGroupRemediation"
  arn       = aws_lambda_function.ec2_security_group_remediation.arn

  retry_policy {
    maximum_retry_attempts       = 3
    maximum_event_age_in_seconds = 300
  }
}

resource "aws_lambda_permission" "allow_eventbridge_ec2" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ec2_security_group_remediation.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.ec2_security_group_rule.arn
}