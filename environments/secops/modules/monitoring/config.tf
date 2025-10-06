resource "aws_config_configuration_recorder" "main" {
  name     = "default"
  role_arn = var.config_role_arn
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
}

resource "aws_config_configuration_aggregator" "org" {
  name = "${var.environment}-org-aggregator"

  organization_aggregation_source {
    role_arn    = var.config_aggregator_role_arn
    all_regions = true
  }
}