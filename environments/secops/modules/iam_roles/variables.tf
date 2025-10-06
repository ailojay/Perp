variable "environment" {
  description = "The environment name (e.g., secops, dev, prod) to prefix resource names"
  type        = string
  default     = "secops"
}

variable "account_id" {
  description = "AWS Account ID (optional, for dynamic ARNs)"
  type        = string
  default     = null
}