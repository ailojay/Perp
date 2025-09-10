variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, prod, etc.)"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "Subnet ID where the instance will be launched"
  type        = string
}

variable "security_group" {
  description = "Security group ID for the instance"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0023921b4fcd5382b" # Amazon Linux 2 in us-east-1
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}
# SSH key removed since we're using SSM only