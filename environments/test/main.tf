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

module "nat" {
  source = "../../modules/nat"

  public_subnet_id = module.subnet.subnet_ids["public-a"]

  project_name = var.project_name
  environment  = var.environment
}

module "routing" {
  source = "../../modules/routing"

  vpc_id              = module.vpc.vpc_id
  internet_gateway_id = module.vpc.internet_gateway_id

  enable_nat     = true
  nat_gateway_id = module.nat.nat_gateway_id

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

module "eks_iam" {
  source = "../../modules/eks-iam"

  project_name = var.project_name
  environment  = var.environment
}

module "eks" {
  source = "../../modules/eks"

  cluster_name     = "${var.project_name}-${var.environment}-eks"
  cluster_role_arn = module.eks_iam.cluster_role_arn

  subnet_ids = [
    module.subnet.subnet_ids["private-a"],
    module.subnet.subnet_ids["private-b"]
  ]

  public_access_cidrs = var.public_access_cidrs

  kubernetes_version = "1.37"
  project_name       = var.project_name
  environment        = var.environment

  depends_on = [
    module.eks_iam
  ]
}

module "eks_node_group" {
  source = "../../modules/eks-node-group"

  cluster_name    = module.eks.cluster_name
  node_group_name = "${var.project_name}-${var.environment}-node-group"
  node_role_arn   = module.eks_iam.node_role_arn

  subnet_ids = [
    module.subnet.subnet_ids["private-a"],
    module.subnet.subnet_ids["private-b"]
  ]

  instance_types = ["t3.small"]

  desired_size = 1
  min_size     = 1
  max_size     = 2

  project_name = var.project_name
  environment  = var.environment

  depends_on = [
    module.eks,
    module.eks_addons
  ]
}


module "eks_addons" {
  source = "../../modules/eks-addons"

  cluster_name = module.eks.cluster_name

  pod_identity_agent_version = "v1.4.1-eksbuild.3"
  vpc_cni_version            = "v1.23.2-eksbuild.8"

  cni_role_arn = module.eks_iam.cni_role_arn

  project_name = var.project_name
  environment  = var.environment

  depends_on = [
    module.eks,
    module.eks_iam
  ]
}

module "eks_core_addons" {
  source = "../../modules/eks-core-addons"

  cluster_name = module.eks.cluster_name

  coredns_version    = "v1.14.7-eksbuild.22"
  kube_proxy_version = "v1.37.0-eksbuild.32"

  project_name = var.project_name
  environment  = var.environment

  depends_on = [
    module.eks_node_group
  ]
}
