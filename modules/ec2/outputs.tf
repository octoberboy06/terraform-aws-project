output "instance_id" {
  description = "IDs of the EC2 instances"
  value       = aws_instance.this.id
}

output "private_ips" {
  description = "Private IP addresses of the EC2 instances"
  value       = aws_instance.this.private_ip
}