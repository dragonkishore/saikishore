
#Variables for EC2

variable "ec2_count" {}
variable "ami_id" {}
variable "instance_type" {}
variable "subnet_ids" {
  type = list
}

