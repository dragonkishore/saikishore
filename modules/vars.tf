
#Current Region

variable "region" {}

#Variable for VPC and SUBNET

variable "vpc_cidr" {}
variable "vpc_id" {}
variable "subnet_cidr" {
  type = list
  default = ["170.0.1.0/24","170.0.2.0/24","170.0.3.0/24"]
}

data "aws_availability_zones" "azs" {}


#Variables for EC2

variable "ec2_count" {
  default = "1"
}
variable "ami_id" {}
variable "instance_type" {
  default = "t3.micro"
}

variable "subnet_id" {}

#Variables for ALB Target Group

variable "targetgrp_name" {}

#Variables for ECR ans ECS

variable "ecr_name" {}
variable "cluster_name" {}

#variables for RDS

variable "rds_name" {}
variable "rds_engine_version" {}
variable "rds_availability_zone" {}
variable "rds_instance_class" {}
variable "rds_username" {}
variable "rds_password" {}
variable "rds_parameter_group_name" {}
variable "rds_backup_window" {}
variable "rds_backup_retention_period" {}
variable "rds_deletion_protection" {}
variable "rds_maintenance_window" {}
variable "rds_port" {}
variable "rds_publicly_accessible" {}
variable "rds_db_subnet_group_name" {}
variable "rds_vpc_security_group_ids" {}
variable "rds_apply_immediately" {}
variable "rds_storage" {}

