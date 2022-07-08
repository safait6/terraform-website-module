variable "aws_role_arn" {
  description = "Amazon Resource Name (ARN) of the IAM Role to assume. This is provided as TFE variable."
  type        = string
}

variable "hosted_zone" {
  description = "the name of the hosted zone"
  type        = string
}

variable "domain_name" {
  description = "The name of the domain to be chosen."
  type        = string
}

variable "ingress_cidr_blocks" {
  description = "List of CIDR to acces to the website, to be defined (private :from where the user is going to access )"
  type        = list(string)
  default     = []
}
