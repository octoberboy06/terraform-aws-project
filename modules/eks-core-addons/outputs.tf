
output "coredns_arn" {
  value = aws_eks_addon.coredns.arn
}

output "kube_proxy_arn" {
  value = aws_eks_addon.kube_proxy.arn
}
