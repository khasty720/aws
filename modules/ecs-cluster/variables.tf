variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "enable_container_insights" {
  description = "Whether to enable container insights"
  type        = bool
  default     = true
}
