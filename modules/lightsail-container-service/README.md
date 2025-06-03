# AWS Lightsail Container Service Terraform Module

This module creates an AWS Lightsail Container Service with configurable settings for containers, health checks, and public endpoints.

## Features

- Lightsail Container Service with configurable power and scale
- Support for containers from private Docker registry
- Support for exposing multiple ports per container
- Default endpoint configuration
- Customizable health check
- Tag support

## Usage

```hcl
module "lightsail_container_service" {
  source = "../../modules/lightsail-container-service"

  service_name = "my-app-service"
  power        = "micro"
  scale        = 1
  
  containers = [
    {
      name  = "my-app"
      name  = "my-app"
      image = "your-dockerhub-username/your-image:latest"
      ports = {
        "80" = "HTTP"
        "443" = "HTTPS"
      }
      # Optional environment variables
      environment = {
        "ENV_VAR_1" = "value1"
        "ENV_VAR_2" = "value2"
      }
    }
  ]

  public_endpoints = {
    container_name = "my-app"
    container_port = 80
  }
  
  health_check = {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout_seconds     = 2
    interval_seconds    = 5
    path                = "/"
    success_codes       = "200-499"
  }

  tags = {
    Environment = "production"
    Project     = "my-app"
  }
}
```

## Docker Authentication for Private Registry

To use images from a private Docker registry, you need to configure authentication. For DockerHub, use the AWS CLI to configure the credentials:

```bash
aws lightsail update-container-service --service-name my-app-service \
  --private-registry-access \
  --private-registry-username your-dockerhub-username \
  --private-registry-password your-dockerhub-password
```

For AWS ECR, provide the `ecr_access_role_arn` variable:

```hcl
module "lightsail_container_service" {
  # ... other configuration
  ecr_access_role_arn = "arn:aws:iam::123456789012:role/ECRAccessRole"
}
```

## Input Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| service_name | The name of the Lightsail container service | string | n/a | yes |
| power | The power specification for the container service | string | "nano" | no |
| scale | The number of compute nodes for the container service | number | 1 | no |
| is_disabled | Whether the container service is disabled | bool | false | no |
| tags | Key-value map of resource tags | map(string) | {} | no |
| ecr_access_role_arn | The ARN of the IAM role with permission to pull images from ECR | string | null | no |
| containers | List of container configurations with support for multiple ports | list(object) | n/a | yes |
| public_endpoints | Configuration for the public endpoint | object | n/a | yes |
| health_check | Health check configuration for the container service | object | See default in variables.tf | no |

## Outputs

| Name | Description |
|------|-------------|
| container_service_id | The ID of the Lightsail container service |
| container_service_name | The name of the Lightsail container service |
| container_service_power | The power specification of the container service |
| container_service_url | The URL of the container service |
| container_service_arn | The ARN of the container service |
| container_service_availability_zone | The availability zone of the container service |
| container_service_private_domain_name | The private domain name of the container service |
