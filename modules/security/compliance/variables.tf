variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "config_s3_bucket_name" {
  description = "S3 bucket name for AWS Config logs"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

## Security Hub Variables
variable "security_hub_regions" {
  description = "List of regions to aggregate Security Hub findings from"
  type        = list(string)
  default     = ["us-east-1"]
}

variable "enable_cis_standard" {
  description = "Whether to enable CIS AWS Foundations Benchmark"
  type        = bool
  default     = true
}

variable "enable_aws_foundational" {
  description = "Whether to enable AWS Foundational Security Best Practices"
  type        = bool
  default     = true
}