# Shared resources for all remediation functions

# Dead Letter Queue for failed Lambda executions
resource "aws_sqs_queue" "remediation_dlq" {
  name = "${var.environment}-remediation-dlq"
  
  tags = var.tags
}