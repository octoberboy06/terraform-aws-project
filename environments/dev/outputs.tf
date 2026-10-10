output "vpc_id" {
  description = "ID of the Dev VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "CIDR block of the Dev VPC"
  value       = module.vpc.vpc_cidr
}

output "subnet_ids" {
  description = "Map of Dev subnet names to subnet IDs"
  value       = module.subnet.subnet_ids
}

output "subnet_details" {
  description = "Details of all Dev subnets"
  value       = module.subnet.subnet_details
}

output "security_group_id" {
  description = "ID of the Dev security group"
  value       = module.security_group.security_group_id
}