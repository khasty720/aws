# Traccar Application Infrastructure

This directory contains Terraform configurations for deploying the Traccar application on AWS ECS Fargate.

## Prerequisites

Before deploying Traccar, you must deploy the shared infrastructure components located in the `../shared` directory.

## Components

- **Application Load Balancer (ALB)**: For distributing traffic to the Traccar containers
- **ECS Task Definition**: Configuration for the Traccar container
- **ECS Service**: Deployment configuration for the Traccar application
- **Auto Scaling**: Automatic scaling based on CPU and memory utilization

## Usage

1. Make sure the shared infrastructure has been deployed first.
2. Update the S3 backend configuration in `main.tf` to match your Terraform state storage.
3. Update the `terraform_remote_state` data source to fetch outputs from the shared infrastructure.
4. Update the `terraform.tfvars` file with your desired application settings.
5. Initialize Terraform:

```bash
terraform init
```

6. Apply the configuration:

```bash
terraform apply
```

## Traccar Application

[Traccar](https://www.traccar.org/) is an open-source GPS tracking system that supports various tracking protocols and devices. This configuration deploys Traccar in a secure and scalable way on AWS ECS Fargate.

## Outputs

- `alb_dns_name`: DNS name of the Application Load Balancer (use this to access Traccar)
- `ecs_service_name`: Name of the ECS Service running Traccar
- `ecs_task_definition_arn`: ARN of the ECS Task Definition for Traccar
