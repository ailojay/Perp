# In environments/secops/variables.tf
variable "environment" {
  description = "The environment name"
  type        = string
  default     = "secops"
}

variable "alert_email" {
  description = "Email address for SNS topic subscription"
  type        = string
  default     = "perpproject+secops@outlook.com"
}

variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket for AWS Config logs"
  type        = string
  default     = "your-config-bucket" # Add your actual bucket
}

variable "secops_account_id" {
  description = "The AWS account ID for the SecOps team"
  type        = string
  default     = "993490993886" # Replace with your actual SecOps account ID
}

variable "enable_s3_protection" {
  description = "Enable GuardDuty S3 protection"
  type        = bool
  default     = true
}

variable "enable_malware_protection" {
  description = "Enable GuardDuty malware protection"
  type        = bool
  default     = true
}

variable "enable_runtime_monitoring" {
  description = "Enable GuardDuty EC2 runtime monitoring"
  type        = bool
  default     = true
}