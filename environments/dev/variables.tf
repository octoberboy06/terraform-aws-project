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

variable "enable_alb" {
  description = "Controls whether the Application Load Balancer is created"
  type        = bool
  default     = false
}

variable "app_instance_type" {
  description = "Instance type for application servers"
  type        = string
  default     = "t3.micro"
}

variable "app_min_size" {
  type    = number
  default = 0
}

variable "app_desired_capacity" {
  type    = number
  default = 0
}

variable "app_max_size" {
  type    = number
  default = 2
}

variable "enable_nat" {
  description = "Controls whether the NAT Gateway is created"
  type        = bool
  default     = false
}