module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"

  name = "main-vpc"

  cidr = "10.13.40.0/22"

  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  public_subnets  = ["10.13.42.128/25", "10.13.42.0/25"]
  private_subnets = ["10.13.41.0/25", "10.13.42.0/25"]

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = local.tags
}
