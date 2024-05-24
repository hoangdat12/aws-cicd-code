resource "aws_ecs_task_definition" "server_app_td_dev" {
  family                   = "server-app-definition-dev"
  requires_compatibilities = ["FARGATE"]
  task_role_arn            = aws_iam_role.task_role.arn
  execution_role_arn       = aws_iam_role.execution_role.arn
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  container_definitions = jsonencode([
    {
      name      = "server-app"
      image     = "918195417335.dkr.ecr.ap-southeast-1.amazonaws.com/server-app:latest"
      cpu       = 256
      memory    = 512
      essential = true
      environment: [
        {"name": "TODO_TABLE_NAME", "value": "dev-todo"}
      ],
      portMappings = [
        {
          containerPort = 5000
          hostPort      = 5000
          appProtocol   = "http"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-create-group"   = "true"
          "awslogs-group"          = "/ecs/server-app-definition-dev"
          "awslogs-region"         = "ap-southeast-1"
          "awslogs-stream-prefix"  = "ecs"
        }
      }
    }
  ])
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}