# Import existing Security Hub account
resource "aws_securityhub_account" "main" {
  lifecycle {
    ignore_changes = all
  }
}

# Enable only CIS standard (essential for compliance)
resource "aws_securityhub_standards_subscription" "cis" {
  standards_arn = "arn:aws:securityhub:::ruleset/cis-aws-foundations-benchmark/v/1.2.0"
  depends_on    = [aws_securityhub_account.main]
}

# Enable AWS Foundational Best Practices (recommended)
resource "aws_securityhub_standards_subscription" "aws_foundational" {
  standards_arn = "arn:aws:securityhub:us-east-1::standards/aws-foundational-security-best-practices/v/1.0.0"
  depends_on    = [aws_securityhub_account.main]
}

# Import existing Security Hub finding aggregator
resource "aws_securityhub_finding_aggregator" "org_aggregator" {
  linking_mode = "ALL_REGIONS"
  
  lifecycle {
    ignore_changes = all
  }
  
  depends_on = [aws_securityhub_account.main]
}