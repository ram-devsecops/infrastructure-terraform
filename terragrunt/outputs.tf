# output "user_name" {
#   value = "${aws_iam_user.user.name}"
# }
# output "key" {
#   value = "${aws_iam_access_key.key.id}"
# }
#
# output "secret" {
#   value = "${aws_iam_access_key.key.secret}"
# }
#
# output "key_fingerprint" {
#   value = "${aws_iam_access_key.key.key_fingerprint}"
# }
#
# output "encrypted_secret" {
#   value = "${aws_iam_access_key.key.encrypted_secret}"
# }
#
# output "region" {
#   value = "${data.aws_region.current.name}"
# }

output "All you need to do now is the following" {
  value = <<EOF
 👇

1. Run `aws configure --profile terragrunt`
2. Copy/paste the following:
  * AWS Key:    ${aws_iam_access_key.key.id}
  * AWS Secret: ${aws_iam_access_key.key.secret}
  * AWS Region: ${data.aws_region.current.name}

EOF
}
