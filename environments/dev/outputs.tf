output "vpc_id" {
  description = "ID of the Dev VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "CIDR block of the Dev VPC"
  value       = module.vpc.vpc_cidr
}
output "private_subnet_ids" {
  description = "IDs of the Dev private subnets"
  value       = module.subnet.subnet_ids
}

output "private_route_table_id" {
  description = "ID of the Dev private route table"
  value       = module.subnet.route_table_id
}