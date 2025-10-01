# Security Hub setup in SecOps account

# Enables Security Hub in SecOps
resource "aws_securityhub_account" "this" {
    lifecycle {
    prevent_destroy = true
  }
}

# Enable foundational controls (CIS, PCI DSS, etc.)
resource "aws_securityhub_standards_subscription" "cis" {
  standards_arn = "arn:aws:securityhub:${var.region}::standards/cis-aws-foundations-benchmark/v/1.2.0"
    lifecycle {
    prevent_destroy = true
  }
}

# Commented out for now to because we dont handle anything related to PCI DSS yet
# resource "aws_securityhub_standards_subscription" "pci" {
#   standards_arn = "arn:aws:securityhub:${var.region}::standards/pci-dss/v/3.2.1"
# }

resource "aws_securityhub_standards_subscription" "foundational" {
  standards_arn = "arn:aws:securityhub:${var.region}::standards/aws-foundational-security-best-practices/v/1.0.0"
    lifecycle {
    prevent_destroy = true
  }
}
