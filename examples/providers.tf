provider "aws" {
  region = "eu-west-1"

  assume_role {
    role_arn = var.aws_role_arn
  }
}
