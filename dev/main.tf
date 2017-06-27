data "aws_caller_identity" "current" { }

# VPC
module "vpc" {
  source       = "git@github.com:silverback-insights/infrastructure-terraform-modules?ref=v1.0.2//init/vpc"

  environment  = "${var.vpc_environment}"
}

# Bastion
module "bastion" {
  source         = "git@github.com:silverback-insights/infrastructure-terraform-modules?ref=v1.0.2//vpc/bastion"

  vpc_id          = "${module.vpc.id}"
  vpc_region      = "${module.vpc.region}"
  vpc_environment = "${module.vpc.environment}"
  subnet_ids      = "${module.vpc.database_subnets}"
}

# Postgres
module "postgres" {
  source               = "git@github.com:silverback-insights/infrastructure-terraform-modules?ref=v1.0.2//data-store/postgres"

  vpc_environment      = "${module.vpc.environment}"

  db_name_prefix       = "${module.vpc.project_name}${module.vpc.environment}" # pg only likes alphanumeric
  db_username          = "${var.PG_DB_USER}" # via environment variable
  db_password          = "${var.PG_DB_PASS}" # via environment variable
  db_subnet_group_name = "${module.vpc.database_subnet_group}"

  security_group_ids   = ["${module.vpc.default_security_group_id}"]
}
