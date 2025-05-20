# AWS ECS Fargate Web Application with Terraform

This Terraform configuration creates a web application infrastructure on AWS using ECS Fargate with an Application Load Balancer (ALB) and CloudWatch logging.

## Architecture Overview

The infrastructure consists of:

- **VPC** with public and private subnets across multiple availability zones
- **NAT Gateway** for outbound internet access from private subnets
- **Application Load Balancer (ALB)** for distributing traffic
- **ECS Cluster** running in Fargate mode
- **ECS Service and Task Definition** for the web application container
- **Auto Scaling** based on CPU and memory utilization
- **CloudWatch Logs** for centralized logging
- **IAM Roles** for secure service permissions

## Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform v1.0 or later
- Docker (for building and pushing container images, if needed)

## Getting Started

1. Clone this repository
2. Create a `terraform.tfvars` file based on the example
3. Initialize Terraform:

```bash
terraform init
```

4. Plan the deployment:

```bash
terraform plan
```

5. Apply the configuration:

```bash
terraform apply
```

## Configuration

Edit the `terraform.tfvars` file to customize your deployment:

```hcl
# General settings
aws_region    = "us-east-2"  # AWS region
environment   = "dev"        # Environment name (dev, staging, prod)
project_name  = "webapp"     # Project name

# Network settings
vpc_cidr           = "10.0.0.0/16"                # VPC CIDR block
availability_zones = ["us-east-2a", "us-east-2b"] # AZs to use

# Application settings
app_port         = 80            # Port the app listens on
container_image  = "nginx:latest" # Docker image to deploy
container_cpu    = 256           # CPU units for container (1024 = 1 vCPU)
container_memory = 512           # Memory for container in MiB
desired_count    = 2             # Number of containers to run
health_check_path = "/health"    # Health check path
```

## Outputs

After applying the Terraform configuration, you'll get these outputs:

- `alb_dns_name`: The DNS name of the Application Load Balancer
- `cloudwatch_log_group`: The name of the CloudWatch Log Group
- `ecs_cluster_name`: The name of the ECS Cluster
- `ecs_service_name`: The name of the ECS Service

## Cleaning Up

To destroy all resources created by Terraform:

```bash
terraform destroy
```

## Module Structure

- **networking**: VPC, subnets, internet gateway, NAT gateway, route tables
- **alb**: Application Load Balancer, target groups, listeners, security groups
- **ecs**: ECS cluster, task definition, service, auto-scaling, security groups
- **logging**: CloudWatch log groups, IAM roles and policies for logging

## Security Considerations

- All resources use security groups with least privilege access
- Containers run in private subnets with no direct internet access
- Traffic to containers flows only through the ALB
- IAM roles follow the principle of least privilege
