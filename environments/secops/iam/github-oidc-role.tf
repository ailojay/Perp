# IAM Role for GitHub Actions to assume directly via OIDC
resource "aws_iam_role" "github_actions_secops" {
  name               = "GitHubActions-SecOps-Deploy"
  description        = "Role for GitHub Actions to assume to deploy resources in the SecOps account via OIDC"
  assume_role_policy = templatefile("${path.module}/../../../policies/iam/github-actions-oidc-trust-policy.json", {
    account_id = data.aws_caller_identity.current.account_id # Dynamically inserts the secops account ID
    repo_name  = "${var.github_org_name}/${var.github_repo_name}" # Dynamically constructs the repo sub
  })
}

# Attach an admin policy for now (will be fine-tuned later)
resource "aws_iam_role_policy_attachment" "github_actions_secops_admin" {
  role       = aws_iam_role.github_actions_secops.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Output the role ARN so we can easily add it to our GitHub workflow


# Create the OIDC Identity Provider for GitHub
resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com" # This is the intended audience of the GitHub OIDC tokens
  ]

  thumbprint_list = [
    "6938fd4d98bab03faadb97b34396831e3780aea1" # GitHub's OIDC thumbprint
  ]
}