output "user_name" {
  value = "${aws_iam_user.user.name}"
}

output "policy_name" {
  value = "${aws_iam_policy.policy.name}"
}
