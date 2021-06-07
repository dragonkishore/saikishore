
#Create Security Group

resource "aws_security_group" "terraform" {
  name        = "terraform"
  description = "inbound traffic"
  vpc_id      = "${aws_vpc.terraform.id}"

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

output "security_groups" {
    value = "${aws_security_group.terraform.id}"
}