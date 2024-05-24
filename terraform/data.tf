data "aws_ecs_task_definition" "client_app_td" {
  task_definition = aws_ecs_task_definition.client_app_td.family
}

data "aws_ecs_task_definition" "server_app_td" {
  task_definition = aws_ecs_task_definition.server_app_td.family
}