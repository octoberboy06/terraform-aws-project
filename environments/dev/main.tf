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
data "aws_availability_zones" "available" {
  state = "available"
}

module "subnet" {
  source = "../../modules/subnet"

  vpc_id = module.vpc.vpc_id

  subnet_cidrs = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  availability_zones = slice(
    data.aws_availability_zones.available.names,
    0,
    2
  )

  name = "${var.project_name}-${var.environment}-private-subnet"

  tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}