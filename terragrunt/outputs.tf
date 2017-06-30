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
