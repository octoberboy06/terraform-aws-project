output "pod_identity_agent_arn" {
  value = aws_eks_addon.pod_identity_agent.arn
}

output "vpc_cni_arn" {
  value = aws_eks_addon.vpc_cni.arn
}