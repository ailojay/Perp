# IAM Role for AWS Config
resource "aws_iam_role" "config_role" {
  name               = "${var.environment}-AWSConfigRole"
  assume_role_policy = templatefile("${path.module}/../../../policies/iam/config_role.json", {})
}

resource "aws_iam_role_policy_attachment" "config_role_attach" {
  role       = aws_iam_role.config_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWS_ConfigRole"
}

resource "aws_iam_role" "config_aggregator_role" {
  name               = "${var.environment}-AWSConfigAggregatorRole"
  assume_role_policy = templatefile("${path.module}/../../../policies/iam/config_role.json", {})
}

resource "aws_iam_role_policy_attachment" "config_aggregator_attach" {
  role       = aws_iam_role.config_aggregator_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRoleForOrganizations"
}

# IAM Role for VPC Flow Logs
resource "aws_iam_role" "vpc_flow_logs_role" {
  name               = "${var.environment}-VPCFlowLogsRole"
  assume_role_policy = templatefile("${path.module}/../../../policies/iam/vpc_flow_logs_assume.json", {})
}

# Attaches Policy for VPC Flow Logs Role
resource "aws_iam_role_policy" "vpc_flow_logs_policy" {
  name   = "vpc-flow-logs-policy"
  role   = aws_iam_role.vpc_flow_logs_role.id
  policy = file("${path.module}/../../../policies/iam/vpc_flow_logs_role.json")
}

# IAM Role for Remediation Lambda (S3 Public Bucket Fixer)
resource "aws_iam_role" "remediation_lambda_role" {
  name               = "${var.environment}-S3PublicBucketFixerRole"
  assume_role_policy = templatefile("${path.module}/../../../policies/iam/lambda_assume_role_policy.json", {})
}

# IAM Policy for Remediation Lambda (S3 Public Bucket Fixer)
resource "aws_iam_policy" "s3_public_bucket_fixer_policy" {
  name   = "${var.environment}-S3PublicBucketFixerPolicy"
  policy = file("${path.module}/../../../policies/remediation/s3_public_bucket_fixer_policy.json")
}

# Attaches Policy to Remediation Lambda Role
resource "aws_iam_role_policy_attachment" "fixer_policy_attach" {
  role       = aws_iam_role.remediation_lambda_role.name
  policy_arn = aws_iam_policy.s3_public_bucket_fixer_policy.arn
}

# ========== ENTERPRISE IAM COMPONENTS ==========

# 1. IAM Password Policy for all accounts
resource "aws_iam_account_password_policy" "strict" {
  minimum_password_length        = var.minimum_password_length
  require_lowercase_characters   = var.require_lowercase_characters
  require_uppercase_characters   = var.require_uppercase_characters
  require_numbers                = var.require_numbers
  require_symbols                = var.require_symbols
  allow_users_to_change_password = var.allow_users_to_change_password
  max_password_age               = var.max_password_age
  password_reuse_prevention      = var.password_reuse_prevention
  hard_expiry                    = var.hard_expiry
}

# 2. Break Glass Emergency Role
resource "aws_iam_role" "break_glass_admin" {
  name               = "${var.environment}-BreakGlassAdministrator"
  description        = "Break glass emergency access role"
  assume_role_policy = templatefile("${path.module}/../../../policies/iam/break_glass_assume_role.json", {
    account_id = data.aws_caller_identity.current.account_id
  })

  max_session_duration = 3600 # 1 hour for emergency access

  tags = merge(var.tags, {
    Purpose = "break-glass-emergency"
  })
}

resource "aws_iam_role_policy_attachment" "break_glass_admin" {
  role       = aws_iam_role.break_glass_admin.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# 3. Security Operations Role
resource "aws_iam_role" "security_operations" {
  name               = "${var.environment}-SecurityOperations"
  description        = "Role for security team operations"
  assume_role_policy = templatefile("${path.module}/../../../policies/iam/security_operations_assume_role.json", {
    account_id = data.aws_caller_identity.current.account_id
  })

  tags = merge(var.tags, {
    Purpose = "security-operations"
  })
}

resource "aws_iam_policy" "security_operations" {
  name        = "${var.environment}-SecurityOperationsPermissions"
  description = "Permissions for security operations team"
  policy      = file("${path.module}/../../../policies/iam/security_operations_policy.json")
}

resource "aws_iam_role_policy_attachment" "security_operations" {
  role       = aws_iam_role.security_operations.name
  policy_arn = aws_iam_policy.security_operations.arn
}



# Data source for account ID
data "aws_caller_identity" "current" {}