# VPC variables
variable "vpc_environment" {
  description = "The environment tag. Please use one of the following: dev, tst, uat, stg, or prd."
  default     = "dev"
}

variable "cert_name" {
  description = "The wildcard cert name (not FQDN)"
  default     = "silverbackinsights.com"
}

# Environment variables 👇

# AWS
variable "DEV_AWS_ACCESS_KEY_ID" {}
variable "DEV_AWS_SECRET_ACCESS_KEY" {}
variable "DEV_AWS_DEFAULT_REGION" {}

# PG
variable "DEV_PG_DB_PASS" {}

# Environment variables ☝️
