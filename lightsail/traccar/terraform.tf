terraform {
  required_version = ">= 1.0.0"

  backend "s3" {
    bucket         = "khasty-terraform-state"
    key            = "lightsail/traccar-production/terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}