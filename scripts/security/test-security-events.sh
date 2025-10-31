#!/bin/bash

set -e

echo "🧪 Generating Security Test Events"
echo "==================================="

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

TIMESTAMP=$(date +%s)
TEST_BUCKET="security-test-bucket-$TIMESTAMP"
REGION="us-east-1"

echo -e "${YELLOW}Creating test security events...${NC}"

# 1. Create test S3 bucket (will trigger Config)
echo -e "\n${GREEN}1. Creating test S3 bucket...${NC}"
aws s3 mb s3://$TEST_BUCKET --region $REGION
echo "   Bucket: $TEST_BUCKET"

# 2. Make it public (should trigger Security Hub + remediation)
echo -e "\n${GREEN}2. Testing public S3 bucket detection...${NC}"
aws s3api put-bucket-acl --bucket $TEST_BUCKET --acl public-read --region $REGION
echo "   Set bucket to public-read (should trigger remediation)"

# 3. Create test security group with wide open rules
echo -e "\n${GREEN}3. Testing EC2 security group rules...${NC}"
VPC_ID=$(aws ec2 describe-vpcs --filters "Name=isDefault,Values=true" --query 'Vpcs[0].VpcId' --output text --region $REGION)
SG_ID=$(aws ec2 create-security-group \
    --group-name "test-sg-wide-open-$TIMESTAMP" \
    --description "Test security group for security events" \
    --vpc-id $VPC_ID \
    --region $REGION \
    --query 'GroupId' \
    --output text)

# Add wide open rule (should trigger Security Hub)
aws ec2 authorize-security-group-ingress \
    --group-id $SG_ID \
    --protocol tcp \
    --port 0-65535 \
    --cidr 0.0.0.0/0 \
    --region $REGION

echo "   Created security group: $SG_ID with wide-open ingress"

# 4. Create IAM user without MFA (will trigger Config rule)
echo -e "\n${GREEN}4. Testing IAM user without MFA...${NC}"
aws iam create-user --user-name "test-user-nomfa-$TIMESTAMP" > /dev/null
aws iam create-access-key --user-name "test-user-nomfa-$TIMESTAMP" > /dev/null
echo "   Created IAM user without MFA: test-user-nomfa-$TIMESTAMP"

echo -e "\n${YELLOW}===================================${NC}"
echo -e "${GREEN}🎯 Test Events Created Successfully!${NC}"
echo -e "${YELLOW}===================================${NC}"

echo -e "\n📊 What to expect:"
echo "   • Within 5-15 minutes: Security Hub findings for S3 public bucket"
echo "   • Within 5-15 minutes: Security Hub findings for wide-open security group"  
echo "   • Within 15-30 minutes: Config compliance findings for IAM user without MFA"
echo "   • Possible auto-remediation for S3 public bucket"
echo "   • SNS email alerts for HIGH/CRITICAL findings"

echo -e "\n🔍 Monitoring URLs:"
echo "   Security Hub: https://us-east-1.console.aws.amazon.com/securityhub/home?region=us-east-1#/findings"
echo "   AWS Config:   https://us-east-1.console.aws.amazon.com/config/home?region=us-east-1#/compliance"

echo -e "\n🧹 Cleanup command (run after testing):"
echo "   ./scripts/cleanup-test-resources.sh"

# Write test resources to file for cleanup
cat > /tmp/test-resources-$TIMESTAMP.txt << EOF
S3_BUCKET=$TEST_BUCKET
SECURITY_GROUP=$SG_ID
IAM_USER=test-user-nomfa-$TIMESTAMP
TIMESTAMP=$TIMESTAMP
EOF

echo -e "\n📝 Test resources saved to: /tmp/test-resources-$TIMESTAMP.txt"