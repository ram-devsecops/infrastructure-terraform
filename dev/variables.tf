# Environment
variable "vpc_environment" {
  description = "The environment tag. Please use one of the following: dev, tst, uat, stg, or prd."
  default     = "dev"
}

# Domains 👇
variable "domain_cert_wildcard" {
  description = "The wildcard cert name (not FQDN)"
  default     = "*.silverbackinsights.com"
}

variable "domain_marketing" {
  description = "The FQDN for the marketing ui"
  default     = "dev.silverbackinsights.com"
}

variable "domain_signup" {
  description = "The FQDN for the signup ui"
  default     = "dev-signup.silverbackinsights.com"
}
# Domains ☝️

# DB 👇
variable "db_alarm_max_cpu_percentage" {
  description = "The max cpu threshold prior to alerts"
  default = 100
}

variable "db_alarm_min_free_disk_in_bytes" {
  description = "The min free disk space in bytes prior to alerts"
  default = 1000000000 # 1GB
}

variable "db_alarm_min_free_memory_in_bytes" {
  description = "The min free memory in bytes prior to alerts"
  default = 1000000 # 1MB
}
# DB ☝️

variable "graphql_instance_type" {
  description = "The AWS instance type for the graphql instances"
  default     = "t2.micro"
}

# Environment variables 👇

# AWS
variable "DEV_AWS_ACCESS_KEY_ID" {}
variable "DEV_AWS_SECRET_ACCESS_KEY" {}
variable "DEV_AWS_DEFAULT_REGION" {}

# PG
variable "DEV_PG_DB_PASS" {}

# Environment variables ☝️
