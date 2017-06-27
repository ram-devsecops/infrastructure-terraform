module variables {
  source  = "./variables"
}

variable "aws_region" {
  default = "us-east-2"
}

variable "aws_region_abbr" {
  default = "ue2"
}

variable "availability_zones" {
  description = "A list of Availability zones in the region"
  default     = [
    "us-east-2a",
    "us-east-2b"
  ]
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC."
  default     = [
    "172.31.1.0/24"
  ]
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC."
  default     = "${module.variables.private_subnets}"
}

variable "database_subnets" {
  type        = "list"
  description = "A list of database subnets"
  default     = []
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {
    CreatedBy = "terraform"
  }
}
