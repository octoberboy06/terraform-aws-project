output "public_nacl_id" {
  description = "ID of the public Network ACL"
  value       = aws_network_acl.public.id
}

output "app_nacl_id" {
  description = "ID of the application Network ACL"
  value       = aws_network_acl.app.id
}

output "db_nacl_id" {
  description = "ID of the database Network ACL"
  value       = aws_network_acl.db.id
}