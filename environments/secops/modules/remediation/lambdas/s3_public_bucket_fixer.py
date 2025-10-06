import boto3
import json

s3 = boto3.client('s3')
securityhub = boto3.client('securityhub')
sns = boto3.client('sns')

def lambda_handler(event, context):
    # Get SNS topic from environment variable
    sns_topic_arn = 'arn:aws:sns:us-east-1:993490993886:security-alerts'
    
    for record in event.get("detail", {}).get("findings", []):
        title = record.get("Title", "")
        
        if "S3 Bucket" in title:
            bucket_name = title.split(":")[-1].strip()
            
            try:
                # Block all public access
                s3.put_public_access_block(
                    Bucket=bucket_name,
                    PublicAccessBlockConfiguration={
                        'BlockPublicAcls': True,
                        'IgnorePublicAcls': True,
                        'BlockPublicPolicy': True,
                        'RestrictPublicBuckets': True
                    }
                )

                # Remove bucket policy if exists
                try:
                    s3.delete_bucket_policy(Bucket=bucket_name)
                    policy_action = "Removed bucket policy"
                except:
                    policy_action = "No policy found"

                # Mark as resolved in Security Hub
                securityhub.batch_update_findings(
                    FindingIdentifiers=[{
                        'Id': record['Id'],
                        'ProductArn': record['ProductArn']
                    }],
                    Workflow={'Status': 'RESOLVED'}
                )

                # Send simple notification
                sns.publish(
                    TopicArn=sns_topic_arn,
                    Subject=f"Fixed: Public S3 Bucket {bucket_name}",
                    Message=f"""
Remediated public S3 bucket:

Bucket: {bucket_name}
Action: Blocked all public access
Policy: {policy_action}
Status: Security Hub finding resolved
"""
                )

            except Exception as e:
                # Send error notification
                sns.publish(
                    TopicArn=sns_topic_arn,
                    Subject=f"Failed: {bucket_name}",
                    Message=f"Failed to fix {bucket_name}: {str(e)}"
                )