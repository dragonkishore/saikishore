
#Current Region

variable "region" {
  default ="us-east-1"
}

#Variable for VPC and SUBNET

variable "vpc_cidr" {}
variable "vpc_id" {}
variable "subnet_cidr" {
  type = list
}
variable "security_groups" {}
variable "security_groupss" {}

data "aws_availability_zones" "azs" {}

#SG common
variable "sg_name" {}

#Variables for EC2

variable "ec2_count" {}
variable "ami_id" {}
variable "instance_type" {}
variable "subnet_ids" {
  type = list
}

#variable for auto scaling group

data "aws_ami" "amazon_linux_ecs" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-*-amazon-ecs-optimized"]
  }

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
}
variable "asgname" {}  

#Variables for ALB

variable "alb_name" {}

#Variables for ALB Target Group
variable "targetgrp_name" {}

#Variables for ECS

variable "cluster_name" {}

#Variables for ECR 

variable "ecr_name" {}

 
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
