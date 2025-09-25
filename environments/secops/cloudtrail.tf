# Fetch the current AWS account ID
data "aws_caller_identity" "current" {}

# Creates the central logging bucket
resource "aws_s3_bucket" "cloudtrail_logs" {
  bucket        = "perp-org-logs"
  force_destroy = false

  tags = {
    Name        = "CloudTrail Logs"
    Environment = "SecOps"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
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

# Attach the bucket policy
resource "aws_s3_bucket_policy" "cloudtrail_logs" {
  bucket = aws_s3_bucket.cloudtrail_logs.id

  policy = templatefile("${path.module}/policies/s3-bucket/cloudtrail_logs.json", {
    bucket_name = aws_s3_bucket.cloudtrail_logs.bucket
    account_id  = data.aws_caller_identity.current.account_id
  })
}
