#!/bin/bash

echo "🧹 Cleaning up test security resources"
echo "======================================"

REGION="us-east-1"

if [ -f /tmp/test-resources-*.txt ]; then
    LATEST_FILE=$(ls -t /tmp/test-resources-*.txt | head -1)
    echo "Found test resources file: $LATEST_FILE"
    source $LATEST_FILE
    
    # Cleanup S3 bucket
    if [ ! -z "$S3_BUCKET" ]; then
        echo "🗑️  Deleting S3 bucket: $S3_BUCKET"
        aws s3 rb s3://$S3_BUCKET --force --region $REGION 2>/dev/null || true
    fi
    
    # Cleanup security group
    if [ ! -z "$SECURITY_GROUP" ]; then
        echo "🗑️  Deleting security group: $SECURITY_GROUP"
        aws ec2 delete-security-group --group-id $SECURITY_GROUP --region $REGION 2>/dev/null || true
    fi
    
    # Cleanup IAM user
    if [ ! -z "$IAM_USER" ]; then
        echo "🗑️  Deleting IAM user: $IAM_USER"
        # Delete access keys first
        ACCESS_KEYS=$(aws iam list-access-keys --user-name $IAM_USER --query 'AccessKeyMetadata[].AccessKeyId' --output text 2>/dev/null || true)
        for key in $ACCESS_KEYS; do
            aws iam delete-access-key --user-name $IAM_USER --access-key-id $key 2>/dev/null || true
        done
        # Delete user
        aws iam delete-user --user-name $IAM_USER 2>/dev/null || true
    fi
    
    # Remove the file
    rm -f $LATEST_FILE
    echo "✅ Test resources cleaned up"
else
    echo "ℹ️  No test resources found to clean up"
    echo "Usage: First run ./scripts/test-security-events.sh to create test resources"
fi