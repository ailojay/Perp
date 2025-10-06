import boto3
import json
import os

s3 = boto3.client('s3')
securityhub = boto3.client('securityhub')

def lambda_handler(event, context):
    print("Event Received:", json.dumps(event))
    
    # Extract the bucket name from Security Hub finding
    for record in event.get("detail", {}).get("findings", []):
        title = record.get("Title", "")
        if "S3 Bucket" in title:
            bucket_name = title.split(":")[-1].strip()
            try:
                print(f"Remediating bucket: {bucket_name}")
                
                # 1. Block public access
                s3.put_public_access_block(
                    Bucket=bucket_name,
                    PublicAccessBlockConfiguration={
                        'BlockPublicAcls': True,
                        'IgnorePublicAcls': True,
                        'BlockPublicPolicy': True,
                        'RestrictPublicBuckets': True
                    }
                )

                # 2. Remove bucket policy
                try:
                    s3.delete_bucket_policy(Bucket=bucket_name)
                except s3.exceptions.ClientError:
                    pass  # No policy found

                print(f"✅ Remediation complete for {bucket_name}")

                # 3. Update finding in Security Hub
                securityhub.batch_update_findings(
                    FindingIdentifiers=[
                        {
                            'Id': record['Id'],
                            'ProductArn': record['ProductArn']
                        }
                    ],
                    Note={
                        'Text': f"Remediation Lambda blocked public access for bucket {bucket_name}.",
                        'UpdatedBy': "S3PublicBucketFixer"
                    },
                    Workflow={'Status': 'RESOLVED'}
                )

            except Exception as e:
                print(f"❌ Error remediating {bucket_name}: {e}")
