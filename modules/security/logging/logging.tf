# VPC Flow Logs - Logging Setup

# CloudWatch Log Group for Flow Logs - Reduced retention
resource "aws_cloudwatch_log_group" "vpc_flow_logs" {
  count             = var.enable_vpc_flow_logs && var.enable_cloudwatch_logs ? 1 : 0
  name              = "/aws/vpc/flow-logs-${var.environment}"
  retention_in_days = 7

  tags = var.tags
}

# Enables VPC Flow Logs (CloudWatch) - Disabled for cost optimization
# resource "aws_flow_log" "vpc_flow_logs_cw" {
#   count                = var.enable_vpc_flow_logs && var.enable_cloudwatch_logs ? 1 : 0
#   log_destination      = aws_cloudwatch_log_group.vpc_flow_logs[0].arn
#   iam_role_arn         = var.vpc_flow_logs_role_arn
#   traffic_type         = "REJECT"
#   vpc_id               = data.aws_vpc.default.id
#   log_destination_type = "cloud-watch-logs"
#   tags = var.tags
# }

# Enables VPC Flow Logs (S3) - REJECT traffic only
resource "aws_flow_log" "vpc_flow_logs_s3" {
  count                = var.enable_vpc_flow_logs && var.enable_s3_logs ? 1 : 0
  log_destination      = "arn:aws:s3:::${var.s3_bucket_name}/vpc-flow-logs/"
  traffic_type         = "REJECT"
  vpc_id               = data.aws_vpc.default.id
  log_destination_type = "s3"

  tags = var.tags
}

# Data source: default VPC
data "aws_vpc" "default" {
  default = true
}

# Lifecycle rule for VPC Flow Logs in S3
resource "aws_s3_bucket_lifecycle_configuration" "vpc_flow_logs" {
  count  = var.enable_s3_logs ? 1 : 0
  bucket = var.s3_bucket_name

  rule {
    id     = "expire-vpc-flow-logs"
    status = "Enabled"

    filter {
      prefix = "vpc-flow-logs/"
    }

    expiration {
      days = 30
    }
  }
}