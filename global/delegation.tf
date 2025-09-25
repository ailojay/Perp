# Delegate Access Analyzer Administration
resource "aws_organizations_organization" "org" {
  feature_set = "ALL"

  aws_service_access_principals = [
    "config.amazonaws.com",
    "cloudtrail.amazonaws.com",
    "securityhub.amazonaws.com",
    "access-analyzer.amazonaws.com",
    "guardduty.amazonaws.com"
  ]
}



resource "aws_organizations_delegated_administrator" "access_analyzer" {
  account_id        = var.secops_account_id # your delegated account
  service_principal = "access-analyzer.amazonaws.com"
}

# Delegate GuardDuty Administration
resource "aws_guardduty_organization_admin_account" "secops" {
  admin_account_id = var.secops_account_id
}

# Delegate Security Hub Administration
resource "aws_securityhub_organization_admin_account" "secops" {
  admin_account_id = var.secops_account_id
}

resource "aws_organizations_delegated_administrator" "config" {
  account_id        = var.secops_account_id
  service_principal = "config.amazonaws.com"
}
