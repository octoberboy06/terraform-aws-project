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

output "alb_security_group_id" {
  description = "ID of the ALB security group"
  value       = module.security_group.alb_security_group_id
}

output "app_security_group_id" {
  description = "ID of the application security group"
  value       = module.security_group.app_security_group_id
}

output "db_security_group_id" {
  description = "ID of the database security group"
  value       = module.security_group.db_security_group_id
}

output "internet_gateway_id" {
  description = "ID of the Dev Internet Gateway"
  value       = module.vpc.internet_gateway_id
}

output "public_route_table_id" {
  description = "ID of the Dev public route table"
  value       = module.routing.public_route_table_id
}

output "app_route_table_id" {
  description = "ID of the Dev application route table"
  value       = module.routing.app_route_table_id
}

output "db_route_table_id" {
  description = "ID of the Dev database route table"
  value       = module.routing.db_route_table_id
}

output "ec2_iam_role_name" {
  description = "Name of the Dev EC2 IAM role"
  value       = module.iam.ec2_role_name
}

output "ec2_instance_profile_name" {
  description = "Name of the Dev EC2 instance profile"
  value       = module.iam.ec2_instance_profile_name
}

output "public_nacl_id" {
  description = "ID of the Dev public Network ACL"
  value       = module.nacl.public_nacl_id
}

output "app_nacl_id" {
  description = "ID of the Dev application Network ACL"
  value       = module.nacl.app_nacl_id
}

output "db_nacl_id" {
  description = "ID of the Dev database Network ACL"
  value       = module.nacl.db_nacl_id
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = var.enable_alb ? module.alb[0].alb_dns_name : null
}

output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = var.enable_alb ? module.alb[0].alb_arn : null
}

output "alb_target_group_arn" {
  description = "ARN of the ALB target group"
  value       = var.enable_alb ? module.alb[0].target_group_arn : null
}