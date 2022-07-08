# terraform-studocu-website

Terraform module describing a website running behind a load-balancer in AWS.

the module will create several aws resources to deploy the website: EC2 instance, ASG( to scale our ec2 instances),Application Load balencer (target groups): to manage the website traffic,security-groups to control traffic access rights, and VPC where we regroup all the previous units so that we can access to the website from internet.

you can look at the diagram(diagram_studocu.png) for the architecture.

PS:

- ingress_cidr_blocks variable : i didn't want to put a specific one nor open it to internet. it's going to depend where the user is connected from.
- To create the infrastructure resources into aws : you need to be placed in examples/
- before running terraform plan/apply, please verify that certain values suit you otherwise you can modify them.

Enjoy your runs :)

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                                     | Version   |
| ------------------------------------------------------------------------ | --------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 0.14.0 |
| <a name="requirement_aws"></a> [aws](#requirement_aws)                   | >= 3.42.0 |

## Providers

| Name                                                            | Version |
| --------------------------------------------------------------- | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws)                | 4.22.0  |
| <a name="provider_template"></a> [template](#provider_template) | 2.2.0   |

## Modules

| Name                                                                 | Source                                | Version |
| -------------------------------------------------------------------- | ------------------------------------- | ------- |
| <a name="module_alb"></a> [alb](#module_alb)                         | terraform-aws-modules/alb/aws         | 6.5.0   |
| <a name="module_autoscaling"></a> [autoscaling](#module_autoscaling) | terraform-aws-modules/autoscaling/aws | 6.5.1   |
| <a name="module_vpc"></a> [vpc](#module_vpc)                         | terraform-aws-modules/vpc/aws         | ~> 3.0  |

## Resources

| Name                                                                                                                                    | Type        |
| --------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_acm_certificate.private_cert](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate)         | resource    |
| [aws_route53_record.route53_record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record)         | resource    |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)                   | resource    |
| [aws_security_group.vpc_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)                 | resource    |
| [aws_security_group_rule.egress_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule)  | resource    |
| [aws_security_group_rule.http_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule)  | resource    |
| [aws_security_group_rule.https_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource    |
| [aws_security_group_rule.self_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule)  | resource    |
| [aws_route53_zone.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone)                | data source |
| [template_file.user_data](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file)                     | data source |

## Inputs

| Name                                                                                       | Description                                                                                            | Type           | Default       | Required |
| ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------ | -------------- | ------------- | :------: |
| <a name="input_desired_capacity"></a> [desired_capacity](#input_desired_capacity)          | The number of Amazon EC2 instances that should be running in the group                                 | `string`       | n/a           |   yes    |
| <a name="input_domain_name"></a> [domain_name](#input_domain_name)                         | The name of the domain to be chosen.                                                                   | `string`       | n/a           |   yes    |
| <a name="input_env"></a> [env](#input_env)                                                 | Current stack environment.                                                                             | `string`       | n/a           |   yes    |
| <a name="input_hosted_zone"></a> [hosted_zone](#input_hosted_zone)                         | the name of the hosted zone                                                                            | `string`       | n/a           |   yes    |
| <a name="input_image_id"></a> [image_id](#input_image_id)                                  | The EC2 golden image ID to launch                                                                      | `string`       | n/a           |   yes    |
| <a name="input_ingress_cidr_blocks"></a> [ingress_cidr_blocks](#input_ingress_cidr_blocks) | List of CIDR to acces to the website, to be defined (private :from where the user is going to access ) | `list(string)` | `[]`          |    no    |
| <a name="input_instance_type"></a> [instance_type](#input_instance_type)                   | The size of instance to launch.                                                                        | `string`       | `"t3a.small"` |    no    |
| <a name="input_max_size"></a> [max_size](#input_max_size)                                  | The maximum size of the auto scale group                                                               | `string`       | n/a           |   yes    |
| <a name="input_min_size"></a> [min_size](#input_min_size)                                  | The minimum size of the auto scale group                                                               | `string`       | n/a           |   yes    |
| <a name="input_owner"></a> [owner](#input_owner)                                           | Owner of the resource (Team mailing list).                                                             | `string`       | n/a           |   yes    |

## Outputs

No outputs.

<!-- END_TF_DOCS -->
