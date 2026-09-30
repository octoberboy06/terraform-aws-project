output "subnet_id" {
  description = "IDs of the private subnets"
  value       = aws_subnet.this.id
}

output "route_table_id" {
  description = "ID of the private route table"
  value       = aws_route_table.this.id
}