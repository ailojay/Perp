data "aws_caller_identity" "current" {}
data "aws_organizations_organization" "this" {}

# S3 Bucket for CloudTrail logs
resource "aws_s3_bucket" "cloudtrail_logs" {
  bucket        = var.s3_bucket_name
  force_destroy = false

  tags = var.tags
}

# S3 Bucket Encryption (AWS managed key)
resource "aws_s3_bucket_server_side_encryption_configuration" "cloudtrail_logs" {
  bucket = aws_s3_bucket.cloudtrail_logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256" # AWS managed key
    }
  }
}

# Block public access
resource "aws_s3_bucket_public_access_block" "cloudtrail_logs" {
  bucket = aws_s3_bucket.cloudtrail_logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# S3 Bucket Policy from central policies folder
resource "aws_s3_bucket_policy" "cloudtrail_logs" {
  bucket = aws_s3_bucket.cloudtrail_logs.id

  policy = templatefile("../../policies/s3-bucket/cloudtrail-logs.json", {
    bucket_arn = aws_s3_bucket.cloudtrail_logs.arn
    account_id = data.aws_caller_identity.current.account_id
    org_id     = data.aws_organizations_organization.this.id
  })
}

# Organization CloudTrail Trail
resource "aws_cloudtrail" "organization_trail" {
  name                          = var.trail_name
  s3_bucket_name                = aws_s3_bucket.cloudtrail_logs.id
  include_global_service_events = true
  is_multi_region_trail         = true
  is_organization_trail         = true
  enable_log_file_validation    = true

  tags = var.tags

  depends_on = [aws_s3_bucket_policy.cloudtrail_logs]
}