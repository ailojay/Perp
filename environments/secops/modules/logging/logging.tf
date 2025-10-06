# ==============================
# VPC Flow Logs - Logging Setup
# ==============================

# CloudWatch Log Group for Flow Logs
resource "aws_cloudwatch_log_group" "vpc_flow_logs" {
  name              = "/aws/vpc/flow-logs-${var.environment}"
  retention_in_days = 7
}

# Enables VPC Flow Logs (CloudWatch)
resource "aws_flow_log" "vpc_flow_logs_cw" {
  log_destination      = aws_cloudwatch_log_group.vpc_flow_logs.arn
  iam_role_arn         = var.vpc_flow_logs_role_arn
  traffic_type         = "ALL"
  vpc_id               = data.aws_vpc.default.id
  log_destination_type = "cloud-watch-logs"
}

# Enables VPC Flow Logs (S3)
resource "aws_flow_log" "vpc_flow_logs_s3" {
  log_destination      = "arn:aws:s3:::perp-org-logs/vpc-flow-logs/"
  traffic_type         = "ALL"
  vpc_id               = data.aws_vpc.default.id
  log_destination_type = "s3"
}

# Data source: default VPC
data "aws_vpc" "default" {
  default = true
}

# Lifecycle rule for VPC Flow Logs in S3
resource "aws_s3_bucket_lifecycle_configuration" "vpc_flow_logs" {
  bucket = "perp-org-logs"

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