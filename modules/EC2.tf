resource "aws_instance" "web" {
  count                  = "${var.ec2_count}"
  ami                    = "${var.ami_id}"
  instance_type          = "${var.instance_type}"
  monitoring             = false  
  vpc_security_group_ids = "${var.security_groups}"
  subnet_id              = "${var.subnet_id[0]}"
 
  tags = {
    Name = "terraform"
  }
}