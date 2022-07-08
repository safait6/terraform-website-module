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


variable "env" {
  description = "Current stack environment."
  type        = string
}

variable "owner" {
  description = "Owner of the resource (Team mailing list)."
  type        = string
}

variable "image_id" {
  description = "The EC2 golden image ID to launch"
  type        = string
}

variable "instance_type" {
  description = "The size of instance to launch."
  type        = string
  default     = "t3a.small"
}

variable "max_size" {
  description = "The maximum size of the auto scale group"
  type        = string
}

variable "min_size" {
  description = "The minimum size of the auto scale group"
  type        = string
}

variable "desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group"
  type        = string
}
