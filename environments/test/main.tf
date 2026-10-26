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

module "routing" {
  source = "../../modules/routing"

  vpc_id              = module.vpc.vpc_id
  internet_gateway_id = module.vpc.internet_gateway_id

  public_subnet_ids = {
    public-a = module.subnet.subnet_ids["public-a"]
    public-b = module.subnet.subnet_ids["public-b"]
  }

  private_subnet_ids = {
    private-a = module.subnet.subnet_ids["private-a"]
    private-b = module.subnet.subnet_ids["private-b"]
  }

  environment = var.environment
}