# Cost Optimization Recommendations for Perp Project

## High Impact Changes (Save $100+/month)

### 1. GuardDuty Features (modules/security/detection/guardduty.tf)
```hcl
# Disable expensive features for dev environment
enable_malware_protection = var.environment == "prod" ? true : false
enable_s3_protection = var.environment == "prod" ? true : false  
enable_runtime_monitoring = false  # Disable entirely unless critical
```

### 2. Config Service (modules/security/compliance/config.tf)
```hcl
recording_group {
  all_supported = false
  resource_types = [
    "AWS::S3::Bucket",
    "AWS::EC2::SecurityGroup", 
    "AWS::IAM::Role",
    "AWS::EC2::Instance"
  ]
}
```

## Medium Impact Changes (Save $20-50/month)

### 3. VPC Flow Logs (modules/security/logging/logging.tf)
```hcl
# Log only rejected traffic
traffic_type = "REJECT"

# Use S3 only, disable CloudWatch
enable_cloudwatch_logs = false
enable_s3_logs = true

# Shorter S3 retention
s3_log_expiration_days = 30  # Instead of 90+
```

### 4. CloudWatch Retention (modules/security/logging/logging.tf)
```hcl
retention_in_days = 7  # Instead of 30
```

## Low Impact Changes (Save $5-20/month)

### 5. EC2 Monitoring (modules/infrastructure/compute/main.tf)
```hcl
# Disable detailed monitoring for dev
monitoring = var.environment == "prod" ? true : false
```

### 6. Config Aggregator (modules/security/compliance/config.tf)
```hcl
# Single region only
organization_aggregation_source {
  all_regions = false
  regions     = ["us-east-1"]  # Already optimized
}
```

## Environment-Based Cost Controls

### Variables to Add:
```hcl
# In variables.tf files
variable "cost_optimization_mode" {
  description = "Enable cost optimization features"
  type        = bool
  default     = true
}

variable "environment_tier" {
  description = "Environment tier (dev/staging/prod)"
  type        = string
  validation {
    condition = contains(["dev", "staging", "prod"], var.environment_tier)
  }
}
```

## Estimated Monthly Savings:
- **GuardDuty optimization**: $80-120/month
- **Config optimization**: $30-50/month  
- **VPC Flow Logs**: $20-40/month
- **CloudWatch retention**: $10-20/month
- **EC2 monitoring**: $5-15/month

**Total potential savings**: $145-245/month per account

## Security Impact Assessment:
- ✅ **No impact**: KMS removal, log retention reduction
- ⚠️ **Low impact**: GuardDuty feature reduction (keep core detection)
- ⚠️ **Medium impact**: Config scope reduction (focus on critical resources)
- ✅ **Acceptable**: VPC Flow Logs to REJECT only (still catches security issues)