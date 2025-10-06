output "cloudtrail_logs_bucket_arn" {
  description = "ARN of the CloudTrail logs S3 bucket"
  value       = aws_s3_bucket.cloudtrail_logs.arn
}

output "cloudtrail_logs_bucket_name" {
  description = "Name of the CloudTrail logs S3 bucket"
  value       = aws_s3_bucket.cloudtrail_logs.bucket
}

output "vpc_flow_logs_log_group_arn" {
  description = "ARN of the CloudWatch Log Group for VPC Flow Logs"
  value       = aws_cloudwatch_log_group.vpc_flow_logs.arn
}

output "vpc_flow_logs_cw_id" {
  description = "ID of the VPC Flow Log for CloudWatch"
  value       = aws_flow_log.vpc_flow_logs_cw.id
}

output "vpc_flow_logs_s3_id" {
  description = "ID of the VPC Flow Log for S3"
  value       = aws_flow_log.vpc_flow_logs_s3.id
}