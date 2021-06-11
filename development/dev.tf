provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source      = "../modules/VPC"
  vpc_cidr    = "170.0.0.0/16"
  vpc_id      = "${module.vpc.vpc_id}"
  subnet_cidr = ["170.0.1.0/24","170.0.2.0/24","170.0.3.0/24","170.0.4.0/24","170.0.5.0/24","170.0.6.0/24"]
}

module "sg" {
  source      = "../modules/SG"
  sg_name     = "terraform"
}
 
# module "ec2" {
#   source          = "../modules/EC2"
#   ec2_count       = 1
#   ami_id          = "ami-0aeeebd8d2ab47354"
#   instance_type   = "t2.micro" 
#   security_groups = "${module.sg.security_groups}"
#   subnet_ids      = "${module.vpc.subnet_id}"
# }
  
# module "alb" {
#   source          = "../modules/ALB"
#   alb_name        = "terraform"
# }

# module "target_grp" {  
#   source          = "../modules/TAR_GRP"   
#   targetgrp_name  = "terraform"
# }
   
module "ecr" {
  source          = "../modules/ECR"
  ecr_name        = "terraform"
}
  
module "ecs" {
  source         = "../modules/ECS"
  cluster_name   = "terraform"
  }
 
# module "rds" {
#   source                      = "../modules/RDS"
#   rds_storage                 = 5
#   rds_engine_version          = "5.7.22"
#   rds_availability_zone       = "us-east-1a"
#   rds_instance_class          = "db.t3.micro"
#   rds_name                    = "terraform"
#   rds_username                = "root"
#   rds_password                = "123456789"
#   rds_parameter_group_name    = "default.mysql5.7"
#   rds_backup_window           = "09:46-10:16"
#   rds_backup_retention_period = 7
#   rds_deletion_protection     = "false"
#   rds_maintenance_window      = "Mon:00:00-Mon:01:00"
#   rds_port                    = 3306
#   rds_publicly_accessible     = "true"
#   rds_apply_immediately       = "true"
# }
 module "asg" {
    source                      = "../modules/AUTO"
    asgname                     = "terraform"
    security_groups             = "${module.sg.security_groups}"
}