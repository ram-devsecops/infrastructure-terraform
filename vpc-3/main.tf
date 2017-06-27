resource "aws_vpc" "main" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Terraform   = true
    Environment = "${var.vpc_environment}"
    Project     = "${var.vpc_project_name}"
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.main.id}"
}

# module "vpc" {
#   source                = "github.com/terraform-community-modules/tf_aws_vpc"
#
#   name                  = "vpc-${var.vpc_project_name}-${var.vpc_environment}"
#   cidr                  = "${var.vpc_cidr}"
#   public_subnets        = "${var.vpc_public_subnets}"
#   private_subnets       = "${var.vpc_private_subnets}"
#   database_subnets      = "${var.vpc_database_subnets}"
#   enable_nat_gateway    = "false"
#   azs                   = "${var.vpc_availability_zones}"
#
#   tags {
#     Terraform   = "true"
#     Environment = "${var.vpc_environment}"
#     Project     = "${var.vpc_project_name}"
#   }
# }
#
# module "postgres" {
#   source              = "./postgres"
#
#   name                = "${var.vpc_project_name}${var.vpc_environment}"
#   username            = "${var.PG_DB_USER}" # via environment variable
#   password            = "${var.PG_DB_PASS}" # via environment variable
#   project_name        = "${var.vpc_project_name}-${var.vpc_environment}"
#   environment         = "${var.vpc_environment}"
#
#   subnet_group_name   = "${module.vpc.database_subnet_group}"
#   security_group_ids  = ["${module.vpc.default_security_group_id}"]
#
#   # Commented out below are prod settings
#   # allocated_storage       = "100"
#   # instance_class          = "db.m4.large"
#   # multi_az                = "true"
#   # storage_encrypted       = "true"
#   # publicly_accessible     = "false"
#   # skip_final_snapshot     = "false"
# }
#
# module "bastion" {
#   source                  = "./bastion"
#
#   name                    = "bastion"
#   environment             = "${var.vpc_environment}"
#   vpc_id                  = "${module.vpc.vpc_id}"
#   subnet_ids              = "${module.vpc.database_subnets}"
#
#   s3_bucket_force_destroy = "true"
#
#   # Commented out below are prod settings
#   # s3_bucket_force_destroy = "false"
# }
