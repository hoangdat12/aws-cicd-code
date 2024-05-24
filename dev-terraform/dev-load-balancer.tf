
resource "aws_lb" "dev_backend_lb" {
  name               = "Dev-Backend-LB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.dev_public_sg.id]
  subnets            = [aws_subnet.dev_public_subnet_az1.id, aws_subnet.dev_public_subnet_az2.id]

  tags = {
    Name = "Dev-Backend-lb"
  }
}

resource "aws_alb_listener" "dev_backend_listener" {
  load_balancer_arn = aws_lb.dev_backend_lb.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.dev_backend_tg.id
    type             = "forward"
  }
}