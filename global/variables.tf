variable "secops_account_id" {
  description = "The AWS account ID for the security operations account"
  type        = string
  default     = "993490993886" # Replace with your actual secops account ID
}

variable "scp_policies" {
  description = "List of SCP policies"
  type        = map(string)
  default     = {}
}
