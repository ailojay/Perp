output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.this.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.this.public_ip
}

output "instance_public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = aws_instance.this.public_dns
}

output "instance_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.this.private_ip
}

output "ssm_role_arn" {
  description = "ARN of the IAM role for SSM access"
  value       = aws_iam_role.ssm_role.arn
}

output "ssm_instance_profile_arn" {
  description = "ARN of the IAM instance profile for SSM"
  value       = aws_iam_instance_profile.ssm_profile.arn
}

output "ssm_connection_command" {
  description = "AWS CLI command to connect via SSM Session Manager"
  value       = "aws ssm start-session --target ${aws_instance.this.id} --region ${var.region}"
}