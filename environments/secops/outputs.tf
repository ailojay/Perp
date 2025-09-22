output "cloudtrail_bucket_name" {
  value = aws_s3_bucket.cloudtrail_logs.bucket
}

output "kms_key_arn" {
  value = aws_kms_key.cloudtrail.arn
}