output "db_name" {
  value = "${aws_db_instance.rds_postgres.name}"
}

output "db_arn" {
  value = "${aws_db_instance.rds_postgres.arn}"
}
