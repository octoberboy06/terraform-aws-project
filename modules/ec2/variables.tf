variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "subnet_ids" {
  description = "Subnet IDs where EC2 instances will be deployed"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security groups attached to the EC2 instances"
  type        = list(string)
}

variable "name" {
  description = "Name prefix for EC2 instances"
  type        = string
}

variable "key_name" {
  description = "Optional EC2 key pair name"
  type        = string
  default     = null
}

variable "root_volume_size" {
  description = "Root EBS volume size in GB"
  type        = number
  default     = 8
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}