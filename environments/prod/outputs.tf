# Production Environment Outputs
# NOTE: Commented out since prod environment is not deployed

# output "vpc_id" {
#   description = "Production VPC ID"
#   value       = module.network.vpc_id
# }

# output "instance_id" {
#   description = "Production EC2 instance ID"
#   value       = module.compute.instance_id
# }

# output "s3_bucket_name" {
#   description = "Production S3 bucket name"
#   value       = module.storage.bucket_name
# }

# output "security_monitoring" {
#   description = "Production security monitoring status"
#   value = {
#     guardduty_enabled = true
#     security_hub_enabled = true
#     enhanced_monitoring = true
#   }
# }