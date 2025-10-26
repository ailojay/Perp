# AWS Config Role Outputs
output "config_role_arn" {
  description = "ARN of the AWS Config IAM role"
  value       = aws_iam_role.config_role.arn
}

output "config_role_name" {
  description = "Name of the AWS Config IAM role"
  value       = aws_iam_role.config_role.name
}

# AWS Config Aggregator Role Outputs
output "config_aggregator_role_arn" {
  description = "ARN of the AWS Config Aggregator IAM role"
  value       = aws_iam_role.config_aggregator_role.arn
}

output "config_aggregator_role_name" {
  description = "Name of the AWS Config Aggregator IAM role"
  value       = aws_iam_role.config_aggregator_role.name
}

# VPC Flow Logs Role Outputs
output "vpc_flow_logs_role_arn" {
  description = "ARN of the VPC Flow Logs IAM role"
  value       = aws_iam_role.vpc_flow_logs_role.arn
}

output "vpc_flow_logs_role_name" {
  description = "Name of the VPC Flow Logs IAM role"
  value       = aws_iam_role.vpc_flow_logs_role.name
}

# Remediation Lambda Role Outputs
output "remediation_lambda_role_arn" {
  description = "ARN of the S3 Public Bucket Fixer Lambda IAM role"
  value       = aws_iam_role.remediation_lambda_role.arn
}

output "remediation_lambda_role_name" {
  description = "Name of the S3 Public Bucket Fixer Lambda IAM role"
  value       = aws_iam_role.remediation_lambda_role.name
}

# S3 Public Bucket Fixer Policy Outputs
output "s3_public_bucket_fixer_policy_arn" {
  description = "ARN of the S3 Public Bucket Fixer IAM policy"
  value       = aws_iam_policy.s3_public_bucket_fixer_policy.arn
}

output "s3_public_bucket_fixer_policy_name" {
  description = "Name of the S3 Public Bucket Fixer IAM policy"
  value       = aws_iam_policy.s3_public_bucket_fixer_policy.name
}

# Enterprise IAM Role Outputs
output "break_glass_admin_role_arn" {
  description = "ARN of the Break Glass Administrator role"
  value       = aws_iam_role.break_glass_admin.arn
}

output "security_operations_role_arn" {
  description = "ARN of the Security Operations role"
  value       = aws_iam_role.security_operations.arn
}

