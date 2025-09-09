output "instance_id" {
  value = aws_instance.this.id
}

output "public_ip" {
  value = aws_instance.this.public_ip
}

output "instance_type" {
  value = aws_instance.this.instance_type
  
}