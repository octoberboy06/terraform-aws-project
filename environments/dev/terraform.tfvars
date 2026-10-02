aws_region   = "ap-south-1"
project_name = "terraform-project"
environment  = "dev"

vpc_cidr = "10.0.0.0/16"

subnets = {
  private-a = {
    cidr_block        = "10.0.1.0/24"
    availability_zone = "ap-south-1a"
  }

  private-b = {
    cidr_block        = "10.0.2.0/24"
    availability_zone = "ap-south-1b"
  }
}

ami_id = "ami-01a00762f46d584a1"

instance_type = "t2.micro"
 