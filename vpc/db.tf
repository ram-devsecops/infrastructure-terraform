# Create pg instance (commented out options are for prod)
resource "aws_db_instance" "rds_postgres" {
  allocated_storage       = 5 # 100
  storage_type            = "gp2"
  engine                  = "postgres"
  engine_version          = "9.6.2"
  instance_class          = "db.t2.micro" # db.m4.large
  parameter_group_name    = "default.postgres9.6"

  backup_retention_period = "30"
  backup_window           = "04:00-04:30"
  maintenance_window      = "sun:04:30-sun:05:30"

  port                    = 5432
  name                    = "sbi"
  username                = "${var.PG_DB_USER}"
  password                = "${var.PG_DB_PASS}"
  db_subnet_group_name    = "${aws_db_subnet_group.default.id}"

  multi_az                = false # true
  vpc_security_group_ids  = ["${aws_security_group.rds.id}"]
  storage_encrypted       = false # true
  publicly_accessible     = true # false
  skip_final_snapshot     = true # false

  tags {
    Name = "RDS Postgres instance"
  }
}
