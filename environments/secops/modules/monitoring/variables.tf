variable "environment" {
  description = "The environment name (e.g., secops, dev, prod)"
  type        = string
}

variable "config_role_arn" {
  description = "ARN of the IAM role for AWS Config"
  type        = string
}

variable "config_aggregator_role_arn" {
  description = "ARN of the IAM role for AWS Config Aggregator"
  type        = string
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket for AWS Config logs"
  type        = string
}