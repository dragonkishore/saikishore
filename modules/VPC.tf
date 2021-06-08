#Create VPC

resource "aws_vpc" "terraform" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags {
    Name = "terraform"
  }
}

#Create Subnet

resource "aws_subnet" "terraform" {
  count      = "${length(data.aws_availability_zones.azs.names)}"
  availability_zone = "${element(data.aws_availability_zones.azs.names,count.index)}"
  vpc_id     = "${var.vpc_id}"
  cidr_block = "${element(var.subnet_cidr,count.index)}"

  tags {
    Name = "terraform-sub-${count.index+1}"
  }
}

#Creating RDS DB aws_db_subnet_group

resource "aws_db_subnet_group" "terraform" {
  name       = "terraform"
  subnet_ids = "${element(aws_subnet.terraform.*.id, count.index)}"
}

#Create aws_internet_gateway
resource "aws_internet_gateway" "terraform" {
    
  vpc_id = "${var.vpc_id}"

  tags = {
    Name = "terraform"
  }
}

#Create Route Table

resource "aws_route_table" "terraform" {
    
  vpc_id = "${var.vpc_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform.id
  }
  tags = {
    Name = "terraform"
  }
}

#subet assoiciation with route Table

resource "aws_route_table_association" "terraform" {

  count          = "${length(aws_subnet.terraform.*.id)}"
  subnet_id      = "${element(aws_subnet.terraform.*.id, count.index)}"
  route_table_id =  aws_route_table.terraform.id
}


output "vpc_id" {
  value = "${aws_vpc.terraform.id}"
}

output "subnet_id" {
  value = "${element(aws_subnet.terraform.*.id, count.index)}"
}

output "subnet_ids" {
  value = "${element(aws_subnet.terraform.*.id, count.index)}"
}

output "db_subnet_group" {
  value = "${aws_db_subnet_group.terraform.id}"
}