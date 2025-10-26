variable "project_name" {
  description = "Project name"
  type        = string
  default     = "perp"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "state_bucket" {
  description = "S3 bucket for remote state"
  type        = string
  default     = "perp-dev-state"
}

variable "vpcproject_name" {
  description = "VPC project name"
  type        = string
  default     = "perp-dev-vpc"
}

variable "instance_name" {
  description = "EC2 instance name"
  type        = string
  default     = "perp-dev-instance"
}

variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}
