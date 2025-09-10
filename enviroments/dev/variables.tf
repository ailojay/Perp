variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "state_bucket" {
  description = "S3 bucket for remote state"
  type        = string
}

variable "vpcproject_name" {
  description = "VPC project name"
  type        = string
}

variable "instance_name" {
  description = "EC2 instance name"
  type        = string
}

variable "ssh_key_name" {
  description = "SSH key pair name"
  type        = string
}

variable "ssh_allowed_ip" {
  description = "Allowed SSH CIDR (set via GitHub Secret TF_VAR_ssh_allowed_ip)"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"

}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}