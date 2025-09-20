# Get organization data using the cross-account provider
data "aws_organizations_organization" "this" {
  provider = aws.org_root
}

# Create a local variable with static policy names
locals {
  # List ONLY the specific SCP files you want to deploy
  scp_files = toset([
    "scp-deny-disruptive.json",
    "scp-deny-s3-public.json",
    "scp-deny-iam-escalation.json",
    "scp-deny-kms-delete.json",
    "scp-require-mfa.json"
  ])
}

resource "aws_organizations_policy" "scp_policies" {
  for_each    = local.scp_files
  provider    = aws.org_root
  name        = trimsuffix(each.value, ".json")
  description = "SCP Policy: ${trimsuffix(each.value, ".json")}"
  content     = file("${path.module}/policies/scp/${each.value}") # Note: added /scp/
}

# Attach all policies to the root OU using static keys
resource "aws_organizations_policy_attachment" "scp_attachments" {
  for_each  = local.scp_files # Use the same static keys as policies
  provider  = aws.org_root
  policy_id = aws_organizations_policy.scp_policies[each.key].id
  target_id = data.aws_organizations_organization.this.roots[0].id
}