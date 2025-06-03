resource "aws_lightsail_container_service" "container_service" {
  name        = var.service_name
  power       = var.power
  scale       = var.scale
  is_disabled = var.is_disabled

  tags = var.tags
}

resource "aws_lightsail_container_service_deployment_version" "container_service_deployment_version" {
  service_name = aws_lightsail_container_service.container_service.name

  container {
    container_name = var.container.name
    image          = var.container.image
    command        = lookup(var.container, "command", null)
    environment    = lookup(var.container, "environment", {})
    ports          = lookup(var.container, "ports", {})
  }

  public_endpoint {
    container_name = var.public_endpoint.container_name
    container_port = var.public_endpoint.container_port

    health_check {
      healthy_threshold   = var.health_check.healthy_threshold
      unhealthy_threshold = var.health_check.unhealthy_threshold
      timeout_seconds     = var.health_check.timeout_seconds
      interval_seconds    = var.health_check.interval_seconds
      path                = var.health_check.path
      success_codes       = var.health_check.success_codes
    }
  }
}
