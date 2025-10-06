variable "environment" {
  description = "The environment name (e.g., secops, dev, prod)"
  type        = string
}

variable "remediation_lambda_role_arn" {
  description = "ARN of the IAM role for the remediation Lambda function"
  type        = string
}