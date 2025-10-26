data "aws_iam_role" "config_service_role" {
  name = "AWSServiceRoleForConfig"
}

resource "aws_config_configuration_recorder" "main" {
  name     = "default"
  role_arn = data.aws_iam_role.config_service_role.arn # Use the data source

  recording_group {
    all_supported                 = true
    include_global_resource_types = true
  }
}

resource "aws_config_delivery_channel" "main" {
  name           = "default"
  s3_bucket_name = var.config_s3_bucket_name
  s3_key_prefix  = "config"
  depends_on     = [aws_config_configuration_recorder.main]
}

resource "aws_config_configuration_recorder_status" "main" {
  name       = aws_config_configuration_recorder.main.name
  is_enabled = true
  depends_on = [aws_config_delivery_channel.main]
}

# Organization Config Aggregator
resource "aws_config_configuration_aggregator" "org" {
  name = "${var.environment}-org-aggregator"

  organization_aggregation_source {
    role_arn    = data.aws_iam_role.config_service_role.arn
    all_regions = false
    regions     = ["us-east-1"]
  }
}