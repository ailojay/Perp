output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "security_group" {
  value       = aws_security_group.ssh_sg.id
  description = "Security group ID allowing SSH access"
}