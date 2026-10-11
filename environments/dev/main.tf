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

  app_subnet_ids = {
    app-a = module.subnet.subnet_ids["app-a"]
    app-b = module.subnet.subnet_ids["app-b"]
  }

  db_subnet_ids = {
    db-a = module.subnet.subnet_ids["db-a"]
    db-b = module.subnet.subnet_ids["db-b"]
  }

  environment = var.environment
}


module "security_group" {
  source = "../../modules/security-group"

  vpc_id       = module.vpc.vpc_id
  project_name = var.project_name
  environment  = var.environment

  app_port = 80
  db_port  = 3306
}
