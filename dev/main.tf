# NOTE: This script hould be ran as the terragrunt user with very limited permissions

# ...then we read in env vars (TF_VAR_[ENV]_AWS_*) for the admin user to build out infrastructure
provider "aws" {
  access_key = "${var.DEV_AWS_ACCESS_KEY_ID}"
  secret_key = "${var.DEV_AWS_SECRET_ACCESS_KEY}"
  region     = "${var.DEV_AWS_DEFAULT_REGION}"
}

data "aws_caller_identity" "current" {}

# Track terragrunt state via S3
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

# Internal DNS
module "dns" {
  source = "git@github.com:silverback-insights/infrastructure-terraform-modules?ref=master//init/dns"

  vpc_id = "${module.vpc.id}"
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
  source          = "git@github.com:silverback-insights/infrastructure-terraform-modules?ref=master//init/users"

  vpc_environment = "${var.vpc_environment}" # Needed bc some users aren't created in production
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

# UI app (dynamic)
module "ui_app" {
  source = "git@github.com:silverback-insights/infrastructure-terraform-modules?ref=master//services/ui-app"

  vpc_id                    = "${module.vpc.id}"
  kms_key_alias             = "${module.kms.key_alias}"

  bastion_security_group_id = "${module.bastion.security_group_id}"
  graphql_security_group_id = "${module.graphql.security_group_id}"
}

# Postgres
module "postgres" {
  source                               = "git@github.com:silverback-insights/infrastructure-terraform-modules?ref=master//data-stores/postgres"

  vpc_id                               = "${module.vpc.id}"
  db_password                          = "${var.DEV_PG_DB_PASS}"
  dns_zone_name                        = "${module.dns.name}"
  subnet_ids                           = ["${module.vpc.private_subnet_ids}"]
  bastion_security_group_id            = "${module.bastion.security_group_id}"

  alarm_max_cpu_percentage             = "${var.db_alarm_max_cpu_percentage}"
  alarm_free_disk_threshold_in_bytes   = "${var.db_alarm_min_free_disk_in_bytes}"
  alarm_free_memory_threshold_in_bytes = "${var.db_alarm_min_free_memory_in_bytes}"
}

# GraphQL
module "graphql" {
  source = "git@github.com:silverback-insights/infrastructure-terraform-modules?ref=master//services/graphql"

  vpc_id                     = "${module.vpc.id}"
  availability_zones         = ["${module.vpc.availability_zones}"]
  instance_type              = "${var.graphql_instance_type}"

  subnets_private            = ["${module.vpc.private_subnet_ids}"]
  subnets_public             = ["${module.vpc.public_subnet_ids}"]

  iam_profile_name           = "${module.ui_app.iam_profile_name}"
  bastion_security_group_id  = "${module.bastion.security_group_id}"
  ui_app_security_group_id   = "${module.ui_app.security_group_id}"
  postgres_security_group_id = "${module.postgres.security_group_id}"
}

# Redis
module "redis" {
  source                    = "git@github.com:silverback-insights/infrastructure-terraform-modules?ref=master//data-stores/redis"

  vpc_id                    = "${module.vpc.id}"
  subnet_ids                = ["${module.vpc.private_subnet_ids}"]
  dns_zone_name             = "${module.dns.name}"
  graphql_security_group_id = "${module.graphql.security_group_id}"
}
