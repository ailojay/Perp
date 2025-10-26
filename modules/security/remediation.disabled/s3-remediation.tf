resource "aws_lambda_function" "s3_public_bucket_fixer" {
  filename      = "${path.module}/lambdas/s3_public_bucket_fixer.zip"
  function_name = "${var.environment}-s3-public-bucket-fixer"
  handler       = "s3_public_bucket_fixer.lambda_handler"
  runtime       = var.lambda_runtime
  role          = var.remediation_lambda_role_arn
  timeout       = var.lambda_timeout
  memory_size   = var.lambda_memory_size
  # source_code_hash = filebase64sha256("${path.module}/lambdas/s3_public_bucket_fixer.zip")

  dead_letter_config {
    target_arn = aws_sqs_queue.remediation_dlq.arn
  }

  tags = var.tags
}

resource "aws_cloudwatch_log_group" "s3_lambda_logs" {
  name              = "/aws/lambda/${var.environment}-s3-public-bucket-fixer"
  retention_in_days = var.log_retention_days

  tags = var.tags
}

resource "aws_cloudwatch_event_rule" "s3_public_event_rule" {
  name        = "${var.environment}-s3-public-bucket-remediation-rule"
  description = "Triggers when Security Hub reports public S3 buckets"

  event_pattern = jsonencode({
    source      = ["aws.securityhub"]
    detail-type = ["Security Hub Findings - Imported"]
    detail = {
      findings = {
        ProductFields = {
          "aws/securityhub/SeverityLabel" = ["HIGH", "CRITICAL"]
        }
        Title = [{
          prefix = "S3 Bucket"
        }]
      }
    }
  })

  tags = var.tags
}

resource "aws_cloudwatch_event_target" "s3_lambda_target" {
  rule      = aws_cloudwatch_event_rule.s3_public_event_rule.name
  target_id = "${var.environment}-S3PublicBucketFixer"
  arn       = aws_lambda_function.s3_public_bucket_fixer.arn

  retry_policy {
    maximum_retry_attempts       = 3
    maximum_event_age_in_seconds = 300
  }
}

resource "aws_lambda_permission" "allow_eventbridge_s3" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.s3_public_bucket_fixer.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.s3_public_event_rule.arn
}