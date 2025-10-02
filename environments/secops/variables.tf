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

variable "secops_account_id" {
  description = "The AWS Account ID of the SecOps account"
  type        = string
  default     = "993490993886"
  
}