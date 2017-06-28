# VPC variables
variable "vpc_environment" {
  description = "The environment tag. Please use one of the following: d,q,s,p."
  default     = "d"
}

# PG variables
variable "PG_DB_USER" {}
variable "PG_DB_PASS" {}
