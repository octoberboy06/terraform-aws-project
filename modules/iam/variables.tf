variable "role_name" {
  description = "Name of the IAM role for EC2"
  type        = string
}

variable "tags" {
  description = "Tags for IAM resources"
  type        = map(string)
  default     = {}
}