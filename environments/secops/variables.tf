variable "alert_email" {
  description = "Email address that receives SNS alerts"
  type        = string
  default     = "perpsecops@outlook.com"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "secops"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
  
}
