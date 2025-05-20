variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "cluster_id" {
  description = "ID of the ECS cluster"
  type        = string
}

variable "task_definition_arn" {
  description = "ARN of the task definition"
  type        = string
}

variable "container_name" {
  description = "Name of the container"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "subnets" {
  description = "List of subnet IDs for the ECS tasks"
  type        = list(string)
}

variable "app_port" {
  description = "Port the application listens on"
  type        = number
}

variable "desired_count" {
  description = "Number of container instances to run"
  type        = number
  default     = 2
}

variable "min_capacity" {
  description = "Minimum number of container instances"
  type        = number
  default     = 1
}

variable "max_capacity" {
  description = "Maximum number of container instances"
  type        = number
  default     = 4
}

variable "cpu_utilization_threshold" {
  description = "CPU utilization threshold for scaling"
  type        = number
  default     = 70
}

variable "memory_utilization_threshold" {
  description = "Memory utilization threshold for scaling"
  type        = number
  default     = 70
}

variable "assign_public_ip" {
  description = "Whether to assign public IPs to the Fargate tasks"
  type        = bool
  default     = false
}

variable "target_group_arn" {
  description = "ARN of the ALB target group"
  type        = string
  default     = ""
}

variable "security_groups" {
  description = "List of security group IDs to assign to the service"
  type        = list(string)
  default     = []
}

variable "create_security_group" {
  description = "Whether to create a security group for the service"
  type        = bool
  default     = true
}

variable "security_group_ingress_cidr" {
  description = "CIDR blocks for ingress rules when creating a security group"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
