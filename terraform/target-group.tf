resource "aws_lb_target_group" "ecs_tg" {
  name        = "ECS-tg"
  port        = "5173"
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.ecs_vpc.id

  tags = {
    Name = "ECS-tg"
  }
}

resource "aws_lb_target_group" "backend_tg" {
  name        = "Backend-tg"
  port        = "5000"
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.ecs_vpc.id

  tags = {
    Name = "Backend-tg"
  }
}