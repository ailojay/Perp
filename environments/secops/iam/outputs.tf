output "github_actions_secops_role_arn" {
  description = "The ARN of the IAM role for GitHub Actions to assume in the SecOps account"
  value       = aws_iam_role.github_actions_secops.arn
  
}
