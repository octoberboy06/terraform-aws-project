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
  }))
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "ami_id" {
  description = "AMI Id for the instance"
  type        = string
}

variable "instance_type" {
  description = "AMI Id for the instance"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}