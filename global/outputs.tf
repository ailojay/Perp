output "scp_policies" {
  description = "List of created SCP policies"
  value       = { for k, v in aws_organizations_policy.scp_policies : k => v.arn }
}