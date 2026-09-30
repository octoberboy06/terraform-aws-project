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

output "security_group_id" {
  description = "ID of the Dev EC2 security group"
  value       = module.security_group.security_group_id
}

output "ec2_1_instance_id" {
  description = "IDs of the Dev EC2 instances"
  value       = module.ec2_1.instance_id
}

output "ec2_2_instance_id" {
  description = "IDs of the Dev EC2 instances"
  value       = module.ec2_2.instance_id
}

output "ec2_1_private_ip" {
  description = "Private IP addresses of the Dev EC2 instances"
  value       = module.ec2_1.private_ip
}

output "ec2_2_private_ip" {
  description = "Private IP addresses of the Dev EC2 instances"
  value       = module.ec2_2.private_ip
}