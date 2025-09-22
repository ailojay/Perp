data "aws_organizations_organization" "this" {}

locals {
  scp_files = toset([
    "scp-deny-disruptive.json",
    "scp-require-mfa.json"
  ])
}

resource "aws_organizations_policy" "scp_policies" {
  for_each    = local.scp_files
  name        = trimsuffix(each.value, ".json")
  description = "SCP Policy: ${trimsuffix(each.value, ".json")}"
  content     = file("${path.module}/policies/scp/${each.value}")
}

resource "aws_organizations_policy_attachment" "scp_attachments" {
  for_each  = local.scp_files
  policy_id = aws_organizations_policy.scp_policies[each.key].id
  target_id = data.aws_organizations_organization.this.roots[0].id
}