variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  type        = string
}

variable "public_subnet_ids" {
  description = "IDs of the public subnets"
  type        = map(string)
  default     = {}
}

variable "private_subnet_ids" {
  description = "IDs of the private subnets"
  type        = map(string)
  default     = {}
}

variable "app_subnet_ids" {
  description = "IDs of the application subnets"
  type        = map(string)
  default     = {}
}

variable "db_subnet_ids" {
  description = "IDs of the database subnets"
  type        = map(string)
  default     = {}
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "nat_gateway_id" {
  description = "ID of the NAT Gateway for private subnet internet access"
  type        = string
  default     = null
}

variable "enable_nat" {
  description = "Controls whether internet access through NAT is created"
  type        = bool
  default     = false
}