resource "aws_lambda_function" "s3_public_bucket_fixer" {
  filename         = "${path.module}/lambdas/s3_public_bucket_fixer.zip"
  function_name    = "${var.environment}-s3-public-bucket-fixer"
  handler          = "handler.lambda_handler"
  runtime          = "python3.12"
  role             = var.remediation_lambda_role_arn
  timeout          = 30
  memory_size      = 256
  source_code_hash = filebase64sha256("${path.module}/lambdas/s3_public_bucket_fixer.zip")
}

resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = "/aws/lambda/${var.environment}-s3-public-bucket-fixer"
  retention_in_days = 14
}

resource "aws_cloudwatch_event_rule" "s3_public_event_rule" {
  name        = "${var.environment}-s3-public-bucket-remediation-rule"
  description = "Triggers when Security Hub reports public S3 buckets"
  event_pattern = <<EOT
{
  "source": ["aws.securityhub"],
  "detail-type": ["Security Hub Findings - Imported"],
  "detail": {
    "findings": {
      "ProductFields": {
        "aws/securityhub/SeverityLabel": ["HIGH", "CRITICAL"]
      },
      "Title": [{"prefix": "S3 Bucket"}]
    }
  }
}
EOT
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.s3_public_event_rule.name
  target_id = "${var.environment}-S3PublicBucketFixer"
  arn       = aws_lambda_function.s3_public_bucket_fixer.arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.s3_public_bucket_fixer.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.s3_public_event_rule.arn
}