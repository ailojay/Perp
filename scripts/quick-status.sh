#!/bin/bash

echo "🔍 Quick Security Services Status"
echo "Account: $(aws sts get-caller-identity --query Account --output text)"
echo "Region: us-east-1"
echo ""

echo "Security Hub:"
aws securityhub describe-hub --region us-east-1 --query 'HubArn' --output text && echo "✅ ENABLED" || echo "❌ DISABLED"

echo -e "\nGuardDuty:"
aws guardduty list-detectors --region us-east-1 --query 'length(DetectorIds)' --output text | grep -q "1" && echo "✅ ENABLED" || echo "❌ DISABLED"

echo -e "\nAWS Config Rules:"
aws configservice describe-config-rules --region us-east-1 --query 'length(ConfigRules)' --output text && echo "✅ RULES ACTIVE" || echo "❌ NO RULES"