# Shared state variables - these can be used when remote state is not available
variable "environment" {
  description = "The deployment environment (dev, staging, production)"
  type        = string
  default     = "production"
}

variable "service_name" {
  description = "The name of the service"
  type        = string
  default     = "traccar"
}

variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-east-2"
}

variable "tags" {
  description = "Additional tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "power_size" {
  description = "The power specification for the Lightsail container service"
  type        = string
  default     = "micro"
  validation {
    condition     = contains(["nano", "micro", "small", "medium", "large", "xlarge"], var.power_size)
    error_message = "The power_size must be one of: nano, micro, small, medium, large, xlarge."
  }
}

variable "scale" {
  description = "The number of compute nodes for the container service"
  type        = number
  default     = 1
  validation {
    condition     = var.scale >= 1 && var.scale <= 20
    error_message = "The scale must be between 1 and 20."
  }
}

variable "container_name" {
  description = "The name of the container"
  type        = string
  default     = "traccar"
}

variable "container_image" {
  description = "The container image to use"
  type        = string
  default     = "khasty720/traccar:canary"
}

variable "container_ports" {
  description = "Map of container ports to protocol"
  type        = map(string)
  default     = {
    80 = "HTTP"
  }
}

variable "container_environment_variables" {
  description = "Environment variables for the container"
  type        = map(string)
  default     = {}
}

variable "public_endpoint_container_name" {
  description = "The name of the container for the public endpoint"
  type        = string
  default     = "traccar"
}

variable "public_endpoint_container_port" {
  description = "The port of the container for the public endpoint"
  type        = number
  default     = 80
}

variable "health_check" {
  description = "Health check configuration for the container service"
  type = object({
    healthy_threshold   = number
    unhealthy_threshold = number
    timeout_seconds     = number
    interval_seconds    = number
    path                = string
    success_codes       = string
  })
  default = {
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout_seconds     = 3
    interval_seconds    = 10
    path                = "/api/server"
    success_codes       = "200"
  }
}
