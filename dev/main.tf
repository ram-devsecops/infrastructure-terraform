# Should be ran as a terragrunt user with very limited permissions
# ...then we read in env vars (TF_VAR_*) for high level AWS administration
provider "aws" {
  access_key = "${var.DEV_AWS_ACCESS_KEY_ID}"
  secret_key = "${var.DEV_AWS_SECRET_ACCESS_KEY}"
  region     = "${var.DEV_AWS_DEFAULT_REGION}"
}

data "aws_caller_identity" "current" {}

terraform {
  backend "s3" {}
}

# VPC
module "vpc" {
  source = "git@github.com:silverback-insights/infrastructure-terraform-modules?ref=master//init/vpc"
}

# Bastion
module "bastion" {
  source                = "git@github.com:silverback-insights/infrastructure-terraform-modules?ref=master//init/bastion"

  vpc_id                = "${module.vpc.id}"
  vpc_region            = "${module.vpc.region}"
  s3_bucket_name_suffix = "${var.vpc_environment}"
  subnet_ids            = "${module.vpc.public_subnet_ids}"
  key_name              = "sbi-bastion"
  key_file              = "./sbi-bastion.pub"
}

# Postgres
module "postgres" {
  source                    = "git@github.com:silverback-insights/infrastructure-terraform-modules?ref=master//data-stores/postgres"

  vpc_id                    = "${module.vpc.id}"
  db_password               = "${var.DEV_PG_DB_PASS}" # via environment variable
  subnet_ids                = ["${module.vpc.private_subnet_ids}"]
  bastion_security_group_id = "${module.bastion.security_group_id}"
}
