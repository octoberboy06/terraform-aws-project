aws_region   = "ap-south-1"
project_name = "terraform-project"
environment  = "dev"

vpc_cidr = "10.0.0.0/16"

subnets = {
  public-a = {
    cidr_block        = "10.0.1.0/24"
    availability_zone = "ap-south-1a"
    tier              = "public"
  }

  public-b = {
    cidr_block        = "10.0.2.0/24"
    availability_zone = "ap-south-1b"
    tier              = "public"
  }

  app-a = {
    cidr_block        = "10.0.11.0/24"
    availability_zone = "ap-south-1a"
    tier              = "app"
  }

  app-b = {
    cidr_block        = "10.0.12.0/24"
    availability_zone = "ap-south-1b"
    tier              = "app"
  }

  db-a = {
    cidr_block        = "10.0.21.0/24"
    availability_zone = "ap-south-1a"
    tier              = "db"
  }

  db-b = {
    cidr_block        = "10.0.22.0/24"
    availability_zone = "ap-south-1b"
    tier              = "db"
  }
}

ami_id = "ami-01a00762f46d584a1"

instance_type = "t3.micro"
 