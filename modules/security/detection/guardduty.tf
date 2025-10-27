data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

# GuardDuty Detector - Use existing
data "aws_guardduty_detector" "existing" {
  id = "90ccb98e2e2215e9528dd1467dc8dd5d"
}

# Reference existing detector
locals {
  detector_id = data.aws_guardduty_detector.existing.id
}

# Enable S3 Protection (prod only)
resource "aws_guardduty_detector_feature" "s3_protection" {
  count       = var.enable_s3_protection && var.environment == "prod" ? 1 : 0
  detector_id = local.detector_id
  name        = "S3_DATA_EVENTS"
  status      = "ENABLED"
}

# Enable Malware Protection (prod only)
resource "aws_guardduty_detector_feature" "malware_protection" {
  count       = var.enable_malware_protection && var.environment == "prod" ? 1 : 0
  detector_id = local.detector_id
  name        = "EBS_MALWARE_PROTECTION"
  status      = "ENABLED"
}

# Disable EC2 Runtime Monitoring (high cost)
# resource "aws_guardduty_detector_feature" "ec2_runtime_monitoring" {
#   count       = var.enable_runtime_monitoring ? 1 : 0
#   detector_id = local.detector_id
#   name        = "RUNTIME_MONITORING"
#   status      = "ENABLED"
# }

# Custom Threat Detections - Working examples
resource "aws_guardduty_filter" "high_severity_threats" {
  name        = "HighSeverityThreats"
  description = "Archive high severity threats for review"
  action      = "ARCHIVE"
  detector_id = local.detector_id
  rank        = 1

  finding_criteria {
    criterion {
      field  = "severity"
      equals = ["8", "9"] # High and Critical
    }
  }


}
