variable "vpc_id" {
  description = "VPC where bastion host should be created"
}
variable "environment" {
  description = "The environment tag. Please use one of the following: d,q,s,p. Defaults to d (dev)."
}
variable "bucket_prefix" {
  description = "The prefix to the auto-generated bucket. Defaults to sbi-."
  default     = "sbi-"
}
variable "subnet_ids" {
  description = "List of subnet ids where auto-scaling should create instances"
  type        = "list"
}
variable "cron_update_frequency" {
  description = "The cron formatted schedule for refreshing ssh keys from S3 bucket. Defaults to every 15 minutes (*/15 * * * *)"
  default     = "*/15 * * * *"
}
variable "iam_profile_name" {
  description = "IAM profile name"
  default     = "s3_readonly"
}
variable "s3_bucket_force_destroy" {
  description = "Whether or not to rimraf S3 bucket and contents on destroy. Defaults to false."
  default     = "false"
}
variable "s3_bucket_name" {
  description = "The explicit name for the bucket to hold public ssh keys"
  default     = "silverbackinsights-bastion"
}
