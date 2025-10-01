# =====================================
# Enables Security Hub Org-wide
# =====================================

# This resource must be applied in the Org management account (global)
resource "aws_securityhub_organization_configuration" "org" {
  auto_enable = true
}

# Automatically enable new accounts as they join the Org
resource "aws_securityhub_organization_admin_account" "secops" {
  admin_account_id = var.secops_account_id
}
