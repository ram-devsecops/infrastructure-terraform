variable "vpc_id" {
  description = "VPC where bastion host should be created"
}

variable "vpc_region" {
  description = "The default aws region for your VPC."
}

variable "environment" {
  description = "The environment tag. Please use one of the following: d,q,s,p. Defaults to d (dev)."
  default     = "d"
}

variable "bucket_name" {
  description = "The bucket name for storing keys. Defaults to sbi-infrastructure."
  default     = "sbi-infrastructure"
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
  default     = "s3-readonly"
}

variable "s3_bucket_force_destroy" {
  description = "Whether or not to rimraf S3 bucket and contents on destroy. Defaults to false."
  default     = "false"
}

variable "bastion_ami" {
  description = "The ami to base the bastion server. Defaults to ami-9be6f38c."
  default     = "ami-9be6f38c"
}
