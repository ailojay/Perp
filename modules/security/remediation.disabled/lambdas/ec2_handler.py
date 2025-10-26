import json
import boto3
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)

ec2 = boto3.client('ec2')

def lambda_handler(event, context):
    """
    Remediates insecure EC2 security groups by removing overly permissive rules
    """
    try:
        # Parse Security Hub finding
        finding = event['detail']['findings'][0]
        
        # Extract security group ID from finding
        resources = finding.get('Resources', [])
        sg_id = None
        
        for resource in resources:
            if resource['Type'] == 'AwsEc2SecurityGroup':
                sg_id = resource['Id'].split('/')[-1]
                break
        
        if not sg_id:
            logger.error("No security group ID found in finding")
            return {'statusCode': 400, 'body': 'No security group found'}
        
        # Remove overly permissive inbound rules (0.0.0.0/0)
        response = ec2.describe_security_groups(GroupIds=[sg_id])
        sg = response['SecurityGroups'][0]
        
        for rule in sg['IpPermissions']:
            for ip_range in rule.get('IpRanges', []):
                if ip_range.get('CidrIp') == '0.0.0.0/0':
                    # Remove the overly permissive rule
                    ec2.revoke_security_group_ingress(
                        GroupId=sg_id,
                        IpPermissions=[rule]
                    )
                    logger.info(f"Removed permissive rule from {sg_id}")
        
        return {
            'statusCode': 200,
            'body': json.dumps(f'Remediated security group {sg_id}')
        }
        
    except Exception as e:
        logger.error(f"Error remediating security group: {str(e)}")
        raise e