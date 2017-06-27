# Create pg instance (commented out options are for prod)
resource "aws_db_instance" "rds_postgres" {
  storage_type            = "${var.storage_type}"
  engine                  = "${var.engine}"
  engine_version          = "${var.engine_version}"
  parameter_group_name    = "${var.parameter_group_name}"

  backup_retention_period = "${var.backup_retention_period}"
  backup_window           = "${var.backup_window}"
  maintenance_window      = "${var.maintenance_window}"

  port                    = "${var.port}"
  name                    = "${var.name}"
  username                = "${var.username}"
  password                = "${var.password}"

  db_subnet_group_name    = "${var.subnet_group_name}"
  vpc_security_group_ids  = ["${var.security_group_ids}"]

  allocated_storage       = "${var.allocated_storage}" # 100
  instance_class          = "${var.instance_class}" # db.m4.large
  multi_az                = "${var.multi_az}" # true
  storage_encrypted       = "${var.storage_encrypted}" # true
  publicly_accessible     = "${var.publicly_accessible}" # false
  skip_final_snapshot     = "${var.skip_final_snapshot}" # false

  tags {
    Terraform = "true"
    Project = "${var.project_name}"
    Environment = "${var.environment}"
  }
}
