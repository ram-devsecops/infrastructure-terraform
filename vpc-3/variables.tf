# VPC variables
variable "vpc_project_name" {
  description = "The arbitrary name you are going to give this project."
}

variable "vpc_environment" {
  description = "The environment tag. Please use one of the following: d,q,s,p. Defaults to d (dev)."
  default = "d"
}

variable "vpc_availability_zones" {
  default = [
    "us-east-2a",
    "us-east-2b"
  ]
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}


variable "vpc_private_subnets" {
  type = "list"
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]
}

variable "vpc_public_subnets" {
  type = "list"
  default = [
    "10.0.101.0/24",
    "10.0.102.0/24"
  ]
}

variable "vpc_database_subnets" {
  type = "list"
  default = [
    "10.0.201.0/24",
    "10.0.202.0/24"
  ]
}

# DB variables
variable "PG_DB_USER" {
  description = "This value should be set via the environment variable: TF_PG_DB_USER"
}

variable "PG_DB_PASS" {
  description = "This value should be set via the environment variable: TF_PG_DB_PASS"
}
