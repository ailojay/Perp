variable "name" {
  type        = string
  description = "Name prefix for the budget"
}

variable "amount" {
  type        = string
  description = "Monthly budget amount in USD"
}

variable "linked_account_id" {
  type        = string
  description = "Account ID if filtering by account, leave blank for org-wide"
  default     = ""
}

variable "alert_email" {
  type        = string
  description = "Email address for budget alerts"
}
