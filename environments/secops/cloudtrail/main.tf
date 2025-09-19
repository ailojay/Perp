# Data source to get the current account ID
data "aws_caller_identity" "current" {}


# Creates the central logging bucket
resource "aws_s3_bucket" "cloudtrail_logs" {
  bucket        = "perp-org-cloudtrail-logs-${data.aws_caller_identity.current.account_id}" # Unique name
  force_destroy = false

  tags = {
    Name        = "CloudTrail Logs"
    Environment = "SecOps"
  }
}

# Blocks all public access to the bucket
resource "aws_s3_bucket_public_access_block" "cloudtrail_logs" {
  bucket = aws_s3_bucket.cloudtrail_logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Attached the policy from my policy file to the bucket
resource "aws_s3_bucket_policy" "cloudtrail_logs" {
  bucket = aws_s3_bucket.cloudtrail_logs.id

  # Used templatefile() to render the JSON and inject variables
  policy = templatefile("${path.module}/../../../policies/s3-bucket/cloudtrail_logs.json", {
    bucket_name = aws_s3_bucket.cloudtrail_logs.bucket
    account_id  = data.aws_caller_identity.current.account_id
  })
}

# KMS key for encrypting CloudTrail logs

resource "aws_kms_key" "cloudtrail" {
  description             = "KMS key for encrypting CloudTrail logs"
  deletion_window_in_days = 30
  enable_key_rotation     = true
  policy = templatefile("${path.module}/../../../policies/kms/cloudtrail_key.json", {
    account_id = data.aws_caller_identity.current.account_id
  })
}

resource "aws_kms_alias" "cloudtrail" {
  name          = "alias/cloudtrail-key"
  target_key_id = aws_kms_key.cloudtrail.key_id
}