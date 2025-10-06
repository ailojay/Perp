resource "aws_securityhub_account" "this" {
  enable_default_standards = false
  lifecycle {
    ignore_changes = [enable_default_standards, auto_enable_controls]
  }
}

resource "aws_securityhub_organization_configuration" "this" {
  auto_enable           = true
  auto_enable_standards = "DEFAULT"
  depends_on            = [aws_securityhub_account.this]
}

resource "aws_securityhub_standards_subscription" "cis" {
  standards_arn = "arn:aws:securityhub:::ruleset/cis-aws-foundations-benchmark/v/1.2.0"
  depends_on    = [aws_securityhub_account.this]
}

# Remove this block
# resource "aws_securityhub_standards_subscription" "foundational" {
#   standards_arn = "arn:aws:securityhub:us-east-1::standards/aws-foundational-security-best-practices/v/1.0.0"
#   depends_on    = [aws_securityhub_account.this]
# }