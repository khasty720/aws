terraform {
  backend "s3" {
    bucket         = "khasty-terraform-state"
    key            = "ecs/production/traccar/terraform.tfstate"
    region         = "us-east-2"
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      Project     = "traccar"
      ManagedBy   = "Terraform"
    }
  }
}

# Get data from shared infrastructure
data "terraform_remote_state" "shared" {
  backend = "s3"
  
  config = {
    # Configure to match your shared state file location
    bucket = "khasty-terraform-state"
    key    = "ecs/production/shared/terraform.tfstate"
    region = "us-east-2"
  }
}

# ALB for Traccar application
module "alb" {
  source       = "../../../../modules/alb"
  vpc_id       = data.terraform_remote_state.shared.outputs.vpc_id
  subnets      = data.terraform_remote_state.shared.outputs.public_subnets
  environment  = var.environment
  project_name = "traccar"
  
  app_port          = var.app_port
  health_check_path = var.health_check_path
  allowed_cidr_blocks = var.allowed_ip_ranges
}

# ECS Task Definition for Traccar
module "ecs_task" {
  source       = "../../../../modules/ecs-task"
  environment  = var.environment
  project_name = "traccar"
  
  app_port           = var.app_port
  container_image    = var.container_image
  container_cpu      = var.container_cpu
  container_memory   = var.container_memory
  log_group_name     = data.terraform_remote_state.shared.outputs.log_group_name
  execution_role_arn = data.terraform_remote_state.shared.outputs.execution_role_arn
  
  environment_variables = [
    {
      name  = "APP_ENV"
      value = var.environment
    }
  ]
}

# ECS Service for Traccar
module "ecs_service" {
  source       = "../../../../modules/ecs-service"
  environment  = var.environment
  project_name = "traccar"
  
  cluster_id          = data.terraform_remote_state.shared.outputs.ecs_cluster_id
  task_definition_arn = module.ecs_task.task_definition_arn
  container_name      = module.ecs_task.container_name
  
  vpc_id             = data.terraform_remote_state.shared.outputs.vpc_id
  subnets            = data.terraform_remote_state.shared.outputs.public_subnets
  app_port           = var.app_port
  target_group_arn   = module.alb.target_group_arn
  desired_count      = var.desired_count
  min_capacity       = var.desired_count
  max_capacity       = var.max_capacity
  alb_security_group_id = module.alb.security_group_id
  assign_public_ip   = true
  
  create_security_group = true
}

# Outputs
output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "ecs_service_name" {
  description = "ECS Service name"
  value       = module.ecs_service.service_name
}

output "ecs_task_definition_arn" {
  description = "ARN of the ECS Task Definition"
  value       = module.ecs_task.task_definition_arn
}
