output "backend_lb_dns_name" {
  value = aws_lb.backend_lb.dns_name
}

output"ecs_lb_dns_name" {
  value = aws_lb.ecs_lb.dns_name
}
