terraform {
  backend "s3" {
    bucket         = "khasty-terraform-state"
    key            = "ecs/production/shared/terraform.tfstate"
    region         = "us-east-2"
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      Project     = "shared-infrastructure"
      ManagedBy   = "Terraform"
    }
  }
}

# Networking module for shared VPC
module "networking" {
  source             = "../../../../modules/networking"
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
  environment        = var.environment
  project_name       = "shared"
}

# Logging module for shared CloudWatch logs
module "logging" {
  source       = "../../../../modules/logging"
  environment  = var.environment
  project_name = "shared"
}

# ECS Cluster for shared services
module "ecs_cluster" {
  source                    = "../../../../modules/ecs-cluster"
  environment               = var.environment
  project_name              = "shared"
  enable_container_insights = true
}

# Output the shared resources for use by application-specific configurations
output "vpc_id" {
  description = "ID of the shared VPC"
  value       = module.networking.vpc_id
}

output "private_subnets" {
  description = "List of private subnet IDs"
  value       = module.networking.private_subnets
}

output "public_subnets" {
  description = "List of public subnet IDs"
  value       = module.networking.public_subnets
}

output "ecs_cluster_id" {
  description = "ID of the shared ECS cluster"
  value       = module.ecs_cluster.cluster_id
}

output "ecs_cluster_name" {
  description = "Name of the shared ECS cluster"
  value       = module.ecs_cluster.cluster_name
}

output "log_group_name" {
  description = "Name of the shared CloudWatch Log Group"
  value       = module.logging.log_group_name
}

output "execution_role_arn" {
  description = "ARN of the ECS task execution role"
  value       = module.logging.execution_role_arn
}
