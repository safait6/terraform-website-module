resource "aws_security_group" "vpc_sg" {
  name        = "vpc-endpoint-main-int"
  description = "Allow TLS inbound traffic"
  vpc_id      = module.vpc.vpc_id
  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }
  tags = local.tags
}

resource "aws_security_group" "this" {
  name        = local.resource_name
  description = "website traffic"
  vpc_id      = module.vpc.vpc_id
  tags        = merge({ Name = local.resource_name }, local.tags)
}

resource "aws_security_group_rule" "https_access" {
  description       = "Enable https access"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = concat(var.ingress_cidr_blocks, [module.vpc.vpc_cidr_block])
  security_group_id = aws_security_group.this.id
}

resource "aws_security_group_rule" "http_access" {
  description       = "Enable http access"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = concat(var.ingress_cidr_blocks, [module.vpc.vpc_cidr_block])
  security_group_id = aws_security_group.this.id
}

resource "aws_security_group_rule" "egress_rule" {
  description       = "Egress rule"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this.id
}

resource "aws_security_group_rule" "self_access" {
  description       = "Access from self"
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  self              = true
  security_group_id = aws_security_group.this.id
}
