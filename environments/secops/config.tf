resource "aws_config_configuration_recorder" "main" {
  name     = "default"
  role_arn = aws_iam_role.config_role.arn

  recording_group {
    all_supported = true
    include_global_resource_types = true
  }
}

resource "aws_config_delivery_channel" "main" {
  name           = "default"
  s3_bucket_name = "perp-org-logs"
  depends_on     = [aws_config_configuration_recorder.main]
}

resource "aws_config_configuration_recorder_status" "main" {
  name       = aws_config_configuration_recorder.main.name
  is_enabled = true
}

resource "aws_config_configuration_aggregator" "org" {
  name = "org-aggregator"

  organization_aggregation_source {
    role_arn    = aws_iam_role.config_aggregator_role.arn
    all_regions = true
  }
}
