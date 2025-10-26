variable "environment" {
  description = "The environment name"
  type        = string
}

variable "alert_email" {
  description = "Email address for SNS topic subscription"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}