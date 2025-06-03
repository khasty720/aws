module "lightsail_container_service" {
  source = "../../modules/lightsail-container-service"

  service_name = "${var.service_name}-${var.environment}"
  power        = var.power_size
  scale        = var.scale

  container = {
    name        = var.container_name
    image       = var.container_image
    ports       = var.container_ports
    environment = var.container_environment_variables
  }
  
  public_endpoint = {
    container_name = var.container_name
    container_port = var.public_endpoint_container_port
  }
  
  health_check = var.health_check

  tags = merge({
    Environment = var.environment
    Project     = var.service_name
    ManagedBy   = "terraform"
  }, var.tags)
}

