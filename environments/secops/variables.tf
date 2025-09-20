variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "allowed_regions" {
  description = "List of allowed AWS regions for SCP"
  type        = list(string)
  default     = ["us-east-1", "us-west-2", "eu-west-1"]
}

variable "required_tags" {
  description = "List of required resource tags"
  type        = list(string)
  default     = ["Environment", "Project", "Owner"]
}

variable "github_org_name" {
  description = "GitHub organization name for OIDC"
  type        = string
  default     = "ailojay"
}

variable "github_repo_name" {
  description = "GitHub repository name for OIDC"
  type        = string
  default     = "Perp"
}
