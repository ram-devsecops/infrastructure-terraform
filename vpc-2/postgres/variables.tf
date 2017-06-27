# DB variables
variable "project_name" {}
variable "environment" {}
variable "name" {}
variable "username" {}
variable "password" {}
variable "subnet_group_name" {}
variable "security_group_ids" {
  type = "list"
}

variable "allocated_storage" {
  default = 5 # 100
}
variable "storage_type" {
  default = "gp2"
}
variable "engine" {
  default = "postgres"
}
variable "engine_version" {
  default = "9.6.2"
}
variable "instance_class" {
  default = "db.t2.micro" # db.m4.large
}
variable "parameter_group_name" {
  default = "default.postgres9.6"
}

variable "backup_retention_period" {
  default = "30"
}
variable "backup_window" {
  default = "04:00-04:30"
}
variable "maintenance_window" {
  default = "sun:04:30-sun:05:30"
}

variable "port" {
  default = 5432
}

variable "multi_az" {
  default = false # true
}
variable "storage_encrypted" {
  default = false # true
}
variable "publicly_accessible" {
  default = false
}
variable "skip_final_snapshot" {
  default = true # false
}
