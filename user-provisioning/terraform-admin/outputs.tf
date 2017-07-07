output "Save this information for a later date" {
  value = <<EOF
 👇

Below are your enviornment's access keys for the newly created terraform-admin user
  * AWS Key:    ${aws_iam_access_key.key.id}
  * AWS Secret: ${aws_iam_access_key.key.secret}
  * AWS Region: ${data.aws_region.current.name}

Please update your ~/.terraform-env file accordingly.

EOF
}
