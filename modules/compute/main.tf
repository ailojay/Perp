resource "aws_instance" "this" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 Free Tier in us-east-1
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [var.security_group]
  key_name      = var.ssh_key_name

  tags = {
    Name        = "${var.project_name}-${var.environment}-ec2"
    Environment = var.environment
  }
}
