variable "public_subnet_id" {
  description = "ID of the public subnet where the NAT Gateway will be created"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}