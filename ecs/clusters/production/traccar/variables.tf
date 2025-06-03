variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-2"
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "production"
}

variable "app_port" {
  description = "Port the application listens on"
  type        = number
  default     = 8082
}

variable "health_check_path" {
  description = "Health check path for the ALB target group"
  type        = string
  default     = "/api/server"
}

variable "container_image" {
  description = "Docker image to deploy (e.g., khasty720/traccar:latest)"
  type        = string
  default     = "khasty720/traccar:latest"
}

variable "container_cpu_architecture" {
  description = "CPU architecture for the container (e.g., ARM64, X86_64)"
  type        = string
  default     = "X86_64"
}

variable "container_cpu" {
  description = "CPU units for the container (1024 = 1 vCPU)"
  type        = number
  default     = 256
}

variable "container_memory" {
  description = "Memory for the container in MiB"
  type        = number
  default     = 512
}

variable "desired_count" {
  description = "Number of container instances to run"
  type        = number
  default     = 1
}

variable "max_capacity" {
  description = "Maximum number of container instances"
  type        = number
  default     = 1
}

variable "allowed_ip_ranges" {
  description = "List of CIDR blocks allowed to access the ALB"
  type        = list(string)
  default     = ["98.218.64.97/32"]  # Restricted to specific IP address
}

variable "certificate_arn" {
  description = "ARN of the SSL certificate for HTTPS"
  type        = string
  default     = "arn:aws:acm:us-east-2:987626324803:certificate/3ef26ec5-8ea8-4d25-8f86-56db8542f4cf"
}
