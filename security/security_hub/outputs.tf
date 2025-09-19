output "securityhub_enabled" {
  value       = aws_securityhub_account.this.id
  description = "Security Hub account ID"
}
