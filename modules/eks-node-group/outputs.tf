output "node_group_id" {
  description = "EKS managed node group ID"
  value       = aws_eks_node_group.this.id
}

output "node_group_arn" {
  description = "EKS managed node group ARN"
  value       = aws_eks_node_group.this.arn
}

output "node_group_status" {
  description = "EKS managed node group status"
  value       = aws_eks_node_group.this.status
}