data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

# Connect to the existing GuardDuty detector that's already set up in this account
data "aws_guardduty_detector" "existing" {
  id = "90ccb98e2e2215e9528dd1467dc8dd5d"
}

# Store the detector ID in a local variable for reuse
locals {
  detector_id = data.aws_guardduty_detector.existing.id
}

# Turn on S3 protection only for production environments to save costs
resource "aws_guardduty_detector_feature" "s3_protection" {
  count       = var.enable_s3_protection && var.environment == "prod" ? 1 : 0
  detector_id = local.detector_id
  name        = "S3_DATA_EVENTS"
  status      = "ENABLED"
}

# Turn on malware scanning only for production environments to save costs
resource "aws_guardduty_detector_feature" "malware_protection" {
  count       = var.enable_malware_protection && var.environment == "prod" ? 1 : 0
  detector_id = local.detector_id
  name        = "EBS_MALWARE_PROTECTION"
  status      = "ENABLED"
}

# Runtime monitoring is disabled because it's expensive - uncomment if needed
# resource "aws_guardduty_detector_feature" "ec2_runtime_monitoring" {
#   count       = var.enable_runtime_monitoring ? 1 : 0
#   detector_id = local.detector_id
#   name        = "RUNTIME_MONITORING"
#   status      = "ENABLED"
# }

# Create a filter to automatically archive high severity findings for manual review
resource "aws_guardduty_filter" "high_severity_threats" {
  name        = "HighSeverityThreats"
  description = "Archive high severity threats for review"
  action      = "ARCHIVE"
  detector_id = local.detector_id
  rank        = 1

  finding_criteria {
    criterion {
      field  = "severity"
      equals = ["8", "9"] # Severity levels 8 and 9 are High and Critical
    }
  }


}
