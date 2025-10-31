# Set up VPC Flow Logs to monitor network traffic for security purposes

# Create a CloudWatch log group with 7-day retention to keep costs low
resource "aws_cloudwatch_log_group" "vpc_flow_logs" {
  count             = var.enable_vpc_flow_logs && var.enable_cloudwatch_logs ? 1 : 0
  name              = "/aws/vpc/flow-logs-${var.environment}"
  retention_in_days = 7

  tags = var.tags
}

# CloudWatch logging is disabled to save money - uncomment if you need real-time monitoring
# resource "aws_flow_log" "vpc_flow_logs_cw" {
#   count                = var.enable_vpc_flow_logs && var.enable_cloudwatch_logs ? 1 : 0
#   log_destination      = aws_cloudwatch_log_group.vpc_flow_logs[0].arn
#   iam_role_arn         = var.vpc_flow_logs_role_arn
#   traffic_type         = "REJECT"
#   vpc_id               = data.aws_vpc.default.id
#   log_destination_type = "cloud-watch-logs"
#   tags = var.tags
# }

# Send VPC flow logs to S3, but only log rejected traffic to save storage costs
resource "aws_flow_log" "vpc_flow_logs_s3" {
  count                = var.enable_vpc_flow_logs && var.enable_s3_logs ? 1 : 0
  log_destination      = "arn:aws:s3:::${var.s3_bucket_name}/vpc-flow-logs/"
  traffic_type         = "REJECT"
  vpc_id               = data.aws_vpc.default.id
  log_destination_type = "s3"

  tags = var.tags
}

# Get information about the default VPC in this AWS account
data "aws_vpc" "default" {
  default = true
}

# Automatically delete old VPC flow logs from S3 after 30 days to control storage costs
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