resource "aws_ecs_cluster" "ECS_dev" {
  name = "lab-cluster-dev"

  tags = {
    Name = "lab-cluster-dev"
  }
}   