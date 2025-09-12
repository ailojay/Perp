output "project_name" {
  description = "Project name"
  value       = var.project_name
}

output "environment" {
  description = "Environment name"
  value       = var.environment
}

output "region" {
  description = "AWS region"
  value       = var.region
}

output "state_bucket" {
  description = "Terraform state bucket name"
  value       = var.state_bucket
}

output "vpcproject_name" {
  description = "VPC project name"
  value       = var.vpcproject_name
}

output "instance_name" {
  description = "EC2 instance name"
  value       = var.instance_name
}

output "cidr_block" {
  description = "CIDR block for the VPC"
  value       = var.cidr_block

}