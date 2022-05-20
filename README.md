# terraform-ecr-multi

# Introduction 
This terraform module is used to create multiple ECR repositories in one go.

# Usage
Reference the module on your Terraform code to use it.

Example usage:
```
inputs = {
  repositories = {
    "my-ecr-repo-A" = {
      image_tag_mutability = "IMMUTABLE",
      scan_on_push = true
    },
    "my-ecr-repo-B" ={ 
      image_tag_mutability = "MUTABLE",
      scan_on_push = false
    },
  }
  default_image_tag_mutability = "IMMUTABLE"
  default_lifecycle_policy     = file("./default-lifecycle-policy.json") # File that contains a default lifecycle policy in JSON format (not included)
  default_permissions_policy   = file("./default-repo-policy.json") # File that contains a default permissions policy in JSON format (not included)
  default_tags = {
    terraform   = "true"
    environment = "development"
  }
}
```

# Build and Test
To run terratest do: `cd test && go test -v`

# Contribute
Clone the repo, make your changes, push your changes.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecr_lifecycle_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_repository.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_encryption_configuration_key"></a> [default\_encryption\_configuration\_key](#input\_default\_encryption\_configuration\_key) | Default encryption configuration for the ECR repository | `string` | `""` | no |
| <a name="input_default_encryption_configuration_type"></a> [default\_encryption\_configuration\_type](#input\_default\_encryption\_configuration\_type) | Default encryption configuration for the ECR repository | `string` | `"AES256"` | no |
| <a name="input_default_image_tag_mutability"></a> [default\_image\_tag\_mutability](#input\_default\_image\_tag\_mutability) | Default image tag mutability. Accepted values are MUTABLE or IMMUTABLE | `string` | `"IMMUTABLE"` | no |
| <a name="input_default_lifecycle_policy"></a> [default\_lifecycle\_policy](#input\_default\_lifecycle\_policy) | Default lifecycle policy for the ECR repository | `string` | `"{\n  \"rules\" : [\n    {\n      \"rulePriority\" : 1,\n      \"description\" : \"Keep last 30 images\",\n      \"selection\" : {\n        \"tagStatus\" : \"any\",\n        \"countType\" : \"imageCountMoreThan\",\n        \"countNumber\" : 30\n      },\n      \"action\" : {\n        \"type\" : \"expire\"\n      }\n    }\n  ]\n}\n"` | no |
| <a name="input_default_permissions_policy"></a> [default\_permissions\_policy](#input\_default\_permissions\_policy) | Default permissions policy for the ECR repository | `string` | `"{\n  \"Version\" : \"2008-10-17\",\n  \"Statement\" : [\n    {\n      \"Sid\" : \"\",\n      \"Effect\" : \"Allow\",\n      \"Action\" : \"ecr:PutImage\",\n      \"Principal\" : {\n        \"AWS\" : \"*\"\n      }\n    }\n  ]\n}\n"` | no |
| <a name="input_default_scan_on_push"></a> [default\_scan\_on\_push](#input\_default\_scan\_on\_push) | Whether to enable scan on push by default on images of the ECR repository | `bool` | `true` | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Tags to apply by default to the ECR repository | `map(any)` | `null` | no |
| <a name="input_repositories"></a> [repositories](#input\_repositories) | A map of repositories with their configuration | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecr_repository_arns"></a> [ecr\_repository\_arns](#output\_ecr\_repository\_arns) | The ARNs of the repositories |
| <a name="output_ecr_repository_names"></a> [ecr\_repository\_names](#output\_ecr\_repository\_names) | The names of the repositories |
| <a name="output_ecr_repository_registry_ids"></a> [ecr\_repository\_registry\_ids](#output\_ecr\_repository\_registry\_ids) | The registry IDs where the repositories were created |
| <a name="output_ecr_repository_tags_all"></a> [ecr\_repository\_tags\_all](#output\_ecr\_repository\_tags\_all) | All of the tags of the repositories |
| <a name="output_ecr_repository_urls"></a> [ecr\_repository\_urls](#output\_ecr\_repository\_urls) | The full URLs of the repositories |
<!-- END_TF_DOCS -->