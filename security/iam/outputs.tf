output "admin_group_name" {
  description = "IAM group for administrators"
  value       = aws_iam_group.admins.name
}
