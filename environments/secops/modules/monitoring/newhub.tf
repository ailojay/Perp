# Enable Security Hub in delegated admin account
resource "aws_securityhub_account" "main" {
  enable_default_standards = true
}

# Cross-region aggregator in delegated admin account
resource "aws_securityhub_finding_aggregator" "org" {
  linking_mode = "ALL_REGIONS_EXCEPT_SPECIFIED"
  
  specified_regions = [] # Empty means all regions
}

# Organization configuration (if delegated admin)
resource "aws_securityhub_organization_configuration" "main" {
  auto_enable           = true
  auto_enable_standards = "DEFAULT"
  
  organization_configuration {
    configuration_type = "CENTRAL"
  }
}
