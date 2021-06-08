
#Current Region

variable "region" {
     default ="us-east-1"
}

#Variable for VPC and SUBNET

variable "vpc_cidr" {}
variable "vpc_id" {}
variable "security_groups" {}
variable "db_subnet_group" {}
variable "subnet_cidr" {
  type = list
  default = ["170.0.1.0/24","170.0.2.0/24","170.0.3.0/24"]
}

data "aws_availability_zones" "azs" {}


#Variables for EC2

variable "ec2_count" {
  default = "1"
}
variable "ami_id" {
  default = "ami"
}
variable "instance_type" {
  default = "t3.micro"
}

variable "subnet_id" {}
variable "subnet_ids" {
  type = "list"
}

#Variables for ALB Target Group

variable "targetgrp_name" {
  default = "terraform"
}

#Variables for ECR ans ECS

variable "ecr_name" {
  default = "terraform"
}
variable "cluster_name" {
  default = "terraform"
}

#variables for RDS

variable "rds_name" {
  default = "terraform"
}
variable "rds_engine_version" {
  default = ""
}
variable "rds_availability_zone" {
  default = ""
}
variable "rds_instance_class" {
  default = ""
}
variable "rds_username" {
  default = ""
}
variable "rds_password" {
  default = ""
}
variable "rds_parameter_group_name" {
  default = ""
}
variable "rds_backup_window" {
  default = ""
}
variable "rds_backup_retention_period" {
  default = ""
}
variable "rds_deletion_protection" {
  default = ""
}
variable "rds_maintenance_window" {
  default = ""
}
variable "rds_port" {
  default = ""
}
variable "rds_publicly_accessible" {
  default = ""
}
variable "rds_apply_immediately" {
  default = ""
}
variable "rds_storage" {
  default = ""
}

variable "engine" {}

