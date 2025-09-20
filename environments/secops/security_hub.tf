# Enable Security Hub in SecOps account
resource "aws_securityhub_account" "main" {}

# Enable organization-wide Security Hub
resource "aws_securityhub_organization_configuration" "org_config" {
  auto_enable = true
}