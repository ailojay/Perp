# AWS Config - Simple us-east-1 only
data "aws_iam_role" "config_service_role" {
  name = "AWSServiceRoleForConfig"
}

resource "aws_config_configuration_recorder" "main" {
  name     = "default"
  role_arn = data.aws_iam_role.config_service_role.arn

  recording_group {
    all_supported                 = true
    include_global_resource_types = true
  }
}

resource "aws_config_delivery_channel" "main" {
  name           = "default"
  s3_bucket_name = var.s3_bucket_name
  depends_on     = [aws_config_configuration_recorder.main]
}

resource "aws_config_configuration_recorder_status" "main" {
  name       = aws_config_configuration_recorder.main.name
  is_enabled = true
  depends_on = [aws_config_delivery_channel.main]
}

# Organization Config Aggregator - Only us-east-1
resource "aws_config_configuration_aggregator" "org" {
  name = "${var.environment}-org-aggregator"

  organization_aggregation_source {
    role_arn    = "arn:aws:iam::993490993886:role/service-role/AWSServiceRoleForConfig"
    all_regions = false
    regions     = ["us-east-1"]  # Only monitor us-east-1
  }
}