# Shared Infrastructure Components

This directory contains Terraform configurations for the shared infrastructure components that can be used by multiple applications.

## Components

- **VPC and Networking**: Public and private subnets across multiple availability zones
- **ECS Cluster**: Shared ECS cluster for running containerized applications
- **Logging**: CloudWatch logging configuration and IAM roles

## Usage

1. Update the `terraform.tfvars` file with your desired configuration values.
2. Initialize Terraform:

```bash
terraform init
```

3. Apply the configuration:

```bash
terraform apply
```

## Outputs

This configuration exposes several outputs that can be used by application-specific Terraform configurations:

- `vpc_id`: ID of the shared VPC
- `private_subnets`: List of private subnet IDs
- `public_subnets`: List of public subnet IDs
- `ecs_cluster_id`: ID of the shared ECS cluster
- `ecs_cluster_name`: Name of the shared ECS cluster
- `log_group_name`: Name of the shared CloudWatch Log Group
- `execution_role_arn`: ARN of the ECS task execution role

## Notes

Always deploy shared infrastructure first before deploying application-specific resources that depend on it.
