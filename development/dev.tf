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
  subnet_id     = "${module.my_vpc.subnet_id}"
}