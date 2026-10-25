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