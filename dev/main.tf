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

# Sensitive data KMS key
module "kms" {
  source = "git@github.com:silverback-insights/infrastructure-terraform-modules?ref=master//init/kms-key"
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

# Users
module "users" {
  source      = "git@github.com:silverback-insights/infrastructure-terraform-modules?ref=master//init/users"

  environment = "${var.vpc_environment}"
}

# UI Marketing (static)
module "ui_marketing" {
  source        = "git@github.com:silverback-insights/infrastructure-terraform-modules?ref=master//services/ui-static"

  domain_cert   = "${var.domain_cert_wildcard}"
  domain_fqdn   = "${var.domain_marketing}"
  cicd_user_arn = "${module.users.cicd_user_arn}"
}

# UI Signup (static)
module "ui_signup" {
  source        = "git@github.com:silverback-insights/infrastructure-terraform-modules?ref=master//services/ui-static"

  domain_cert   = "${var.domain_cert_wildcard}"
  domain_fqdn   = "${var.domain_signup}"
  cicd_user_arn = "${module.users.cicd_user_arn}"
}

# # UI app (dynamic)
# module "ui_app" {
#   source = "git@github.com:silverback-insights/infrastructure-terraform-modules?ref=master//services/ui-app"
#
#   vpc_id                    = "${module.vpc.id}"
#   vpc_environment           = "${var.vpc_environment}"
#   kms_key_alias             = "${module.kms.key_alias}"
#
#   bastion_security_group_id = "${module.bastion.security_group_id}"
#   graphql_security_group_id = "${module.graphql.security_group_id}"
# }


# Postgres
module "postgres" {
  source                               = "git@github.com:silverback-insights/infrastructure-terraform-modules?ref=master//data-stores/postgres"

  vpc_id                               = "${module.vpc.id}"
  db_password                          = "${var.DEV_PG_DB_PASS}" # via environment variable
  subnet_ids                           = ["${module.vpc.private_subnet_ids}"]
  bastion_security_group_id            = "${module.bastion.security_group_id}"

  alarm_max_cpu_percentage             = 100
  alarm_free_disk_threshold_in_bytes   = 1000000000 # 1GB
  alarm_free_memory_threshold_in_bytes = 1000000 # 1MB
}
