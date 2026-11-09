aws_region          = "ap-south-1"
project_name        = "terraform-project"
environment         = "test"
vpc_cidr            = "10.1.0.0/16"
public_access_cidrs = ["49.207.216.126/32"]

subnets = {
  public-a = {
    cidr_block        = "10.1.1.0/24"
    availability_zone = "ap-south-1a"
    tier              = "public"

    tags = {
      "kubernetes.io/cluster/terraform-project-test-eks" = "shared"
      "kubernetes.io/role/elb"                           = "1"
    }
  }

  public-b = {
    cidr_block        = "10.1.2.0/24"
    availability_zone = "ap-south-1b"
    tier              = "public"

    tags = {
      "kubernetes.io/cluster/terraform-project-test-eks" = "shared"
      "kubernetes.io/role/elb"                           = "1"
    }
  }

  private-a = {
    cidr_block        = "10.1.11.0/24"
    availability_zone = "ap-south-1a"
    tier              = "private"

    tags = {
      "kubernetes.io/cluster/terraform-project-test-eks" = "shared"
      "kubernetes.io/role/internal-elb"                  = "1"
    }
  }

  private-b = {
    cidr_block        = "10.1.12.0/24"
    availability_zone = "ap-south-1b"
    tier              = "private"

    tags = {
      "kubernetes.io/cluster/terraform-project-test-eks" = "shared"
      "kubernetes.io/role/internal-elb"                  = "1"
    }
  }
}