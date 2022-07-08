data "template_file" "user_data" {
  template = file("${path.module}/user-data.sh")
}

module "autoscaling" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "6.5.1"

  name = "${local.resource_name}-asg"

  vpc_zone_identifier = module.vpc.private_subnets

  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity

  image_id      = var.image_id
  instance_type = var.instance_type

  target_group_arns = module.alb.target_group_arns

  launch_template_name        = "lt-${local.resource_name}"
  launch_template_description = "website launch template"
  update_default_version      = true
  user_data                   = base64encode(data.template_file.user_data.rendered)

  network_interfaces = [
    {
      associate_public_ip_address = false
      security_groups             = [aws_security_group.this.id]
      delete_on_termination       = true
    }
  ]

  tags = local.tags
}

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "6.5.0"

  name               = local.resource_name
  load_balancer_type = "application"
  vpc_id             = module.vpc.vpc_id
  subnets            = module.vpc.private_subnets
  security_groups    = [aws_security_group.this.id]
  internal           = true
  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = aws_acm_certificate.private_cert.arn
      target_group_index = 0
    }
  ]
  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]
  target_groups = [
    {
      name                 = local.resource_name
      backend_protocol     = "HTTP"
      backend_port         = 80
      target_type          = "instance"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 60
        path                = "/"
        port                = "traffic-port"
        healthy_threshold   = 2
        unhealthy_threshold = 6
        timeout             = 30
        protocol            = "HTTP"
        matcher             = "200"
      }
      protocol_version = "HTTP1"
      tags             = merge({ Name = local.resource_name }, local.tags)
    }
  ]
  tags = merge({ Name = local.resource_name }, local.tags)
}


data "aws_route53_zone" "selected" {
  name         = var.hosted_zone
  private_zone = true
}

resource "aws_route53_record" "route53_record" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = local.record_name
  type    = "A"

  alias {
    name                   = module.alb.lb_dns_name
    zone_id                = module.alb.lb_zone_id
    evaluate_target_health = true
  }
}

resource "aws_acm_certificate" "private_cert" {
  domain_name       = local.record_name
  validation_method = "DNS"

  tags = merge({ Name = local.resource_name }, local.tags)

  lifecycle {
    create_before_destroy = true
  }
}
