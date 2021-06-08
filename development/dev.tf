provider "aws" {
  region = "us-east-1"
}

module "dev" {
  source      = "../modules"
  vpc_cidr    = "170.0.0.0/16"
  vpc_id      = "${module.dev.vpc_id}"
  subnet_cidr = ["170.0.1.0/24","170.0.2.0/24","170.0.3.0/24"]


  ec2_count     = 1
  ami_id        = "ami-5a8da735"
  instance_type = "t2.micro" 
  security_groups = "${module.dev.security_groups}"
  subnet_id     = "${module.dev.subnet_id[0]}"


  targetgrp_name     = "terraform"

  ecr_name           = "terraform"

  cluster_name       = "terraform"

  rds_storage                 = 5
  engine                      = "mysql"
  rds_engine_version          = "5.7.22"
  rds_availability_zone       = "us-east-1a"
  rds_instance_class          = "db.t3.micro"
  rds_name                    = "terraform"
  rds_username                = "root"
  rds_password                = "123456789"
  rds_parameter_group_name    = "default.mysql5.7"
  rds_backup_window           = "09:46-10:16"
  rds_backup_retention_period = 7
  rds_deletion_protection     = "false"
  rds_maintenance_window      = "Mon:00:00-Mon:01:00"
  rds_port                    = 3306
  rds_publicly_accessible     = "true"
  rds_apply_immediately       = "true"
  db_subnet_group             = "${module.dev.db_subnet_group}"
}


