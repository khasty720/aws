output "lightsail_container_service_url" {
  description = "The URL of the service"
  value       = module.lightsail_container_service.container_service_url
}

output "lightsail_container_service_availability_zone" {
  description = "The availability zone of the service"
  value       = module.lightsail_container_service.container_service_availability_zone
}
