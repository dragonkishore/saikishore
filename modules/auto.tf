resource "aws_launch_configuration" "terraform" {
  name_prefix       = "${var.asgname}"
  image_id          = data.aws_ami.amazon_linux_ecs.id
  instance_type     = "t2.micro"
  iam_instance_profile = "ecsinstancerole"
  key_name          = "sai"
  user_data         = "#!/bin/bash\necho ECS_CLUSTER= terraform >> /etc/ecs/ecs.config;\necho ECS_BACKEND_HOST= >> /etc/ecs/ecs.config;"
  security_groups   = ["${aws_security_group.terraform.id}"]
  associate_public_ip_address  = "true"
  enable_monitoring = "true"
  ebs_optimized     = "true"
  root_block_device {
      volume_type = "standard"
      volume_size = 30
      delete_on_termination = true
  }
 }

resource "aws_autoscaling_group" "terraform" {
  name                 = "terraform"
  vpc_zone_identifier  = ["${aws_subnet.terraform.*.id[0]}","${aws_subnet.terraform.*.id[1]}"]
  launch_configuration = aws_launch_configuration.terraform.name
  desired_capacity     = 1
  min_size             = 1
  max_size             = 1
  health_check_type    = "EC2"

  tag {
    key                 = "Name"
    value               = "${aws_ecs_cluster.terraform.id}"
    propagate_at_launch = true
  }
}