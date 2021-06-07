#Creating RDS DB Instance

resource "aws_db_instance" "terraform" {
  allocated_storage       = "${rds_storage}"
  engine                  = "mysql"
  engine_version          = "${rds_engine_version}"
  availability_zone       = "${rds_availability_zone}"
  instance_class          = "${rds_instance_class}"
  name                    = "${rds_name}"
  username                = "${rds_username}"
  password                = "${rds_password}"
  parameter_group_name    = "${rds_parameter_group_name}"
  backup_window           = "${rds_backup_window}"
  backup_retention_period = "${rds_backup_retention_period}"
  deletion_protection     = "${rds_deletion_protection}"
  maintenance_window      = "${rds_maintenance_window}"
  port                    = "${rds_port}"
  publicly_accessible     = "${rds_publicly_accessible}"
  db_subnet_group_name    = "${aws_db_subnet_group.terraform.id}"
  vpc_security_group_ids  = "${aws_security_group.terraform.id}"
  apply_immediately       = "${rds_apply_immediately}"
}


output "vpc_security_group_ids" {
    value = "${aws_security_group.terraform.id}"
}