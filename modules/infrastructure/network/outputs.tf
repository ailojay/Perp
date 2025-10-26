output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnets" {
  value = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id
  ]
}

output "security_group_id" {
  value = aws_security_group.this.id
}
