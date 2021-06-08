
#Current Region

variable "region" {
  default ="us-east-1"
}

#Variable for VPC and SUBNET

variable "vpc_cidr" {}
variable "vpc_id" {}
variable "security_groups" {}
variable "subnet_cidr" {
  type = list
}

data "aws_availability_zones" "azs" {}


#Variables for EC2

variable "ec2_count" {}
variable "ami_id" {}
variable "instance_type" {}
variable "subnet_ids" {
  type = list
}

#Variables for ALB Target Group

variable "alb_name" {}
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
variable "rds_apply_immediately" {}
variable "rds_storage" {}

