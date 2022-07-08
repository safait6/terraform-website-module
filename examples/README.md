<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.42.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.42.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_studocu_website"></a> [studocu\_website](#module\_studocu\_website) | ../ | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_ami.amazon_linux](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_role_arn"></a> [aws\_role\_arn](#input\_aws\_role\_arn) | Amazon Resource Name (ARN) of the IAM Role to assume. This is provided as TFE variable. | `string` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The name of the domain to be chosen. | `string` | n/a | yes |
| <a name="input_hosted_zone"></a> [hosted\_zone](#input\_hosted\_zone) | the name of the hosted zone | `string` | n/a | yes |
| <a name="input_ingress_cidr_blocks"></a> [ingress\_cidr\_blocks](#input\_ingress\_cidr\_blocks) | List of CIDR to acces to the website, to be defined (private :from where the user is going to access ) | `list(string)` | `[]` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->