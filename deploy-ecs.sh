#!/bin/bash
# deploy-ecs.sh - Script to deploy the ECS infrastructure

set -e

# Define colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to print status messages
print_status() {
  echo -e "${YELLOW}[$(date +"%T")] $1${NC}"
}

# Function to print success messages
print_success() {
  echo -e "${GREEN}[$(date +"%T")] $1${NC}"
}

# Function to print error messages
print_error() {
  echo -e "${RED}[$(date +"%T")] $1${NC}"
}

# Check if component is specified
if [ -z "$1" ]; then
  print_error "No component specified. Usage: ./deploy-ecs.sh <component> [environment]"
  print_status "Available components: shared, traccar, all"
  exit 1
fi

COMPONENT=$1
ENVIRONMENT=${2:-production}
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CLUSTERS_DIR="$BASE_DIR/ecs/clusters"

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
  print_error "AWS CLI is not installed. Please install it first."
  exit 1
fi

# Check if Terraform is installed
if ! command -v terraform &> /dev/null; then
  print_error "Terraform is not installed. Please install it first."
  exit 1
fi

# Check AWS credentials
print_status "Checking AWS credentials..."
if ! aws sts get-caller-identity &> /dev/null; then
  print_error "AWS credentials not configured. Please run 'aws configure' first."
  exit 1
fi
print_success "AWS credentials validated."

# Function to deploy a component
deploy_component() {
  local component_name=$1
  local component_dir="$CLUSTERS_DIR/$ENVIRONMENT/$component_name"
  
  if [ ! -d "$component_dir" ]; then
    print_error "Component directory not found: $component_dir"
    exit 1
  }
  
  print_status "Deploying $component_name in $ENVIRONMENT environment..."
  cd "$component_dir"
  
  # Initialize Terraform
  print_status "Initializing Terraform..."
  terraform init -upgrade
  print_success "Terraform initialized."
  
  # Validate Terraform configuration
  print_status "Validating Terraform configuration..."
  terraform validate
  print_success "Terraform configuration is valid."
  
  # Run Terraform plan
  print_status "Creating execution plan..."
  terraform plan -out=tfplan
  print_success "Execution plan created."
  
  # Ask for confirmation before applying
  echo ""
  read -p "Do you want to apply this plan for $component_name? (y/n) " -n 1 -r
  echo ""
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    print_status "Deployment cancelled for $component_name."
    return
  fi
  
  # Apply Terraform plan
  print_status "Applying Terraform plan for $component_name..."
  terraform apply tfplan
  print_success "Terraform plan applied successfully for $component_name!"
  
  # Output important information
  echo ""
  print_status "$component_name Deployment Outputs:"
  echo ""
  terraform output
}

# Deploy components based on input
case "$COMPONENT" in
  shared)
    deploy_component "shared"
    ;;
  traccar)
    deploy_component "traccar"
    ;;
  all)
    deploy_component "shared"
    deploy_component "traccar"
    ;;
  *)
    print_error "Unknown component: $COMPONENT"
    print_status "Available components: shared, traccar, all"
    exit 1
    ;;
esac

echo ""
print_success "Deployment process complete!"
