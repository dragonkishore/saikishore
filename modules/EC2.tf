resource "aws_instance" "web" {
  count                  = "${var.ec2_count}"
  ami                    = "${var.ami_id}"
  instance_type          = "${var.instance_type}"
  monitoring             = false  
  vpc_security_group_ids = "${aws_security_group.terraform.id}"
  subnet_id              = "${var.subnet_id}"
 
  tags {
    Name = "terraform"
  }
}