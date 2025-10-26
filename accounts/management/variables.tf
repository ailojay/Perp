variable "alert_email" {
  description = "secops alert email"
  type        = string
  default     = "perproject@outlook.com"
}

variable "secops_account_id" {
  description = "The AWS account ID for the security operations account"
  type        = string
  default     = "993490993886"
}

variable "dev_account_id" {
  description = "The AWS account ID for the development account"
  type        = string
  default     = "102382809840"
}
