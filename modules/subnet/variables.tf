variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "subnet_cidrs" {
  description = "CIDR blocks for the private subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "Availability Zones for the private subnets"
  type        = list(string)
}

variable "name" {
  description = "Name prefix for subnet resources"
  type        = string
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}