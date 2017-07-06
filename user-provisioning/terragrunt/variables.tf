variable "AWS_ACCESS_KEY_ID" {
  description = "The aws access key for the environment you are creating the terragrunt user"
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "The aws secret key for the environment you are creating the terragrunt user"
}

variable "AWS_DEFAULT_REGION" {
  description = "The aws default region for the environment you are creating the terragrunt user"
}

variable "iam_profile_name" {
  description = "The user name for the terragrunt user"
  default = "terragrunt"
}
