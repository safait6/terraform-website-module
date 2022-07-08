locals {
  resource_name = "studocu-website"
  record_name   = "${var.domain_name}.devops.studocu.com"

  tags = {
    Owner       = var.owner
    Environment = var.env
  }
}
