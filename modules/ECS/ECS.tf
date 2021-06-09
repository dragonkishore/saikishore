#Create ECS Cluster

resource "aws_ecs_cluster" "terraform" {
  name = "${var.cluster_name}"

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}