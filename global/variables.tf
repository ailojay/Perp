variable "secops_account_id" {
  description = "The AWS account ID for the security operations account"
  type        = string
  default     = "993490993886"
}

variable "alert_email" {
  description = "secops alert email"
  type        = string
  default     = "perpsecops@outlook.com"
}

variable "dev_account_id" {
  description = "The AWS account ID for the development account"
  type        = string
  default     = "783330585630"
}

variable "prod_account_id" {
  description = "The AWS account ID for the production account"
  type        = string
  default     = "783330585630"
}
