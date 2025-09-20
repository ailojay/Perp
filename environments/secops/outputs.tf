output "scp_policies" {
  description = "List of created SCP policies"
  value       = { for k, v in aws_organizations_policy.scp_policies : k => v.arn }
}

output "github_actions_secops_role_arn" {
  description = "The ARN of the IAM role for GitHub Actions to assume in the SecOps account"
  value       = aws_iam_role.github_actions_secops.arn

}
