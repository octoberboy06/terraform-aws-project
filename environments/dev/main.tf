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

module "security_group" {
  source = "../../modules/security-group"

  name        = "${var.project_name}-${var.environment}-sg"
  description = "Security group for Dev EC2 instances"

  vpc_id   = module.vpc.vpc_id
  vpc_cidr = module.vpc.vpc_cidr

  tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
