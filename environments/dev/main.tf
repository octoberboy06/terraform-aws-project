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

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

module "ec2" {
  source = "../../modules/ec2"

  ami_id        = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  subnet_ids = module.subnet.subnet_ids

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