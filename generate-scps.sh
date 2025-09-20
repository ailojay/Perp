#!/bin/bash

# Create scp folder
mkdir -p scp

# 1. Deny Disabling Security Services
cat > scp/scp-deny-disruptive.json <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Deny",
      "Action": [
        "cloudtrail:DeleteTrail",
        "cloudtrail:StopLogging",
        "cloudtrail:UpdateTrail",
        "guardduty:DeleteDetector",
        "guardduty:StopMonitoringMembers",
        "config:DeleteConfigurationRecorder",
        "config:StopConfigurationRecorder",
        "securityhub:DeleteHub",
        "securityhub:DisableSecurityHub"
      ],
      "Resource": "*"
    }
  ]
}
EOF

# 2. Deny S3 Public Buckets
cat > scp/scp-deny-s3-public.json <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Deny",
      "Action": [
        "s3:PutBucketAcl",
        "s3:PutBucketPolicy",
        "s3:PutBucketPublicAccessBlock"
      ],
      "Resource": "*",
      "Condition": {
        "StringEquals": { "aws:PrincipalAccount": "*" }
      }
    }
  ]
}
EOF

# 3. Deny IAM Escalation
cat > scp/scp-deny-iam-escalation.json <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Deny",
      "Action": [
        "iam:CreatePolicyVersion",
        "iam:AttachRolePolicy",
        "iam:PutRolePolicy",
        "iam:PutUserPolicy",
        "iam:PutGroupPolicy",
        "iam:AttachUserPolicy",
        "iam:AttachGroupPolicy"
      ],
      "Resource": "*"
    }
  ]
}
EOF

# 4. Deny KMS Key Deletion/Disable
cat > scp/scp-deny-kms-delete.json <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Deny",
      "Action": [
        "kms:ScheduleKeyDeletion",
        "kms:DisableKey"
      ],
      "Resource": "*"
    }
  ]
}
EOF

# 5. Require MFA
cat > scp/scp-require-mfa.json <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Deny",
      "Action": "*",
      "Resource": "*",
      "Condition": {
        "BoolIfExists": { "aws:MultiFactorAuthPresent": "false" }
      }
    }
  ]
}
EOF

echo "✅ All SCP JSON files created in ./scp/"
