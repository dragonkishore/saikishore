#Creating var.rds DB Instance

resource "aws_db_instance" "terraform" {
  allocated_storage       = "${var.rds_storage}"
  engine                  = "mysql"
  engine_version          = "${var.rds_engine_version}"
  availability_zone       = "${var.rds_availability_zone}"
  instance_class          = "${var.rds_instance_class}"
  name                    = "${var.rds_name}"
  username                = "${var.rds_username}"
  password                = "${var.rds_password}"
  parameter_group_name    = "${var.rds_parameter_group_name}"
  backup_window           = "${var.rds_backup_window}"
  backup_retention_period = "${var.rds_backup_retention_period}"
  deletion_protection     = "${var.rds_deletion_protection}"
  maintenance_window      = "${var.rds_maintenance_window}"
  port                    = "${var.rds_port}"
  publicly_accessible     = "${var.rds_publicly_accessible}"
  db_subnet_group_name    = aws_db_subnet_group.terraform.id
  vpc_security_group_ids  = ["${aws_security_group.terraform.id}"]
  apply_immediately       = "${var.rds_apply_immediately}"
  skip_final_snapshot     = true
}


output "vpc_security_group_ids" {
    value = "${aws_security_group.terraform.id}"
}