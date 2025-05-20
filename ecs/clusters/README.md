# AWS ECS Fargate Cluster Configuration

This directory contains Terraform configurations for deploying ECS Fargate clusters and applications.

## Directory Structure

```
clusters/
└── production/
    ├── shared/    # Shared infrastructure components (VPC, ECS Cluster, etc.)
    └── traccar/   # Traccar application-specific resources
```

## Deployment Order

1. First, deploy the shared infrastructure:
   ```
   cd production/shared
   terraform init
   terraform apply
   ```

2. After the shared infrastructure is deployed, deploy the application:
   ```
   cd ../traccar
   terraform init
   terraform apply
   ```

## Infrastructure Components

### Shared Infrastructure

- VPC with public and private subnets
- NAT Gateway for outbound internet access
- ECS Cluster
- CloudWatch Logs configuration
- IAM Roles for ECS tasks

### Application-Specific (Traccar)

- Application Load Balancer (ALB)
- ECS Task Definition
- ECS Service
- Auto Scaling configuration
- Security Groups

## State Management

Each component manages its own Terraform state, with the application components referencing the shared infrastructure's state for resource IDs and ARNs.
