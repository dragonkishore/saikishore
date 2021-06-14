#Create Application Load balancer

resource "aws_lb" "terraform" {
  name               = "${var.alb_name}"
  internal           = false
  load_balancer_type = "application"
  ip_address_type    = "ipv4"
  security_groups    = ["${var.alb_security_groups}"]
  subnets            = "${var.alb_subnets[*]}"
}

#Create Target Group

resource "aws_lb_target_group" "terraform" {
  name     = "${var.df_targetgrp_name}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.alb_vpc_id}"
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
