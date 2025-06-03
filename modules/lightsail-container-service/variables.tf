variable "service_name" {
  description = "The name of the Lightsail container service"
  type        = string
}

variable "power" {
  description = "The power specification for the container service (nano, micro, small, medium, large, xlarge)"
  type        = string
  default     = "nano"
  validation {
    condition     = contains(["nano", "micro", "small", "medium", "large", "xlarge"], var.power)
    error_message = "The power must be one of: nano, micro, small, medium, large, xlarge."
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

variable "is_disabled" {
  description = "Whether the container service is disabled"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Key-value map of resource tags"
  type        = map(string)
  default     = {}
}

variable "ecr_access_role_arn" {
  description = "The ARN of the IAM role with permission to pull images from ECR"
  type        = string
  default     = null
}

variable "container" {
  description = "Container configuration"
  default = {
    name  = null
    image = null
    command     = null
    environment = {}
    ports       = {}
  }
}

variable "public_endpoint" {
  description = "Configuration for the public endpoint"
}

variable "health_check" {
  description = "Health check configuration for the container service"
  default = {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout_seconds     = 2
    interval_seconds    = 5
    path                = "/"
    success_codes       = "200-499"
  }
}
