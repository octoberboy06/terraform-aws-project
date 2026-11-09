output "vpc_id" {
  description = "ID of the Test VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "CIDR block of the Test VPC"
  value       = module.vpc.vpc_cidr
}

output "internet_gateway_id" {
  description = "ID of the Test Internet Gateway"
  value       = module.vpc.internet_gateway_id
}

output "subnet_ids" {
  description = "IDs of the Test environment subnets"
  value       = module.subnet.subnet_ids
}

output "subnet_availability_zones" {
  description = "Availability Zones of the Test environment subnets"
  value       = module.subnet.subnet_availability_zones
}

output "public_route_table_id" {
  description = "ID of the Test public route table"
  value       = module.routing.public_route_table_id
}

output "private_route_table_id" {
  description = "ID of the Test private route table"
  value       = module.routing.private_route_table_id
}

output "eks_cluster_role_arn" {
  description = "ARN of the Test EKS cluster IAM role"
  value       = module.eks_iam.cluster_role_arn
}

output "eks_node_role_arn" {
  description = "ARN of the Test EKS worker node IAM role"
  value       = module.eks_iam.node_role_arn
}

output "nat_gateway_id" {
  description = "ID of the Test NAT Gateway"
  value       = module.nat.nat_gateway_id
}

output "eks_cluster_name" {
  description = "Name of the Test EKS cluster"
  value       = module.eks.cluster_name
}

output "eks_cluster_arn" {
  description = "ARN of the Test EKS cluster"
  value       = module.eks.cluster_arn
}

output "eks_cluster_endpoint" {
  description = "Kubernetes API endpoint"
  value       = module.eks.cluster_endpoint
}

output "eks_node_group_id" {
  description = "EKS managed node group ID"
  value       = module.eks_node_group.node_group_id
}

output "eks_node_group_status" {
  description = "EKS managed node group status"
  value       = module.eks_node_group.node_group_status
}


output "eks_pod_identity_agent_arn" {
  description = "ARN of the EKS Pod Identity Agent add-on"
  value       = module.eks_addons.pod_identity_agent_arn
}

output "eks_vpc_cni_arn" {
  description = "ARN of the EKS VPC CNI add-on"
  value       = module.eks_addons.vpc_cni_arn
}

output "eks_coredns_arn" {
  description = "ARN of the EKS CoreDNS add-on"
  value       = module.eks_core_addons.coredns_arn
}

output "eks_kube_proxy_arn" {
  description = "ARN of the EKS kube-proxy add-on"
  value       = module.eks_core_addons.kube_proxy_arn
}
