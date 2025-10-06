variable "environment" {
  description = "The environment name (e.g., secops, dev, prod)"
  type        = string
}

variable "vpc_flow_logs_role_arn" {
  description = "ARN of the IAM role for VPC Flow Logs"
  type        = string
}