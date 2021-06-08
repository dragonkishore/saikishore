provider "aws" {
  region = "ap-south-1"
}

module "my_vpc" {
  source      = "../modules"
  vpc_cidr    = "170.0.0.0/16"
  tenancy     = "default"
  vpc_id      = "${module.my_vpc.vpc_id}"
  subnet_cidr = "170.0.1.0/24"
}

module "my_ec2" {
  source        = "../modules"
  ec2_count     = 1
  ami_id        = "ami-5a8da735"
  instance_type = "t2.micro"
  monitoring    = false  
  vpc_security_group_ids = "${module.my_ec2.security_groups}"
  subnet_id     = "${module.my_vpc.subnet_id}"
}

module "my_alb" {
     source   = "../modules"
     name     = "terraform"
}

module "my_ecr" {
     source   = "../modules"
     name     = "terraform"
}

module "my_ecs" {
     source   = "../modules"
     name     = "terraform"
}

module "my_rds" {
  
  allocated_storage       = 5
  engine                  = "mysql"
  engine_version          = "5.7.22"
  availability_zone       = "us-east-1a"
  instance_class          = "db.t3.micro"
  name                    = "terraform"
  username                = "root"
  password                = "123456789"
  parameter_group_name    = "default.mysql5.7"
  backup_window           = "09:46-10:16"
  backup_retention_period = 7
  deletion_protection     = "true"
  maintenance_window      = "Mon:00:00-Mon:01:00"
  port                    = 3306
  publicly_accessible     = "true"
  db_subnet_group_name    = "${module.my_rds.aws_db_subnet_group}"
  vpc_security_group_ids  = "${module.my_rds.security_groups}"
  apply_immediately       = "true"
}


