resource "aws_ecs_task_definition" "terraform" {
  family = "${var.ecs_td_name}"
  #execution_role_arn = ""
  container_definitions = jsonencode([
    {
      name      = "${var.ecs_td_name}"
      image     = "nginx"
      cpu       = 100
      memory    = 100
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 0
        }
      ]
    }
  ])
}


