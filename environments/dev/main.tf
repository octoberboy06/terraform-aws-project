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

  vpc_id  = module.vpc.vpc_id
  subnets = var.subnets

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



module "ec2" {
  source = "../../modules/ec2"

  ami_id        = var.ami_id
  instance_type = var.instance_type

  subnet_id = module.subnet.subnet_ids["private-a"]

  security_group_ids = [
    module.security_group.security_group_id
  ]

  name = "${var.project_name}-${var.environment}-ec2"

  tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}


module "ec2" {
  source = "../../modules/ec2"

  ami_id        = var.ami_id
  instance_type = var.instance_type

  subnet_id = module.subnet.subnet_ids["private-b"]

  security_group_ids = [
    module.security_group.security_group_id
  ]

  name = "${var.project_name}-${var.environment}-ec2"

  tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}