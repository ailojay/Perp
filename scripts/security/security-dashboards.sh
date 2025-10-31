#!/bin/bash

echo "🔍 Security Dashboards Quick Links"
echo "=================================="

ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
REGION="us-east-1"

echo ""
echo "🌐 SECURITY CONSOLES:"
echo "   Security Hub:  https://console.aws.amazon.com/securityhub/home?region=$REGION"
echo "   GuardDuty:     https://console.aws.amazon.com/guardduty/home?region=$REGION"
echo "   AWS Config:    https://console.aws.amazon.com/config/home?region=$REGION#/dashboard"
echo "   CloudWatch:    https://console.aws.amazon.com/cloudwatch/home?region=$REGION"
echo "   IAM:           https://console.aws.amazon.com/iam/home"

echo ""
echo "📊 COMPLIANCE DASHBOARDS:"
echo "   Security Hub Findings:    https://console.aws.amazon.com/securityhub/home?region=$REGION#/findings"
echo "   Security Hub Insights:    https://console.aws.amazon.com/securityhub/home?region=$REGION#/insights"
echo "   Config Compliance:        https://console.aws.amazon.com/config/home?region=$REGION#/compliance"
echo "   Config Rules:             https://console.aws.amazon.com/config/home?region=$REGION#/rules"

echo ""
echo "🚨 ALERTING & MONITORING:"
echo "   SNS Topics:               https://console.aws.amazon.com/sns/home?region=$REGION"
echo "   EventBridge Rules:        https://console.aws.amazon.com/events/home?region=$REGION#/rules"
echo "   Lambda Functions:         https://console.aws.amazon.com/lambda/home?region=$REGION#/functions"
echo "   CloudWatch Alarms:        https://console.aws.amazon.com/cloudwatch/home?region=$REGION#alarms:"

echo ""
echo "🔐 IAM & ACCESS:"
echo "   IAM Roles:                https://console.aws.amazon.com/iam/home#/roles"
echo "   IAM Policies:             https://console.aws.amazon.com/iam/home#/policies"
echo "   Password Policy:          https://console.aws.amazon.com/iam/home#/account_settings"

echo ""
echo "💾 LOGGING & AUDIT:"
echo "   CloudTrail:               https://console.aws.amazon.com/cloudtrail/home?region=$REGION"
echo "   S3 Buckets:               https://s3.console.aws.amazon.com/s3/home?region=$REGION"
echo "   VPC Flow Logs:            https://console.aws.amazon.com/vpc/home?region=$REGION#flowLogs:"