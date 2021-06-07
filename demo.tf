provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAVVV3SRGXJMHQ5AHJ"
  secret_key = "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"
}

# Create a VPC
resource "aws_vpc" "terraform" {
  
  cidr_block       = "172.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "terraform"
  }
}

#Create a subnet
resource "aws_subnet" "terraform1sub" {  
  
  vpc_id     = aws_vpc.terraform.id
  cidr_block = "172.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "terraform1sub"
  }
}

resource "aws_subnet" "terraform2sub" {
    
  vpc_id     = aws_vpc.terraform.id
  cidr_block = "172.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "terraform2sub"
  }
}

#Create aws_internet_gateway
resource "aws_internet_gateway" "terraform" {
    
  vpc_id = aws_vpc.terraform.id

  tags = {
    Name = "terraform"
  }
}

#Create Route Table

resource "aws_route_table" "terraform" {
    
  vpc_id = aws_vpc.terraform.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform.id
  }
  tags = {
    Name = "terraform"
  }
}

#subet assoiciation with route Table

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.terraform1sub.id
  route_table_id = aws_route_table.terraform.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.terraform2sub.id
  route_table_id = aws_route_table.terraform.id
}

#Create Security Group

resource "aws_security_group" "terraform" {
  name        = "terraform"
  description = "inbound traffic"
  vpc_id      = aws_vpc.terraform.id

  ingress {
    description      = "demo rule"
    from_port        = 0
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "ALL"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

#Create Application Load balancer

resource "aws_lb" "terraform" {
  name               = "terraform"
  internal           = false
  load_balancer_type = "application"
  ip_address_type    = "ipv4"
  security_groups    = [aws_security_group.terraform.id]
  subnet_mapping {
    subnet_id     = aws_subnet.terraform1sub.id 
  }
  subnet_mapping {
    subnet_id     = aws_subnet.terraform2sub.id
 }
}

#Create Target Group

resource "aws_lb_target_group" "terraform" {
  name     = "terra-demo"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.terraform.id
  deregistration_delay = 30

  health_check {
        path = "/"
        protocol = "HTTP"
        interval = "30"
        timeout = "10"
        healthy_threshold = "3"
        unhealthy_threshold = "2"
   }
}

#Create ALB Listeners 80

resource "aws_lb_listener" "terraform" {
  load_balancer_arn = aws_lb.terraform.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.terraform.arn
  }
}

#Create ECR Repo

resource "aws_ecr_repository" "terraform" {
  name                 = "terraform"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}

#Create ECS Cluster

resource "aws_ecs_cluster" "terraform" {
  name = "terraform"

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

#Creating RDS DB aws_db_subnet_group

resource "aws_db_subnet_group" "terraform" {
  name       = "terraform"
  subnet_ids = [aws_subnet.terraform1sub.id, aws_subnet.terraform2sub.id]
}

#Creating RDS DB Instance

resource "aws_db_instance" "terraform" {
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
  db_subnet_group_name    = aws_db_subnet_group.terraform.id
  vpc_security_group_ids  = [aws_security_group.terraform.id]
  apply_immediately       = "true"
}



