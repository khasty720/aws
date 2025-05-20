output "service_id" {
  description = "ID of the ECS service"
  value       = aws_ecs_service.main.id
}

output "service_name" {
  description = "Name of the ECS service"
  value       = aws_ecs_service.main.name
}

output "security_group_id" {
  description = "ID of the security group for the ECS service"
  value       = var.create_security_group ? aws_security_group.ecs_tasks[0].id : null
}
