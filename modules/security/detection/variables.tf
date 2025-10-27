variable "enable_s3_protection" {
  description = "Enable GuardDuty S3 protection"
  type        = bool
  default     = false
}

variable "enable_malware_protection" {
  description = "Enable GuardDuty malware protection"
  type        = bool
  default     = false
}

variable "enable_runtime_monitoring" {
  description = "Enable GuardDuty EC2 runtime monitoring"
  type        = bool
  default     = false
}

variable "environment" {
  description = "Environment name"
  type        = string
}