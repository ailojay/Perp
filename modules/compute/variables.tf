variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, prod, etc.)"
  type        = string
}

variable "subnet_id" {
  description = "Subnet to launch the instance into"
  type        = string
}

variable "security_group" {
  description = "Security group ID for the instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "ssh_key_name" {
  description = "Name of the SSH key pair"
  type        = string
}
