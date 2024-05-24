resource "aws_ecs_cluster" "ECS" {
  name = "lab-cluster"

  tags = {
    Name = "lab-cluster"
  }
}   
