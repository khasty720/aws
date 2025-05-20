output "cluster_name" {
  description = "Name of the ECS Cluster"
  value       = aws_ecs_cluster.main.name
}

output "service_name" {
  description = "Name of the ECS Service"
  value       = aws_ecs_service.main.name
}

output "task_definition_arn" {
  description = "ARN of the Task Definition"
  value       = aws_ecs_task_definition.app.arn
}
