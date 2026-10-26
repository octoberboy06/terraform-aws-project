output "public_route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.public.id
}

output "private_route_table_id" {
  description = "ID of the private route table"
  value       = length(aws_route_table.private) > 0 ? aws_route_table.private[0].id : null
}

output "app_route_table_id" {
  description = "ID of the application route table"
  value       = length(aws_route_table.app) > 0 ? aws_route_table.app[0].id : null
}

output "db_route_table_id" {
  description = "ID of the database route table"
  value       = length(aws_route_table.db) > 0 ? aws_route_table.db[0].id : null
}