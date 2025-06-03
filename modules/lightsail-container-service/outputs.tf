output "container_service_id" {
  description = "The ID of the Lightsail container service"
  value       = aws_lightsail_container_service.container_service.id
}

output "container_service_name" {
  description = "The name of the Lightsail container service"
  value       = aws_lightsail_container_service.container_service.name
}

output "container_service_power" {
  description = "The power specification of the container service"
  value       = aws_lightsail_container_service.container_service.power
}

output "container_service_url" {
  description = "The URL of the container service"
  value       = aws_lightsail_container_service.container_service.url
}

output "container_service_arn" {
  description = "The ARN of the container service"
  value       = aws_lightsail_container_service.container_service.arn
}

output "container_service_availability_zone" {
  description = "The availability zone of the container service"
  value       = aws_lightsail_container_service.container_service.availability_zone
}

output "container_service_private_domain_name" {
  description = "The private domain name of the container service"
  value       = aws_lightsail_container_service.container_service.private_domain_name
}
