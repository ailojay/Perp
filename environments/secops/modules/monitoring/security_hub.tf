resource "aws_securityhub_account" "this" {
  enable_default_standards = false
  lifecycle {
    ignore_changes = [enable_default_standards, auto_enable_controls]
  }
}

resource "null_resource" "suppress_existing_cross_region_findings" {
  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command = <<-EOT
      echo "Suppressing cross-region findings..."
      aws securityhub get-findings \
        --filters '{"Region":[{"Value":"us-east-1","Comparison":"NOT_EQUALS"}]}' \
        --query 'Findings[0:100].{Id:Id,ProductArn:ProductArn}' \
        --output json \
        --region us-east-1 > /tmp/findings_batch.json
      
      if [ -s /tmp/findings_batch.json ] && [ "$(cat /tmp/findings_batch.json)" != "[]" ]; then
        echo "Found findings to suppress, processing..."
        aws securityhub batch-update-findings \
          --finding-identifiers file:///tmp/findings_batch.json \
          --workflow '{"Status":"SUPPRESSED"}' \
          --note '{"Text":"Suppressed via Terraform","UpdatedBy":"Terraform"}' \
          --region us-east-1
        echo "Batch suppression completed"
      else
        echo "No cross-region findings found"
      fi
    EOT
  }
  
  triggers = {
    run_once = "2025-01-18-v2"
  }
}