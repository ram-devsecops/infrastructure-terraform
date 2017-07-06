provider "aws" {
  access_key = "${var.AWS_ACCESS_KEY_ID}"
  secret_key = "${var.AWS_SECRET_ACCESS_KEY}"
  region     = "${var.AWS_DEFAULT_REGION}"
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {
  current = true
}

# Create user
resource "aws_iam_user" "user" {
  name          = "${var.iam_profile_name}"
  force_destroy = true
}

# Build out policy in memory
data "aws_iam_policy_document" "document" {
  statement {
    sid       = "AllowAllS3ActionsOnAllTerragruntStateBuckets"
    effect    = "Allow"

    actions   = [
      "s3:*"
    ]

    resources = [
      "arn:aws:s3:::silverbackinsights-terraform-state*",
      "arn:aws:s3:::silverbackinsights-terraform-state*/*"
    ]
  }

  statement {
    sid       = "AllowAllDynamoDBActionsOnTerragruntStateTable"
    effect    = "Allow"

    actions   = [
      "dynamodb:*"
    ]

    resources = [
      "arn:aws:dynamodb:*:${data.aws_caller_identity.current.account_id}:table/terragrunt"
    ]
  }
}

# Create policy
resource "aws_iam_policy" "policy" {
  name   = "AllowAllTerraformActions"
  path   = "/"
  policy = "${data.aws_iam_policy_document.document.json}"
}

# Attach policy to user
resource "aws_iam_policy_attachment" "wire-up" {
  name = "${var.iam_profile_name}-policy-attachment"
  users = ["${aws_iam_user.user.name}"]
  policy_arn = "${aws_iam_policy.policy.arn}"
}

resource "aws_iam_access_key" "key" {
  user = "${aws_iam_user.user.name}"
}
