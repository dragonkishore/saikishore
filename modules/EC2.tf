resource "aws_instance" "web" {
  count                  = "${var.ec2_count}"
  ami                    = "${var.ami_id}"
  instance_type          = "${var.instance_type}"
  monitoring             = false  
  security_groups        = ["${aws_security_group.terraform.id}"]
  subnet_id              = "${aws_subnet.terraform.*.id[0]}"
 
  tags = {
    Name = "terraform"
  }
}