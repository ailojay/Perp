variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, prod, etc.)"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "ssh_allowed_ip" {
  description = "CIDR block allowed for SSH access"
  type        = string
}

variable "ssh_allowed_ip" {
  description = "The IP address allowed to access SSH"
  type        = string
}