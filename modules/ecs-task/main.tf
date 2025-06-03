locals {
  container_name = "${var.project_name}-${var.environment}-container"
  
  # Combine fixed environment variables with user-defined ones
  environment_variables = concat(
    [
      {
        name  = "ENVIRONMENT"
        value = var.environment
      }
    ],
    var.environment_variables
  )
}

data "aws_region" "current" {}

# Task Definition
resource "aws_ecs_task_definition" "app" {
  family                   = "${var.project_name}-${var.environment}-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.container_cpu
  memory                   = var.container_memory
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn != "" ? var.task_role_arn : null

  # Set the CPU architecture (ARM64 or X86_64)
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = var.cpu_architecture
  }

  container_definitions = jsonencode([
    {
      name        = local.container_name
      image       = var.container_image
      essential   = true
      
      portMappings = [
        {
          containerPort = var.app_port
          hostPort      = var.app_port
          protocol      = "tcp"
        }
      ]
      
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = var.log_group_name
          "awslogs-region"        = data.aws_region.current.name
          "awslogs-stream-prefix" = "ecs"
        }
      }
      
      environment = local.environment_variables
      
      secrets = length(var.secrets) > 0 ? var.secrets : null
    }
  ])

  tags = {
    Name        = "${var.project_name}-${var.environment}-task"
    Environment = var.environment
    Project     = var.project_name
  }
}
