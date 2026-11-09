output "cluster_role_arn" {
  description = "ARN of the EKS cluster IAM role"
  value       = aws_iam_role.eks_cluster.arn
}

output "node_role_arn" {
  description = "ARN of the EKS node IAM role"
  value       = aws_iam_role.eks_node.arn
}

output "cni_role_arn" {
  description = "ARN of the EKS CNI IAM role"
  value       = aws_iam_role.eks_cni.arn
}