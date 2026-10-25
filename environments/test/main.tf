module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr = var.vpc_cidr
  name     = "${var.project_name}-${var.environment}-vpc"

  tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

module "subnet" {
  source = "../../modules/subnet"

  vpc_id      = module.vpc.vpc_id
  environment = var.environment
  subnets     = var.subnets
}