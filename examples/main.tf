data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name = "name"
    values = [
      "amzn-ami-hvm-*-x86_64-gp2",
    ]
  }
}

module "studocu_website" {
  source = "../"

  owner = "devops_team@email"
  env   = "dev"

  min_size         = 0
  max_size         = 3
  desired_capacity = 2

  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  domain_name = var.domain_name
  hosted_zone = var.hosted_zone
}
