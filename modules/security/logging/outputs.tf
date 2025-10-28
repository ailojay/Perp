output "vpc_flow_logs_cloudwatch_group" {
  description = "CloudWatch log group for VPC Flow Logs"
  value       = var.enable_vpc_flow_logs && var.enable_cloudwatch_logs && length(aws_cloudwatch_log_group.vpc_flow_logs) > 0 ? aws_cloudwatch_log_group.vpc_flow_logs[0].name : null
}

output "vpc_flow_logs_s3_destination" {
  description = "S3 destination for VPC Flow Logs"
  value       = var.enable_s3_logs ? "arn:aws:s3:::${var.s3_bucket_name}/vpc-flow-logs/" : null
}

output "vpc_id" {
  description = "VPC ID being monitored"
  value       = data.aws_vpc.default.id
}