output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "sg_id" {
  value = aws_security_group.ssh_sg.id
}

output "ssh_allowed_ip" {
  value       = var.ssh_allowed_ip
  description = "The IP address allowed to access SSH"
}