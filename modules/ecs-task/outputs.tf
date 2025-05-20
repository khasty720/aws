output "task_definition_arn" {
  description = "ARN of the Task Definition"
  value       = aws_ecs_task_definition.app.arn
}

output "task_definition_family" {
  description = "Family of the Task Definition"
  value       = aws_ecs_task_definition.app.family
}

output "container_name" {
  description = "Name of the container"
  value       = local.container_name
}
