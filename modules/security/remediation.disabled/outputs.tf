output "s3_remediation" {
  description = "S3 remediation outputs"
  value = {
    lambda_arn       = aws_lambda_function.s3_public_bucket_fixer.arn
    lambda_name      = aws_lambda_function.s3_public_bucket_fixer.function_name
    eventbridge_rule = aws_cloudwatch_event_rule.s3_public_event_rule.name
  }
}

output "ec2_remediation" {
  description = "EC2 remediation outputs"
  value = {
    lambda_arn       = aws_lambda_function.ec2_security_group_remediation.arn
    lambda_name      = aws_lambda_function.ec2_security_group_remediation.function_name
    eventbridge_rule = aws_cloudwatch_event_rule.ec2_security_group_rule.name
  }
}

output "common_resources" {
  description = "Common remediation resources"
  value = {
    dlq_arn = aws_sqs_queue.remediation_dlq.arn
  }
}