data "aws_caller_identity" "current" {}

module "cloudtrail" {
  source = "../../modules/global/cloudtrail"

  trail_name     = "perp-org-trail"
  s3_bucket_name = "perp-org-trail"
  tags = {
    Project = "perp"
    Service = "cloudtrail"
  }
}