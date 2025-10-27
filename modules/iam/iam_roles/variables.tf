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

# Password Policy Variables
variable "minimum_password_length" {
  description = "Minimum password length"
  type        = number
  default     = 14
}

variable "require_lowercase_characters" {
  description = "Require lowercase characters"
  type        = bool
  default     = true
}

variable "require_uppercase_characters" {
  description = "Require uppercase characters"
  type        = bool
  default     = true
}

variable "require_numbers" {
  description = "Require numbers"
  type        = bool
  default     = true
}

variable "require_symbols" {
  description = "Require symbols"
  type        = bool
  default     = true
}

variable "allow_users_to_change_password" {
  description = "Allow users to change password"
  type        = bool
  default     = true
}

variable "max_password_age" {
  description = "Maximum password age in days"
  type        = number
  default     = 90
}

variable "password_reuse_prevention" {
  description = "Number of previous passwords to prevent reuse"
  type        = number
  default     = 24
}

variable "hard_expiry" {
  description = "Hard expiry for passwords"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}