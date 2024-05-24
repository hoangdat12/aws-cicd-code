resource "aws_ecs_service" "server_app_service_dev" {
  name                               = "server-app-service-dev"
  launch_type                        = "FARGATE"
  platform_version                   = "LATEST"
  cluster                            = aws_ecs_cluster.ECS_dev.id
  task_definition                    = aws_ecs_task_definition.server_app_td.arn
  scheduling_strategy                = "REPLICA"
  desired_count                      = 1
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  depends_on                         = [
    aws_alb_listener.backend_listener, 
    aws_iam_role.execution_role,
    aws_iam_role.task_role
  ]


  load_balancer {
    target_group_arn = aws_lb_target_group.dev_backend_tg.arn
    container_name   = "server-app"
    container_port   = 5000
  }


  network_configuration {
    assign_public_ip = true
    security_groups  = [aws_security_group.dev_backend_sg.id]
    subnets          = [aws_subnet.dev_public_subnet_az1.id, aws_subnet.dev_public_subnet_az2.id]
  }
}