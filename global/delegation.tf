# This file is applied from the root account
# It delegates security service administration to the secops account

# Delegate GuardDuty Administration
resource "aws_guardduty_organization_admin_account" "secops" {
  admin_account_id = var.secops_account_id # Your secops account ID: 891336823827
}

# Delegate Security Hub Administration
resource "aws_securityhub_organization_admin_account" "secops" {
  admin_account_id = var.secops_account_id
}

# Delegate IAM Access Analyzer Administration using the generic organizations delegator
resource "aws_organizations_delegated_administrator" "access_analyzer" {
  account_id        = var.secops_account_id
  service_principal = "access-analyzer.amazonaws.com"
}