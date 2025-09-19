resource "aws_s3_bucket" "this" {
  bucket = "${var.project_name}-${var.environment}-site"
  acl    = "private"

  tags = {
    Name        = "${var.project_name}-${var.environment}-site"
    Environment = var.environment
  }
}

# Enable static website hosting
resource "aws_s3_bucket_website_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# Block public ACLs (security best practice)
resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
