# VPC variables
variable "vpc_environment" {
  description = "The environment tag. Please use one of the following: d,q,s,p."
  default     = "d"
}

# Environment variables

# AWS
variable "DEV_AWS_ACCESS_KEY_ID" {}
variable "DEV_AWS_SECRET_ACCESS_KEY" {}
variable "DEV_AWS_DEFAULT_REGION" {}

# PG
variable "DEV_PG_DB_USER" {}
variable "DEV_PG_DB_PASS" {}
