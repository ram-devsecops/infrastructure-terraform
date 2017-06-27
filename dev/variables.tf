# VPC variables
variable "vpc_environment" {
  description = "The environment tag. Please use one of the following: d,q,s,p."
  default     = "d"
}

# PG variables
variable "PG_DB_USER" {
  default = "b1g0r!114"
}

variable "PG_DB_PASS" {
  default = "^uAEP92u)pPWEamiY9yD"
}
