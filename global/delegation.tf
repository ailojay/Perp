# Delegated Administrators for AWS Services
# Access Analyzer
resource "aws_organizations_delegated_administrator" "access_analyzer" {
  account_id        = var.secops_account_id
  service_principal = "access-analyzer.amazonaws.com"
}

# Config
resource "aws_organizations_delegated_administrator" "config" {
  account_id        = var.secops_account_id
  service_principal = "config.amazonaws.com"
}

# GuardDuty
resource "aws_guardduty_organization_admin_account" "secops" {
  admin_account_id = var.secops_account_id
}

# Security Hub
resource "aws_securityhub_organization_admin_account" "secops" {
  admin_account_id = var.secops_account_id
}
