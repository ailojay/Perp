# IAM Role for AWS Config
resource "aws_iam_role" "config_role" {
  name               = "AWSConfigRole"
  assume_role_policy = templatefile("${path.root}/policies/iam/config_role.json", {})
}

resource "aws_iam_role_policy_attachment" "config_role_attach" {
  role       = aws_iam_role.config_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWS_ConfigRole"
}

resource "aws_iam_role" "config_aggregator_role" {
  name               = "${var.environment}-AWSConfigAggregatorRole"
  assume_role_policy = templatefile("${path.root}/policies/iam/config_role.json", {})
}

resource "aws_iam_role_policy_attachment" "config_aggregator_attach" {
  role       = aws_iam_role.config_aggregator_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRoleForOrganizations"
}

# IAM Role for VPC Flow Logs
resource "aws_iam_role" "vpc_flow_logs_role" {
  name               = "${var.environment}-VPCFlowLogsRole"
  assume_role_policy = templatefile("${path.root}/policies/iam/vpc_flow_logs_assume.json", {})
}

# Attaches Policy for VPC Flow Logs Role
resource "aws_iam_role_policy" "vpc_flow_logs_policy" {
  name   = "vpc-flow-logs-policy"
  role   = aws_iam_role.vpc_flow_logs_role.id
  policy = file("${path.root}/policies/iam/vpc_flow_logs_role.json")
}

# IAM Role for Remediation Lambda (S3 Public Bucket Fixer)
resource "aws_iam_role" "remediation_lambda_role" {
  name               = "${var.environment}-S3PublicBucketFixerRole"
  assume_role_policy = templatefile("${path.root}/policies/iam/lambda_assume_role_policy.json", {})
}
# IAM Policy for Remediation Lambda (S3 Public Bucket Fixer)
resource "aws_iam_policy" "s3_public_bucket_fixer_policy" {
  name   = "${var.environment}-S3PublicBucketFixerPolicy"
  policy = file("${path.root}/policies/remediation/s3_public_bucket_fixer_policy.json")
}

# Attaches Policy to Remediation Lambda Role
resource "aws_iam_role_policy_attachment" "fixer_policy_attach" {
  role       = aws_iam_role.remediation_lambda_role.name
  policy_arn = aws_iam_policy.s3_public_bucket_fixer_policy.arn
}