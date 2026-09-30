terraform {
  backend "s3" {
    bucket       = "notyourhappypill-terraform-dev"
    key          = "/dev/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}