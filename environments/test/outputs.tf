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

output "nat_gateway_id" {
  description = "ID of the Test NAT Gateway"
  value       = module.nat.nat_gateway_id
}