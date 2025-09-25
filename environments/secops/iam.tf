resource "aws_iam_role" "config_role" {
  name = "AWSConfigRole"

  assume_role_policy = templatefile("${path.module}/policies/iam/config_role.json", {})
}

resource "aws_iam_role_policy_attachment" "config_role_attach" {
  role       = aws_iam_role.config_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWS_ConfigRole"
}

resource "aws_iam_role" "config_aggregator_role" {
  name = "AWSConfigAggregatorRole"

  assume_role_policy = templatefile("${path.module}/policies/iam/config_role.json", {})
}

resource "aws_iam_role_policy_attachment" "config_aggregator_attach" {
  role       = aws_iam_role.config_aggregator_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRoleForOrganizations"
}
