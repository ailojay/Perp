variable "environment" {
  description = "Environment name"
  type        = string
}

variable "s3_bucket_name" {
  description = "S3 bucket name for log storage"
  type        = string
}

variable "vpc_flow_logs_role_arn" {
  description = "IAM role ARN for VPC Flow Logs"
  type        = string
}

variable "enable_vpc_flow_logs" {
  description = "Enable VPC Flow Logs"
  type        = bool
  default     = true
}

variable "enable_cloudwatch_logs" {
  description = "Enable CloudWatch logging for VPC Flow Logs"
  type        = bool
  default     = true
}

variable "enable_s3_logs" {
  description = "Enable S3 logging for VPC Flow Logs"
  type        = bool
  default     = true
}

variable "log_retention_days" {
  description = "CloudWatch log retention in days"
  type        = number
  default     = 7
}

variable "s3_log_expiration_days" {
  description = "S3 log expiration in days"
  type        = number
  default     = 30
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}