variable "vpc_id" {
  description = "ID of the VPC"
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

variable "app_port" {
  description = "Application listening port"
  type        = number
  default     = 80
}

variable "db_port" {
  description = "Database listening port"
  type        = number
  default     = 3306
}