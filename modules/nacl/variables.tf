variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "public_subnet_ids" {
  description = "Map of public subnet IDs"
  type        = map(string)
}

variable "app_subnet_ids" {
  description = "Map of application subnet IDs"
  type        = map(string)
}

variable "db_subnet_ids" {
  description = "Map of database subnet IDs"
  type        = map(string)
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}