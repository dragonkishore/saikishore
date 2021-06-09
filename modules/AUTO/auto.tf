resource "aws_launch_configuration" "terraform" {
  name_prefix   = "terraform"
  image_id      = 
  instance_type = "t2.micro"
  iam_instance_profile = "ecsinstancerole"
  key_name  = "sai"
  security_groups  = ["${aws_security_group.terraform.id}"]
  associate_public_ip_address  = "true"
  enable_monitoring = "enable"
  ebs_optimized = "true"
  root_block_device = {
        volume_type ="standard"
        volume_size = "30"

  }
 
 lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "terraform" {
  name                 = "terraform"
  launch_configuration = aws_launch_configuration.as_conf.name
  min_size             = 1
  max_size             = 2

  lifecycle {
    create_before_destroy = true
  }
}