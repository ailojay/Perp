output "lambda_function_arn" {
  description = "ARN of the S3 public bucket fixer Lambda function"
  value       = aws_lambda_function.s3_public_bucket_fixer.arn
}

output "lambda_function_name" {
  description = "Name of the S3 public bucket fixer Lambda function"
  value       = aws_lambda_function.s3_public_bucket_fixer.function_name
}

output "cloudwatch_event_rule_arn" {
  description = "ARN of the CloudWatch Event Rule for S3 public bucket remediation"
  value       = aws_cloudwatch_event_rule.s3_public_event_rule.arn
}