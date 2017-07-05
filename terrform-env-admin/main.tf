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

# Attach AdministratorAccess policy to user
resource "aws_iam_policy_attachment" "wire-up" {
  name = "${var.iam_profile_name}-policy-attachment"
  users = ["${aws_iam_user.user.name}"]
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Create access keys
resource "aws_iam_access_key" "key" {
  user = "${aws_iam_user.user.name}"
}
