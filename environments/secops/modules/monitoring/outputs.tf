output "config_recorder_name" {
  description = "Name of the AWS Config configuration recorder"
  value       = aws_config_configuration_recorder.main.name
}

output "config_delivery_channel_name" {
  description = "Name of the AWS Config delivery channel"
  value       = aws_config_delivery_channel.main.name
}

output "config_aggregator_name" {
  description = "Name of the AWS Config aggregator"
  value       = aws_config_configuration_aggregator.org.name
}

output "security_hub_account_id" {
  description = "AWS account ID where Security Hub is enabled"
  value       = aws_securityhub_account.this.id
}