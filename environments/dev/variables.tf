variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnets" {
  description = "Configuration of subnets to create"

  type = map(object({
    cidr_block        = string
    availability_zone = string
    tier              = string
    tags              = optional(map(string), {})
  }))
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}