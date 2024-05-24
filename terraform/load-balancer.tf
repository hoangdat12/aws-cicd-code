resource "aws_lb" "ecs_lb" {
  name               = "ECS-LB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public_sg.id]
  subnets            = [aws_subnet.public_subnet_az1.id, aws_subnet.public_subnet_az2.id]

  tags = {
    Name = "ECS-lb"
  }
}

resource "aws_alb_listener" "ecs_listener" {
  load_balancer_arn = aws_lb.ecs_lb.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.ecs_tg.id
    type             = "forward"
  }
}

resource "aws_lb" "backend_lb" {
  name               = "Backend-LB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public_sg.id]
  subnets            = [aws_subnet.public_subnet_az1.id, aws_subnet.public_subnet_az2.id]

  tags = {
    Name = "Backend-lb"
  }
}

resource "aws_alb_listener" "backend_listener" {
  load_balancer_arn = aws_lb.backend_lb.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.backend_tg.id
    type             = "forward"
  }
}

data "aws_lb" "backend_lb" {
  name = aws_lb.backend_lb.name
}
