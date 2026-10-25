aws_region   = "ap-south-1"
project_name = "terraform-project"
environment  = "test"

vpc_cidr = "10.1.0.0/16"

subnets = {
  public-a = {
    cidr_block        = "10.1.1.0/24"
    availability_zone = "ap-south-1a"
    tier              = "public"
  }

  public-b = {
    cidr_block        = "10.1.2.0/24"
    availability_zone = "ap-south-1b"
    tier              = "public"
  }

  private-a = {
    cidr_block        = "10.1.11.0/24"
    availability_zone = "ap-south-1a"
    tier              = "private"
  }

  private-b = {
    cidr_block        = "10.1.12.0/24"
    availability_zone = "ap-south-1b"
    tier              = "private"
  }
}