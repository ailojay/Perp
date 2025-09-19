terraform {
  backend "s3" {
    bucket         = "perp-secops-state-bucket" # Bucket name
    key            = "secops/terraform.tfstate" # Path within the bucket
    region         = "us-east-1"                # Region where bucket exists
    dynamodb_table = "perp-secops-lock-table"   # DynamoDB table name
    encrypt        = true                       # Encrypt the state file
  }
}
