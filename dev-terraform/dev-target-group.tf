resource "aws_lb_target_group" "dev_backend_tg" {
  name        = "Dev-Backend-tg"
  port        = "5000"
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.dev_vpc.id

  tags = {
    Name = "Dev-Backend-tg"
  }
}